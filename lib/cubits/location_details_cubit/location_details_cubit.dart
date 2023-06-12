// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:i_detect/errors/location_failure.dart';
import 'package:i_detect/repositories/location_repository.dart';

part 'location_details_state.dart';

enum SettingsPageToOpen { appSettings, locationSettings }

class LocationDetailsCubit extends Cubit<LocationDetailsState> {
  LocationDetailsCubit({
    required LocationRepository locationRepository,
  })  : _locationRepository = locationRepository,
        super(
          const LocationDetailsInitialState(),
        );

  final LocationRepository _locationRepository;

  StreamSubscription<Either<LocationFailure, Position>>? _streamSubscription;

  void startListeningLocationDetails() {
    _gettingLocationDetails();

    if (_streamSubscription != null) {
      _streamSubscription!.cancel();
      _streamSubscription = null;
    }

    _streamSubscription = _locationRepository.location.listen(
      (
        locationFailureOrPosition,
      ) {
        locationFailureOrPosition.fold(
          _failedToGetLocationDetails,
          _gotLocationDetails,
        );
      },
    );
  }

  void _gettingLocationDetails() => emit(
        const GettingLocationDetailsState(),
      );

  void _failedToGetLocationDetails(LocationFailure locationFailure) => emit(
        FailedToGetLocationDetailsState(
          locationFailure,
        ),
      );

  void _gotLocationDetails(Position position) => emit(
        GotLocationDetailsState(
          position,
        ),
      );

  Future<bool> openSettings(
    SettingsPageToOpen settingsPageToOpen,
  ) =>
      switch (settingsPageToOpen) {
        SettingsPageToOpen.appSettings => _locationRepository.openAppSettings(),
        SettingsPageToOpen.locationSettings =>
          _locationRepository.openLocationSettings(),
      };

  void stopListeningLocationDetails() {
    if (_streamSubscription != null) {
      _streamSubscription!.cancel();
      _streamSubscription = null;
    }
  }
}
