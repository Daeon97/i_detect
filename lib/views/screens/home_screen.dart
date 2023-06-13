// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:i_detect/cubits/details_cubit/details_cubit.dart';
import 'package:i_detect/cubits/location_details_cubit/location_details_cubit.dart';
import 'package:i_detect/errors/location_failure.dart';
import 'package:i_detect/views/widgets/bottom_sheet_content.dart';
import 'package:i_detect/views/widgets/compass_view.dart';
import 'package:i_detect/views/widgets/details_view.dart';
import 'package:i_detect/views/widgets/toggler_view.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MapboxMap? _mapboxMap;
  late final ValueNotifier<AnimateTo?> _animateTo;

  @override
  void initState() {
    _animateTo = ValueNotifier<AnimateTo?>(
      null,
    );
    BlocProvider.of<LocationDetailsCubit>(context)
        .startListeningLocationDetails();
    BlocProvider.of<DetailsCubit>(context).startListeningDetails();
    super.initState();
  }

  @override
  void dispose() {
    _mapboxMap?.dispose();
    BlocProvider.of<LocationDetailsCubit>(context)
        .stopListeningLocationDetails();
    BlocProvider.of<DetailsCubit>(context).stopListeningDetails();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<LocationDetailsCubit, LocationDetailsState>(
        listener: (locationDetailsContext, locationDetailsState) {
          if (locationDetailsState is GotLocationDetailsState) {
            if (_animateTo.value == AnimateTo.userLocation) {
              _mapboxMap
                ?..easeTo(
                  CameraOptions(
                    center: Point(
                      coordinates: Position.named(
                        lat: locationDetailsState.position.latitude,
                        lng: locationDetailsState.position.longitude,
                      ),
                    ).toJson(),
                    zoom: 15,
                  ),
                  MapAnimationOptions(
                    duration: 1000,
                  ),
                )
                ..location.updateSettings(
                  LocationComponentSettings(
                    enabled: true,
                  ),
                );
            }
          } else if (locationDetailsState is FailedToGetLocationDetailsState) {
            // ignore: inference_failure_on_function_invocation
            showModalBottomSheet(
              context: context,
              isDismissible: false,
              backgroundColor: Colors.transparent,
              builder: (ctx) => BottomSheetContent(
                locationFailure: locationDetailsState.locationFailure,
                action: () {
                  switch (locationDetailsState.locationFailure.runtimeType) {
                    case LocationServiceDisabledFailure:
                      locationDetailsContext
                          .read<LocationDetailsCubit>()
                          .openSettings(
                            SettingsPageToOpen.locationSettings,
                          );
                    case LocationPermissionDeniedFailure:
                      locationDetailsContext
                          .read<LocationDetailsCubit>()
                          .startListeningLocationDetails();
                    case LocationPermissionDeniedForeverFailure:
                      locationDetailsContext
                          .read<LocationDetailsCubit>()
                          .openSettings(
                            SettingsPageToOpen.appSettings,
                          );
                    default:
                      break;
                  }
                  Navigator.of(context).pop();
                },
              ),
            );
          }
        },
        child: BlocListener<DetailsCubit, DetailsState>(
          listener: (_, detailsState) {
            if (detailsState is LoadedDetailsState) {
              if (_animateTo.value == AnimateTo.thingLocation) {
                _mapboxMap
                  ?..easeTo(
                    CameraOptions(
                      center: Point(
                        coordinates: Position.named(
                          lat: detailsState.details.latitude,
                          lng: detailsState.details.longitude,
                        ),
                      ).toJson(),
                      zoom: 15,
                    ),
                    MapAnimationOptions(
                      duration: 1000,
                    ),
                  )
                  ..location.updateSettings(
                    LocationComponentSettings(
                      enabled: true,
                    ),
                  );
              }
            }
          },
          child: Scaffold(
            body: Stack(
              children: [
                MapWidget(
                  resourceOptions: ResourceOptions(
                    accessToken: dotenv.env['MAPBOX_SECRET_TOKEN']!,
                  ),
                  onMapCreated: (mapboxMap) {
                    _mapboxMap = mapboxMap;
                  },
                  styleUri: MapboxStyles.SATELLITE_STREETS,
                ),
                ValueListenableBuilder<AnimateTo?>(
                  valueListenable: _animateTo,
                  builder: (_, animateToValue, __) => animateToValue ==
                          AnimateTo.userLocation
                      ? BlocBuilder<LocationDetailsCubit, LocationDetailsState>(
                          builder: (_, locationDetailsState) =>
                              locationDetailsState is GotLocationDetailsState
                                  ? CompassView(
                                      bearing:
                                          locationDetailsState.position.heading,
                                      heading:
                                          locationDetailsState.position.heading,
                                    )
                                  : const SizedBox.shrink(),
                        )
                      : BlocBuilder<DetailsCubit, DetailsState>(
                          builder: (_, detailsState) =>
                              detailsState is LoadedDetailsState
                                  ? DetailsView(
                                      details: detailsState.details,
                                    )
                                  : const SizedBox.shrink(),
                        ),
                ),
                TogglerView(
                  animateToListenable: _animateTo,
                ),
              ],
            ),
          ),
        ),
      );
}
