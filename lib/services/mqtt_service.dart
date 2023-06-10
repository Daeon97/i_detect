// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:flutter/services.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttService {
  MqttService({
    required this.securityContext,
    required this.mqttServerClient,
  });

  final SecurityContext securityContext;
  final MqttServerClient mqttServerClient;

  Future<void> establishSecurityContext({
    required String rootCertificateAuthorityAssetPath,
    required String privateKeyAssetPath,
    required String deviceCertificateAssetPath,
  }) async {
    securityContext
      ..setClientAuthoritiesBytes(
        (await rootBundle.load(
          rootCertificateAuthorityAssetPath,
        ))
            .buffer
            .asUint8List(),
      )
      ..useCertificateChainBytes(
        (await rootBundle.load(
          deviceCertificateAssetPath,
        ))
            .buffer
            .asUint8List(),
      )
      ..usePrivateKeyBytes(
        (await rootBundle.load(
          privateKeyAssetPath,
        ))
            .buffer
            .asUint8List(),
      );
    mqttServerClient
      ..securityContext = securityContext
      ..secure = true;
  }

  void ensureAllOtherImportantStuffInitialized({
    required void Function() onConnectedToBroker,
    required void Function(String) onSubscribedToTopic,
    required void Function(String) onSubscriptionToTopicFailed,
    required void Function() onDisconnectedFromBroker,
    required int port,
    required int keepAlivePeriod,
    required String clientId,
    required bool enableLogging,
  }) {
    mqttServerClient
      ..logging(
        on: enableLogging,
      )
      ..port = port
      ..keepAlivePeriod = keepAlivePeriod
      ..clientIdentifier = clientId
      ..onConnected = onConnectedToBroker
      ..onSubscribed = onSubscribedToTopic
      ..onSubscribeFail = onSubscriptionToTopicFailed
      ..onDisconnected = onDisconnectedFromBroker;
  }

  Future<MqttClientConnectionStatus?> connectToBroker({
    String? username,
    String? password,
  }) =>
      mqttServerClient.connect(
        username,
        password,
      );

  void disconnectFromBroker() => mqttServerClient.disconnect();

  Stream<List<MqttReceivedMessage<MqttMessage>>>? get messagesFromBroker =>
      mqttServerClient.updates;

  Subscription? subscribeToTopic({
    required String topic,
    required MqttQos qualityOfService,
  }) =>
      mqttServerClient.subscribe(
        topic,
        qualityOfService,
      );

  void unsubscribeFromTopic({
    required String topic,
    required bool acknowledgeUnsubscription,
  }) =>
      mqttServerClient.unsubscribe(
        topic,
        expectAcknowledge: acknowledgeUnsubscription,
      );
}
