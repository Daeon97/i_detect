// ignore_for_file: public_member_api_docs

import 'package:geolocator/geolocator.dart';

class LocationService {
  const LocationService();

  Future<bool> get locationServiceEnabled =>
      Geolocator.isLocationServiceEnabled();

  Future<LocationPermission> get locationPermission =>
      Geolocator.requestPermission();

  Stream<Position> get currentPosition => Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.bestForNavigation,
        ),
      );

  Future<bool> get appSettings => Geolocator.openAppSettings();

  Future<bool> get locationSettings => Geolocator.openLocationSettings();
}
