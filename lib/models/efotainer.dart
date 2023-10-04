// ignore_for_file: public_member_api_docs

import 'package:i_detect/resources/strings.dart' as strings;
import 'package:json_annotation/json_annotation.dart';

part 'efotainer.g.dart';

@JsonSerializable()
final class Efotainer {
  const Efotainer({
    this.name,
    this.timestamp,
    this.battery,
    this.coordinates,
    this.humidity,
    this.temperature,
  });

  factory Efotainer.fromJson(Map<String, dynamic> json) =>
      _$EfotainerFromJson(json);

  @JsonKey(name: strings.name)
  final String? name;

  @JsonKey(name: strings.timestamp)
  final num? timestamp;

  @JsonKey(name: strings.battery)
  final num? battery;

  @JsonKey(name: strings.coordinates)
  final Coordinates? coordinates;

  @JsonKey(name: strings.humidity)
  final num? humidity;

  @JsonKey(name: strings.temperature)
  final num? temperature;

  Map<String, dynamic> toJson() => _$EfotainerToJson(this);
}

@JsonSerializable()
final class Coordinates {
  const Coordinates({
    this.hash,
    this.position,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) =>
      _$CoordinatesFromJson(json);

  @JsonKey(name: strings.hash)
  final String? hash;

  @JsonKey(name: strings.position)
  final List<num>? position;

  Map<String, dynamic> toJson() => _$CoordinatesToJson(this);
}
