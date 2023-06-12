// ignore_for_file: public_member_api_docs

import 'package:json_annotation/json_annotation.dart';

part 'details.g.dart';

@JsonSerializable()
class Details {
  const Details({
    required this.plateNumber,
    required this.speedLimit,
    required this.latitude,
    required this.longitude,
  });

  factory Details.fromJson(Map<String, dynamic> json) =>
      _$DetailsFromJson(json);

  @JsonKey(name: 'plate_no')
  final String plateNumber;

  @JsonKey(name: 'speed')
  final num speedLimit;

  @JsonKey(name: 'lat')
  final num latitude;

  @JsonKey(name: 'lng')
  final num longitude;

  Map<String, dynamic> toJson() => _$DetailsToJson(this);
}
