// ignore_for_file: public_member_api_docs

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:i_detect/models/efotainer.dart';
import 'package:i_detect/resources/numbers.dart';

extension GoogleMapConvenienceUtils on GoogleMapController {
  Future<void> animateToAppropriateView({
    required bool isHistory,
    required List<Efotainer> data,
  }) =>
      animateCamera(
        switch (isHistory) {
          true => CameraUpdate.newLatLngBounds(
              LatLngBoundsConvenienceUtils.fromLatLngList(
                data
                    .map(
                      (efotainer) => LatLng(
                        efotainer.coordinates!.position!.first.toDouble(),
                        efotainer.coordinates!.position!.last.toDouble(),
                      ),
                    )
                    .toList(),
              ),
              boundingBoxPadding,
            ),
          false => CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(
                  data.last.coordinates!.position!.first.toDouble(),
                  data.last.coordinates!.position!.last.toDouble(),
                ),
                zoom: defaultZoom,
              ),
            ),
        },
      );
}

extension LatLngBoundsConvenienceUtils on LatLngBounds {
  static LatLngBounds fromLatLngList(
    List<LatLng> latLngList,
  ) {
    double? x0;
    late double x1;
    late double y0;
    late double y1;

    for (final latLng in latLngList) {
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1) y1 = latLng.longitude;
        if (latLng.longitude < y0) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(
      northeast: LatLng(
        x1,
        y1,
      ),
      southwest: LatLng(
        x0!,
        y0,
      ),
    );
  }
}
