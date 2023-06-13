// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:i_detect/errors/location_failure.dart';

class BottomSheetContent extends StatelessWidget {
  const BottomSheetContent({
    super.key,
    LocationFailure? locationFailure,
    String? customMessage,
    void Function()? action,
  })  : _action = action,
        _customMessage = customMessage,
        _locationFailure = locationFailure;

  final LocationFailure? _locationFailure;
  final String? _customMessage;
  final void Function()? _action;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsetsDirectional.all(
          16,
        ),
        decoration: BoxDecoration(
          color: _locationFailure != null ? Colors.red : Colors.white,
          borderRadius: const BorderRadiusDirectional.vertical(
            top: Radius.circular(
              16,
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (_locationFailure != null || _customMessage != null)
              Expanded(
                child: Text(
                  _locationFailure != null
                      ? _locationFailure!.message
                      : _customMessage!,
                  style: _locationFailure != null
                      ? const TextStyle(
                          color: Colors.white,
                        )
                      : null,
                ),
              )
            else
              const SizedBox.shrink(),
            if (_locationFailure != null || _customMessage != null)
              const SizedBox(
                width: 16,
              )
            else
              const SizedBox.shrink(),
            if (_locationFailure != null || _customMessage != null)
              ElevatedButton(
                style: _locationFailure != null
                    ? const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                          Colors.white,
                        ),
                      )
                    : null,
                onPressed: _action ?? () => Navigator.of(context).pop(),
                child: Text(
                  'Okay',
                  style: TextStyle(
                    color:
                        _locationFailure != null ? Colors.blue : Colors.white,
                  ),
                ),
              )
            else
              const SizedBox.shrink(),
          ],
        ),
      );
}
