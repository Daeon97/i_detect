// ignore_for_file: public_member_api_docs

abstract class BrokerFailure {
  const BrokerFailure({
    required this.message,
  });

  final String message;
}

class NoMessagesFromBrokerFailure extends BrokerFailure {
  const NoMessagesFromBrokerFailure({
    required super.message,
  });
}

class TopicSubscriptionFailure extends BrokerFailure {
  const TopicSubscriptionFailure({
    required super.message,
  });
}

class UnsolicitedDisconnectionFailure extends BrokerFailure {
  const UnsolicitedDisconnectionFailure({
    required super.message,
  });
}

class CouldNotConnectToBrokerFailure extends BrokerFailure {
  const CouldNotConnectToBrokerFailure({
    required super.message,
  });
}

class MessageTopicMismatchFailure extends BrokerFailure {
  const MessageTopicMismatchFailure({
    required super.message,
  });
}

class BadMessageFormatFailure extends BrokerFailure {
  const BadMessageFormatFailure({
    required super.message,
  });
}

class UnknownFailure extends BrokerFailure {
  const UnknownFailure({
    required super.message,
  });
}
