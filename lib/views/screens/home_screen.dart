// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:i_detect/cubits/details_cubit/details_cubit.dart';
import 'package:i_detect/views/widgets/details_view.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MapboxMap? _mapboxMap;

  @override
  void initState() {
    BlocProvider.of<DetailsCubit>(context).startListeningDetails();
    super.initState();
  }

  @override
  void dispose() {
    BlocProvider.of<DetailsCubit>(context).stopListeningDetails();
    _mapboxMap?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<DetailsCubit, DetailsState>(
        listener: (_, detailsState) {
          if (detailsState is LoadingDetailsState) {
            // showBottomSheet(
            //     context: context,
            //     builder: (_) => Container(
            //       height: 100,
            //       color: Colors.red,
            //     ));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.red,
                content: Text(
                  'Loading',
                ),
                duration: Duration(
                  days: 1,
                ),
              ),
            );
          } else if (detailsState is LoadedDetailsState) {
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
          } else if (detailsState is FailedToLoadDetailsState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(
                  detailsState.errorMessage,
                ),
                duration: const Duration(
                  seconds: 10,
                ),
                dismissDirection: DismissDirection.horizontal,
              ),
            );
          }
        },
        child: Scaffold(
          body: Stack(
            children: [
              MapWidget(
                resourceOptions: ResourceOptions(
                  accessToken: dotenv.env['MAPBOX_SECRET_TOKEN']!,
                ),
                onMapCreated: (mapboxMap) => _mapboxMap = mapboxMap,
                styleUri: MapboxStyles.SATELLITE_STREETS,
                cameraOptions: CameraOptions(
                  center: Point(
                    coordinates: Position(
                      7.3182521,
                      8.9397816,
                    ),
                  ).toJson(),
                  zoom: 16,
                ),
              ),
              BlocBuilder<DetailsCubit, DetailsState>(
                builder: (_, detailsState) => detailsState is LoadedDetailsState
                    ? DetailsView(
                        details: detailsState.details,
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      );
}
