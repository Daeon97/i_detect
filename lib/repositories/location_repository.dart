// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:i_detect/errors/location_failure.dart';
import 'package:i_detect/services/location_service.dart';

class LocationRepository {
  const LocationRepository({
    required LocationService locationService,
  }) : _locationService = locationService;

  final LocationService _locationService;

  Stream<Either<LocationFailure, Position>> get location {
    late StreamController<Either<LocationFailure, Position>> streamController;
    StreamSubscription<Position>? streamSubscription;

    streamController = StreamController<Either<LocationFailure, Position>>(
      onListen: () async {
        final locationServiceEnabled =
            await _locationService.locationServiceEnabled;

        if (!locationServiceEnabled) {
          streamController.sink.add(
            const Left(
              LocationServiceDisabledFailure(
                message: 'Turn on location service to proceed',
              ),
            ),
          );
        } else {
          final locationPermission = await _locationService.locationPermission;

          switch (locationPermission) {
            case LocationPermission.denied:
              streamController.sink.add(
                const Left(
                  LocationPermissionDeniedFailure(
                    message: 'Grant location permission to proceed',
                  ),
                ),
              );
            case LocationPermission.deniedForever:
              streamController.sink.add(
                const Left(
                  LocationPermissionDeniedForeverFailure(
                    message:
                        'Enable location permission in settings to proceed',
                  ),
                ),
              );
            case LocationPermission.whileInUse:
            case LocationPermission.always:
              streamSubscription = _computeCurrentLocation(
                streamController.sink,
              );
            case LocationPermission.unableToDetermine:
              streamController.sink.add(
                const Left(
                  LocationPermissionUnableToDetermineFailure(
                    message:
                        'Could not determine location permission status. You will not be able to use this app',
                  ),
                ),
              );
          }
        }
      },
      onCancel: () async {
        await streamSubscription?.cancel();
        await streamController.sink.close();
        await streamController.close();
      },
    );

    return streamController.stream;
  }

  StreamSubscription<Position> _computeCurrentLocation(
    StreamSink<Either<LocationFailure, Position>> streamSink,
  ) =>
      _locationService.currentPosition.listen(
        (position) {
          streamSink.add(
            Right(
              position,
            ),
          );
        },
      );

  Future<bool> openAppSettings() => _locationService.appSettings;

  Future<bool> openLocationSettings() => _locationService.locationSettings;
}
