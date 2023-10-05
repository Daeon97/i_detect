// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:i_detect/cubits/efotainer_history_cubit/efotainer_history_cubit.dart';
import 'package:i_detect/models/efotainer.dart';
import 'package:i_detect/resources/numbers.dart';
import 'package:i_detect/resources/strings.dart';
import 'package:i_detect/utils/enums.dart' as enums;
import 'package:i_detect/utils/extensions/google_map_convenience_utils.dart';
import 'package:i_detect/utils/helpers/time_util.dart';
import 'package:i_detect/views/widgets/bottom_end_widget.dart';
import 'package:i_detect/views/widgets/params_display_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final Completer<GoogleMapController> _googleMapController;
  late final ValueNotifier<bool> _toggleHistory;
  late final ValueNotifier<Efotainer?> _selected;

  @override
  void initState() {
    _googleMapController = Completer<GoogleMapController>();
    _toggleHistory = ValueNotifier<bool>(
      false,
    );
    _selected = ValueNotifier<Efotainer?>(
      null,
    );
    _history;
    super.initState();
  }

  @override
  void dispose() {
    _toggleHistory.dispose();
    _selected.dispose();
    super.dispose();
  }

  void get _history =>
      BlocProvider.of<EfotainerHistoryCubit>(context).getHistory(
        fields: _fields,
      );

  List<enums.Field> get _fields => [
        enums.Field.name,
        enums.Field.timestamp,
        enums.Field.battery,
        enums.Field.hash,
        enums.Field.position,
        enums.Field.humidity,
        enums.Field.temperature,
      ];

  @override
  Widget build(BuildContext context) =>
      BlocListener<EfotainerHistoryCubit, EfotainerHistoryState>(
        listener: (_, efotainerHistoryState) async {
          if (efotainerHistoryState is FailedToLoadEfotainerHistoryState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Theme.of(context).colorScheme.error,
                content: Text(
                  efotainerHistoryState.failure.reason,
                ),
                duration: const Duration(
                  hours: snackBarDurationHours,
                ),
                dismissDirection: DismissDirection.horizontal,
                action: SnackBarAction(
                  label: retry,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  onPressed: () => _history,
                ),
              ),
            );
          } else if (efotainerHistoryState is LoadedEfotainerHistoryState) {
            await (await _googleMapController.future).animateToAppropriateView(
              isHistory: _toggleHistory.value,
              data: efotainerHistoryState.efotainerHistory,
            );
          }
        },
        child: Scaffold(
          body: Stack(
            children: [
              FutureBuilder<BitmapDescriptor>(
                future: BitmapDescriptor.fromAssetImage(
                  ImageConfiguration.empty,
                  markerImagePath,
                ),
                builder: (
                  _,
                  bitmapDescriptorSnapshot,
                ) =>
                    BlocBuilder<EfotainerHistoryCubit, EfotainerHistoryState>(
                  builder: (_, efotainerHistoryState) => ValueListenableBuilder(
                    valueListenable: _toggleHistory,
                    builder: (__, toggleHistoryValue, ___) => GoogleMap(
                      zoomControlsEnabled: false,
                      initialCameraPosition: const CameraPosition(
                        target: LatLng(
                          defaultLat,
                          defaultLong,
                        ),
                        zoom: defaultZoom,
                      ),
                      onMapCreated: (googleMapController) =>
                          _googleMapController.complete(
                        googleMapController,
                      ),
                      markers: switch (efotainerHistoryState) {
                        LoadedEfotainerHistoryState(
                          efotainerHistory: final history,
                        )
                            when toggleHistoryValue =>
                          history
                              .map(
                                (efotainer) => Marker(
                                  markerId: MarkerId(
                                    efotainer.coordinates!.hash!,
                                  ),
                                  position: LatLng(
                                    efotainer.coordinates!.position!.first
                                        .toDouble(),
                                    efotainer.coordinates!.position!.last
                                        .toDouble(),
                                  ),
                                  icon: switch (bitmapDescriptorSnapshot
                                          .hasData &&
                                      bitmapDescriptorSnapshot.data != null) {
                                    true => bitmapDescriptorSnapshot.data!,
                                    false => BitmapDescriptor.defaultMarker,
                                  },
                                  infoWindow: InfoWindow(
                                    title: asAt +
                                        whiteSpace +
                                        TimeUtil.computeDayMonthYear(
                                          efotainer.timestamp!,
                                        ),
                                  ),
                                  onTap: () => _selected.value = efotainer,
                                ),
                              )
                              .toSet(),
                        LoadedEfotainerHistoryState(
                          efotainerHistory: final history,
                        )
                            when !toggleHistoryValue =>
                          <Marker>{
                            Marker(
                              markerId: MarkerId(
                                history.last.coordinates!.hash!,
                              ),
                              position: LatLng(
                                history.last.coordinates!.position!.first
                                    .toDouble(),
                                history.last.coordinates!.position!.last
                                    .toDouble(),
                              ),
                              icon: switch (bitmapDescriptorSnapshot.hasData &&
                                  bitmapDescriptorSnapshot.data != null) {
                                true => bitmapDescriptorSnapshot.data!,
                                false => BitmapDescriptor.defaultMarker,
                              },
                              infoWindow: InfoWindow(
                                title: asAt +
                                    whiteSpace +
                                    TimeUtil.computeDayMonthYear(
                                      history.last.timestamp!,
                                    ),
                              ),
                              onTap: () => _selected.value = null,
                            ),
                          },
                        _ => const <Marker>{},
                      },
                    ),
                  ),
                ),
              ),
              ParamsDisplayWidget(
                selected: _selected,
              ),
              BottomEndWidget(
                googleMapController: _googleMapController,
                toggleHistory: _toggleHistory,
                onRefresh: () => _history,
              ),
            ],
          ),
        ),
      );
}
