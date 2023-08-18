// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:i_detect/errors/broker_failure.dart';
import 'package:i_detect/errors/custom_exception.dart';
import 'package:i_detect/models/certificate.dart';
import 'package:i_detect/models/details.dart';
import 'package:i_detect/services/tracker_service.dart';

class TrackerRepository {
  const TrackerRepository({
    required TrackerService trackerService,
  }) : _trackerService = trackerService;

  final TrackerService _trackerService;

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
          (details) {
            streamController.sink.add(
              Right(
                details,
              ),
            );
          },
          onError: (dynamic error) {
            streamController.sink.add(
              Left(
                _computeFailure(error),
              ),
            );
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
