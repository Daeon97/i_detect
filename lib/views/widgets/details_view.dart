// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:i_detect/models/details.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({
    required Details details,
    super.key,
  }) : _details = details;

  final Details _details;

  @override
  Widget build(BuildContext context) => Align(
        alignment: AlignmentDirectional.topEnd,
        child: Container(
          width: 250,
          height: 170,
          margin: const EdgeInsetsDirectional.symmetric(
            vertical: 32,
            horizontal: 16,
          ),
          padding: const EdgeInsetsDirectional.all(
            16,
          ),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(
              0.2,
            ),
            borderRadius: BorderRadiusDirectional.circular(
              32,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: List<Widget>.generate(
              4,
              (index) => Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      switch (index) {
                        0 => Icons.numbers,
                        1 => Icons.speed,
                        2 => Icons.gps_not_fixed,
                        _ => Icons.gps_fixed
                      },
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Text(
                        switch (index) {
                          0 => 'Plate Number: ${_details.plateNumber}',
                          1 => 'Current Speed: ${_details.speedLimit} Km/hr',
                          2 => 'Current Latitude: ${_details.latitude} °E/W',
                          _ => 'Current Longitude: ${_details.longitude} °N/S'
                        },
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
