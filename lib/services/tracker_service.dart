// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:i_detect/errors/custom_exception.dart';
import 'package:i_detect/models/certificate.dart';
import 'package:i_detect/models/details.dart';
import 'package:i_detect/services/mqtt_service.dart';
import 'package:mqtt_client/mqtt_client.dart';

class TrackerService {
  const TrackerService({
    required MqttService mqttService,
  }) : _mqttService = mqttService;

  final MqttService _mqttService;

  Stream<Details> messageStream({
    required String topic,
    required int port,
    required int keepAlivePeriod,
    required String clientId,
    required Certificate certificate,
  }) {
    late StreamController<Details> streamController;
    StreamSubscription<List<MqttReceivedMessage<MqttMessage>>>?
        mqttReceivedMessagesStreamSubscription;

    streamController = StreamController<Details>(
      onListen: () async {
        await _mqttService.establishSecurityContext(
          rootCertificateAuthorityAssetPath:
              certificate.rootCertificateAuthorityAssetPath,
          privateKeyAssetPath: certificate.privateKeyAssetPath,
          deviceCertificateAssetPath: certificate.deviceCertificateAssetPath,
        );
        _mqttService.ensureAllOtherImportantStuffInitialized(
          enableLogging: kDebugMode,
          port: port,
          keepAlivePeriod: keepAlivePeriod,
          clientId: clientId,
          onConnectedToBroker: () => _onConnectedToBroker(
            topic,
          ),
          onSubscribedToTopic: (_) {
            mqttReceivedMessagesStreamSubscription = _onSubscribedToTopic(
              topic,
              streamController.sink,
            );
          },
          onSubscriptionToTopicFailed: (_) => _onSubscriptionToTopicFailed(
            streamController.sink,
          ),
          onDisconnectedFromBroker: () => _onDisconnectedFromBroker(
            streamController.sink,
          ),
        );

        try {
          final connectionStatus = await _mqttService.connectToBroker();

          if (connectionStatus?.state != MqttConnectionState.connecting &&
              connectionStatus?.state != MqttConnectionState.connected) {
            streamController.sink.addError(
              const CouldNotConnectToBrokerException(
                message: 'Connection to broker failed',
              ),
            );
          }
        } catch (_) {
          streamController.sink.addError(
            const CouldNotConnectToBrokerException(
              message: 'Unable to connect to broker',
            ),
          );
        }
      },
      onCancel: () async {
        await mqttReceivedMessagesStreamSubscription?.cancel();
        await streamController.sink.close();
        await streamController.close();
        _mqttService.disconnectFromBroker();
      },
    );
    return streamController.stream;
  }

  void _onConnectedToBroker(
    String topic,
  ) {
    _mqttService.subscribeToTopic(
      topic: topic,
      qualityOfService: MqttQos.atMostOnce,
    );
  }

  StreamSubscription<List<MqttReceivedMessage<MqttMessage>>>?
      _onSubscribedToTopic(
    String topic,
    StreamSink<Details> streamSink,
  ) {
    StreamSubscription<List<MqttReceivedMessage<MqttMessage>>>?
        mqttReceivedMessagesStreamSubscription;
    final messagesFromBroker = _mqttService.messagesFromBroker;

    if (messagesFromBroker != null) {
      mqttReceivedMessagesStreamSubscription = messagesFromBroker.listen(
        (mqttReceivedMessages) {
          for (final mqttReceivedMessage in mqttReceivedMessages) {
            if (mqttReceivedMessage.topic == topic) {
              try {
                final publishedMessage =
                    mqttReceivedMessage.payload as MqttPublishMessage;
                final uint8Buffer = publishedMessage.payload.message;
                final uint8List = Uint8List.view(
                  uint8Buffer.buffer,
                );
                final utf8Decoded = utf8.decode(
                  uint8List,
                );
                final json = jsonDecode(utf8Decoded) as Map<String, dynamic>;
                streamSink.add(
                  Details.fromJson(
                    json,
                  ),
                );
              } catch (_) {
                streamSink.addError(
                  const BadMessageFormatException(
                    message: 'Received message was badly formatted',
                  ),
                );
              }
            } else {
              streamSink.addError(
                const MessageTopicMismatchException(
                  message:
                      'Received message topic does not correspond with current topic',
                ),
              );
            }
          }
        },
      );
    } else {
      streamSink.addError(
        const NoMessagesFromBrokerException(
          message: 'No data',
        ),
      );
    }

    return mqttReceivedMessagesStreamSubscription;
  }

  void _onSubscriptionToTopicFailed(
    StreamSink<Details> streamSink,
  ) {
    streamSink.addError(
      const TopicSubscriptionException(
        message: 'There was an issue subscribing to the appropriate topic',
      ),
    );
  }

  void _onDisconnectedFromBroker(
    StreamSink<Details> streamSink,
  ) {
    streamSink.addError(
      const UnsolicitedDisconnectionException(
        message: 'Client unexpectedly disconnected',
      ),
    );
  }
}
