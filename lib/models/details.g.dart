// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Details _$DetailsFromJson(Map<String, dynamic> json) => Details(
      plateNumber: json['plate_no'] as String,
      speedLimit: json['speed'] as num,
      latitude: json['lat'] as num,
      longitude: json['lng'] as num,
    );

Map<String, dynamic> _$DetailsToJson(Details instance) => <String, dynamic>{
      'plate_no': instance.plateNumber,
      'speed': instance.speedLimit,
      'lat': instance.latitude,
      'lng': instance.longitude,
    };
