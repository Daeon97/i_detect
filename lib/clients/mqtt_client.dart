// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:flutter/services.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttClient {
  MqttClient({
    required SecurityContext securityContext,
    required MqttServerClient mqttServerClient,
  })  : _mqttServerClient = mqttServerClient,
        _securityContext = securityContext;

  final SecurityContext _securityContext;
  final MqttServerClient _mqttServerClient;

  Future<void> establishSecurityContext({
    required String rootCertificateAuthorityAssetPath,
    required String privateKeyAssetPath,
    required String deviceCertificateAssetPath,
  }) async {
    _securityContext
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
    _mqttServerClient
      ..securityContext = _securityContext
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
    _mqttServerClient
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
      _mqttServerClient.connect(
        username,
        password,
      );

  void disconnectFromBroker() => _mqttServerClient.disconnect();

  Stream<List<MqttReceivedMessage<MqttMessage>>>? get messagesFromBroker =>
      _mqttServerClient.updates;

  Subscription? subscribeToTopic({
    required String topic,
    required MqttQos qualityOfService,
  }) =>
      _mqttServerClient.subscribe(
        topic,
        qualityOfService,
      );

  void unsubscribeFromTopic({
    required String topic,
    required bool acknowledgeUnsubscription,
  }) =>
      _mqttServerClient.unsubscribe(
        topic,
        expectAcknowledge: acknowledgeUnsubscription,
      );
}
