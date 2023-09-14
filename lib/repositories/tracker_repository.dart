// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:i_detect/errors/broker_failure.dart';
import 'package:i_detect/errors/custom_exception.dart';
import 'package:i_detect/models/certificate.dart';
import 'package:i_detect/models/details.dart';
import 'package:i_detect/services/storage_service.dart';
import 'package:i_detect/services/tracker_service.dart';

class TrackerRepository {
  const TrackerRepository({
    required TrackerService trackerService,
    required StorageService storageService,
  })  : _trackerService = trackerService,
        _storageService = storageService;

  final TrackerService _trackerService;
  final StorageService _storageService;

  Stream<Either<BrokerFailure, Details>> get trackerStream {
    final topic = dotenv.env['TOPIC']!;
    const port = 8883;
    const keepAlivePeriod = 20;
    const clientId = 'efotainer';

    const certificatesPath = 'assets/certificates';

    const deviceCertificateAssetPath =
        '$certificatesPath/device_certificate.pem.crt';
    const privateKeyAssetPath = '$certificatesPath/private_key.pem.key';
    const rootCertificateAuthorityAssetPath =
        '$certificatesPath/root_certificate_authority.pem';

    const certificate = Certificate(
      rootCertificateAuthorityAssetPath: rootCertificateAuthorityAssetPath,
      privateKeyAssetPath: privateKeyAssetPath,
      deviceCertificateAssetPath: deviceCertificateAssetPath,
    );

    late StreamController<Either<BrokerFailure, Details>> streamController;
    late StreamSubscription<Details> streamSubscription;

    streamController = StreamController<Either<BrokerFailure, Details>>(
      onListen: () {
        streamSubscription = _trackerService
            .messageStream(
          topic: topic,
          port: port,
          keepAlivePeriod: keepAlivePeriod,
          clientId: clientId,
          certificate: certificate,
        )
            .listen(
          (details) async {
            final jsonString = jsonEncode(
              details.toJson(),
            );
            await _storageService.write(
              key: 'details',
              value: jsonString,
            );
            streamController.sink.add(
              Right(
                details,
              ),
            );
          },
          onError: (dynamic error) async {
            final brokerFailure = _computeFailure(error);
            final jsonString = await _storageService.read('details');

            if (brokerFailure is NoMessagesFromBrokerFailure &&
                jsonString != null) {
              final json = jsonDecode(jsonString) as Map<String, dynamic>;
              streamController.sink.add(
                Right(
                  Details.fromJson(
                    json,
                  ),
                ),
              );
            } else {
              streamController.sink.add(
                Left(
                  brokerFailure,
                ),
              );
            }
          },
        );
      },
      onCancel: () async {
        await streamSubscription.cancel();
        await streamController.sink.close();
        await streamController.close();
      },
    );
    return streamController.stream;
  }

  BrokerFailure _computeFailure(dynamic error) {
    late BrokerFailure failure;

    switch (error.runtimeType) {
      case NoMessagesFromBrokerException:
        failure = NoMessagesFromBrokerFailure(
          message: (error as NoMessagesFromBrokerException).message,
        );
      case TopicSubscriptionException:
        failure = TopicSubscriptionFailure(
          message: (error as TopicSubscriptionException).message,
        );
      case UnsolicitedDisconnectionException:
        failure = UnsolicitedDisconnectionFailure(
          message: (error as UnsolicitedDisconnectionException).message,
        );
      case CouldNotConnectToBrokerException:
        failure = CouldNotConnectToBrokerFailure(
          message: (error as CouldNotConnectToBrokerException).message,
        );
      case MessageTopicMismatchException:
        failure = MessageTopicMismatchFailure(
          message: (error as MessageTopicMismatchException).message,
        );
      case BadMessageFormatException:
        failure = BadMessageFormatFailure(
          message: (error as BadMessageFormatException).message,
        );
      default:
        failure = const UnknownFailure(
          message: 'An unknown error occurred',
        );
        break;
    }

    return failure;
  }
}
