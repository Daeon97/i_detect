// ignore_for_file: public_member_api_docs

part of 'location_details_cubit.dart';

abstract class LocationDetailsState extends Equatable {
  const LocationDetailsState();

  @override
  List<Object> get props => [];
}

class LocationDetailsInitialState extends LocationDetailsState {
  const LocationDetailsInitialState();

  @override
  List<Object> get props => [];
}

class GettingLocationDetailsState extends LocationDetailsState {
  const GettingLocationDetailsState();

  @override
  List<Object> get props => [];
}

class GotLocationDetailsState extends LocationDetailsState {
  const GotLocationDetailsState(
    this.position,
  );

  final Position position;

  @override
  List<Object> get props => [
        position,
      ];
}

class FailedToGetLocationDetailsState extends LocationDetailsState {
  const FailedToGetLocationDetailsState(
    this.locationFailure,
  );

  final LocationFailure locationFailure;

  @override
  List<Object> get props => [
        locationFailure,
      ];
}
