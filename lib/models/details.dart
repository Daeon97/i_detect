// ignore_for_file: public_member_api_docs

import 'package:json_annotation/json_annotation.dart';

part 'details.g.dart';

@JsonSerializable()
class Details {
  const Details({
    required this.temperature,
    required this.humidity,
    required this.latitude,
    required this.longitude,
    required this.battery,
  });

  factory Details.fromJson(Map<String, dynamic> json) =>
      _$DetailsFromJson(json);

  @JsonKey(name: 'temperature')
  final num temperature;

  @JsonKey(name: 'humidity')
  final num humidity;

  @JsonKey(name: 'lat')
  final num latitude;

  @JsonKey(name: 'long')
  final num longitude;

  @JsonKey(name: 'battery')
  final num battery;

  Map<String, dynamic> toJson() => _$DetailsToJson(this);
}
