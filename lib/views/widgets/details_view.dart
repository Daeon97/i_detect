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
          width: 140,
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
              0.6,
            ),
            borderRadius: BorderRadiusDirectional.circular(
              32,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: List<Widget>.generate(
              5,
              (index) => Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      switch (index) {
                        0 => Icons.thermostat,
                        1 => Icons.heat_pump,
                        2 => Icons.gps_not_fixed,
                        3 => Icons.gps_fixed,
                        _ => Icons.battery_std
                      },
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Text(
                        switch (index) {
                          0 => '${_details.temperature}°C',
                          1 => '${_details.humidity}%',
                          2 => '${_details.latitude}°',
                          3 => '${_details.longitude}°',
                          _ => '${_details.battery}%'
                        },
                        overflow: TextOverflow.ellipsis,
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
