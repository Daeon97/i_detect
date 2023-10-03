// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'efotainer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Efotainer _$EfotainerFromJson(Map<String, dynamic> json) => Efotainer(
      name: json['Name'] as String,
      timestamp: json['Timestamp'] as num,
      battery: json['Battery'] as num,
      coordinates:
          Coordinates.fromJson(json['Coordinates'] as Map<String, dynamic>),
      humidity: json['Humidity'] as num,
      temperature: json['Temperature'] as num,
    );

Map<String, dynamic> _$EfotainerToJson(Efotainer instance) => <String, dynamic>{
      'Name': instance.name,
      'Timestamp': instance.timestamp,
      'Battery': instance.battery,
      'Coordinates': instance.coordinates,
      'Humidity': instance.humidity,
      'Temperature': instance.temperature,
    };

Coordinates _$CoordinatesFromJson(Map<String, dynamic> json) => Coordinates(
      hash: json['Hash'] as String,
      position:
          (json['Position'] as List<dynamic>).map((e) => e as num).toList(),
    );

Map<String, dynamic> _$CoordinatesToJson(Coordinates instance) =>
    <String, dynamic>{
      'Hash': instance.hash,
      'Position': instance.position,
    };
