// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:i_detect/cubits/efotainer_history_cubit/efotainer_history_cubit.dart';
import 'package:i_detect/resources/colors.dart';
import 'package:i_detect/resources/numbers.dart';
import 'package:i_detect/utils/extensions/google_map_convenience_utils.dart';

class BottomEndWidget extends StatelessWidget {
  const BottomEndWidget({
    required Completer<GoogleMapController> googleMapController,
    required ValueNotifier<bool> toggleHistory,
    required VoidCallback onRefresh,
    super.key,
  })  : _googleMapController = googleMapController,
        _toggleHistory = toggleHistory,
        _onRefresh = onRefresh;

  final Completer<GoogleMapController> _googleMapController;
  final ValueNotifier<bool> _toggleHistory;
  final VoidCallback _onRefresh;

  @override
  Widget build(BuildContext context) => Align(
        alignment: AlignmentDirectional.bottomEnd,
        child: Padding(
          padding: const EdgeInsetsDirectional.all(
            spacing,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocBuilder<EfotainerHistoryCubit, EfotainerHistoryState>(
                builder: (_, efotainerHistoryState) => ElevatedButton(
                  style: ButtonStyle(
                    shape: const MaterialStatePropertyAll<OutlinedBorder>(
                      CircleBorder(),
                    ),
                    backgroundColor: MaterialStatePropertyAll<Color>(
                      Theme.of(context).scaffoldBackgroundColor,
                    ),
                    padding: const MaterialStatePropertyAll<EdgeInsetsGeometry>(
                      EdgeInsetsDirectional.all(
                        spacing,
                      ),
                    ),
                    elevation: const MaterialStatePropertyAll<double>(
                      bottomEndWidgetButtonElevation,
                    ),
                  ),
                  onPressed: switch (efotainerHistoryState) {
                    LoadedEfotainerHistoryState(
                      efotainerHistory: final history,
                    ) =>
                      () async => (await _googleMapController.future)
                              .animateToAppropriateView(
                            isHistory: _toggleHistory.value,
                            data: history,
                          ),
                    _ => null,
                  },
                  child: const Icon(
                    Icons.center_focus_weak,
                    color: bottomEndWidgetButtonIconColor,
                  ),
                ),
              ),
              const SizedBox(
                height: spacing,
              ),
              BlocBuilder<EfotainerHistoryCubit, EfotainerHistoryState>(
                builder: (_, efotainerHistoryState) => ValueListenableBuilder(
                  valueListenable: _toggleHistory,
                  builder: (__, toggleHistoryValue, ___) => ElevatedButton(
                    style: ButtonStyle(
                      shape: const MaterialStatePropertyAll<OutlinedBorder>(
                        CircleBorder(),
                      ),
                      backgroundColor: MaterialStatePropertyAll<Color>(
                        switch (toggleHistoryValue) {
                          true => baseColor,
                          false => Theme.of(context).scaffoldBackgroundColor,
                        },
                      ),
                      padding:
                          const MaterialStatePropertyAll<EdgeInsetsGeometry>(
                        EdgeInsetsDirectional.all(
                          spacing,
                        ),
                      ),
                      elevation: const MaterialStatePropertyAll<double>(
                        bottomEndWidgetButtonElevation,
                      ),
                    ),
                    onPressed: switch (efotainerHistoryState) {
                      LoadedEfotainerHistoryState(
                        efotainerHistory: final history,
                      ) =>
                        () async {
                          _toggleHistory.value = !toggleHistoryValue;
                          await (await _googleMapController.future)
                              .animateToAppropriateView(
                            isHistory: _toggleHistory.value,
                            data: history,
                          );
                        },
                      _ => null,
                    },
                    child: Icon(
                      Icons.history,
                      color: switch (toggleHistoryValue) {
                        true => Theme.of(context).scaffoldBackgroundColor,
                        false => bottomEndWidgetButtonIconColor,
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: spacing,
              ),
              ElevatedButton(
                style: const ButtonStyle(
                  shape: MaterialStatePropertyAll<OutlinedBorder>(
                    CircleBorder(),
                  ),
                  backgroundColor: MaterialStatePropertyAll<Color>(
                    baseColor,
                  ),
                  padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
                    EdgeInsetsDirectional.all(
                      spacing,
                    ),
                  ),
                  elevation: MaterialStatePropertyAll<double>(
                    bottomEndWidgetButtonElevation,
                  ),
                ),
                onPressed: _onRefresh,
                child: const Icon(
                  Icons.refresh,
                ),
              ),
            ],
          ),
        ),
      );
}
