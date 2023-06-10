// ignore_for_file: public_member_api_docs

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Data {
  const Data({
    required this.coordinates,
    required this.plateNo,
    required this.speedLimit,
  });

  final Coordinates coordinates;
  final String plateNo;
  final num speedLimit;
}

class Coordinates {
  const Coordinates({
    required this.latitude,
    required this.longitude,
  });

  final num latitude;
  final num longitude;
}
