// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:i_detect/errors/location_failure.dart';

class BottomSheetContent extends StatelessWidget {
  const BottomSheetContent({
    super.key,
    this.locationFailure,
    this.customMessage,
    this.action,
  });

  final LocationFailure? locationFailure;
  final String? customMessage;
  final void Function()? action;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsetsDirectional.all(
          16,
        ),
        decoration: BoxDecoration(
          color: locationFailure != null ? Colors.red : Colors.white,
          borderRadius: const BorderRadiusDirectional.vertical(
            top: Radius.circular(
              16,
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (locationFailure != null || customMessage != null)
              Expanded(
                child: Text(
                  locationFailure != null
                      ? locationFailure!.message
                      : customMessage!,
                  style: locationFailure != null
                      ? const TextStyle(
                          color: Colors.white,
                        )
                      : null,
                ),
              )
            else
              const SizedBox.shrink(),
            if (locationFailure != null || customMessage != null)
              const SizedBox(
                width: 16,
              )
            else
              const SizedBox.shrink(),
            if (locationFailure != null || customMessage != null)
              ElevatedButton(
                style: locationFailure != null
                    ? const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                          Colors.white,
                        ),
                      )
                    : null,
                onPressed: action ?? () => Navigator.of(context).pop(),
                child: Text(
                  'Okay',
                  style: TextStyle(
                    color: locationFailure != null ? Colors.blue : Colors.white,
                  ),
                ),
              )
            else
              const SizedBox.shrink(),
          ],
        ),
      );
}
