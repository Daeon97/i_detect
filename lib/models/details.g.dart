// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Details _$DetailsFromJson(Map<String, dynamic> json) => Details(
      temperature: json['temperature'] as num,
      humidity: json['humidity'] as num,
      latitude: json['lat'] as num,
      longitude: json['long'] as num,
      battery: json['battery'] as num,
    );

Map<String, dynamic> _$DetailsToJson(Details instance) => <String, dynamic>{
      'temperature': instance.temperature,
      'humidity': instance.humidity,
      'lat': instance.latitude,
      'long': instance.longitude,
      'battery': instance.battery,
    };
