// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:i_detect/cubits/efotainer_cubit/efotainer_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final Completer<GoogleMapController> _googleMapController;

  @override
  void initState() {
    _googleMapController = Completer();
    BlocProvider.of<EfotainerCubit>(context).data;
    super.initState();
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<DetailsCubit, DetailsState>(
        listener: (_, detailsState) async {
          if (detailsState is LoadingDetailsState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.blue,
                content: Text(
                  'Loading',
                ),
                duration: Duration(
                  days: 1,
                ),
              ),
            );
          } else if (detailsState is LoadedDetailsState) {
            // await (await _googleMapController.future)
            await (await _googleMapController.future).animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: LatLng(
                    detailsState.efotainer.latitude.toDouble(),
                    detailsState.efotainer.longitude.toDouble(),
                  ),
                  zoom: 16,
                ),
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
              BlocBuilder<DetailsCubit, DetailsState>(
                builder: (_, detailsState) => FutureBuilder<BitmapDescriptor>(
                  future: BitmapDescriptor.fromAssetImage(
                    ImageConfiguration.empty,
                    'assets/images/marker_image.png',
                  ),
                  builder: (_, snapshot) => GoogleMap(
                    zoomControlsEnabled: false,
                    mapType: MapType.hybrid,
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(
                        8.9397589,
                        7.3182728,
                      ),
                      zoom: 16,
                    ),
                    onMapCreated: (googleMapController) =>
                        _googleMapController.complete(
                      googleMapController,
                    ),
                    markers: detailsState is LoadedDetailsState
                        ? <Marker>{
                            Marker(
                              markerId: const MarkerId(
                                'efortainer',
                              ),
                              position: LatLng(
                                detailsState.efotainer.latitude.toDouble(),
                                detailsState.efotainer.longitude.toDouble(),
                              ),
                              icon: switch (
                                  snapshot.hasData && snapshot.data != null) {
                                true => snapshot.data!,
                                false => BitmapDescriptor.defaultMarker,
                              },
                              infoWindow: const InfoWindow(
                                title: 'Efortainer',
                              ),
                            ),
                          }
                        : const <Marker>{},
                  ),
                ),
              ),
              // BlocBuilder<DetailsCubit, DetailsState>(
              //   builder: (_, detailsState) => detailsState is LoadedDetailsState
              //       ? DetailsView(
              //           details: detailsState.details,
              //         )
              //       : const SizedBox.shrink(),
              // ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  child: BlocBuilder<DetailsCubit, DetailsState>(
                    builder: (_, detailsState) => detailsState
                            is LoadedDetailsState
                        ? ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                Colors.black.withOpacity(
                                  0.6,
                                ),
                              ),
                              shape: const MaterialStatePropertyAll<
                                  OutlinedBorder>(
                                CircleBorder(),
                              ),
                            ),
                            onPressed: () async =>
                                (await _googleMapController.future)
                                    .animateCamera(
                              CameraUpdate.newCameraPosition(
                                CameraPosition(
                                  target: LatLng(
                                    detailsState.efotainer.latitude.toDouble(),
                                    detailsState.efotainer.longitude.toDouble(),
                                  ),
                                  zoom: 16,
                                ),
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(
                                8.0,
                              ),
                              child: Icon(
                                Icons.gps_fixed,
                                size: 32,
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
