// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:i_detect/resources/numbers.dart';

class BatteryLevelIconWidget extends StatelessWidget {
  const BatteryLevelIconWidget({
    required this.batteryLevel,
    super.key,
  });

  final num batteryLevel;

  @override
  Widget build(BuildContext context) {
    late IconData iconData;

    if (batteryLevel <= twentyPercent) {
      iconData = Icons.battery_0_bar;
    } else if (batteryLevel > twentyPercent && batteryLevel <= thirtyPercent) {
      iconData = Icons.battery_1_bar;
    } else if (batteryLevel > thirtyPercent && batteryLevel <= fortyPercent) {
      iconData = Icons.battery_2_bar;
    } else if (batteryLevel > fortyPercent && batteryLevel <= fiftyPercent) {
      iconData = Icons.battery_3_bar;
    } else if (batteryLevel > fiftyPercent && batteryLevel <= sixtyPercent) {
      iconData = Icons.battery_4_bar;
    } else if (batteryLevel > sixtyPercent && batteryLevel <= seventyPercent) {
      iconData = Icons.battery_5_bar;
    } else if (batteryLevel > seventyPercent && batteryLevel <= eightyPercent) {
      iconData = Icons.battery_6_bar;
    } else {
      iconData = Icons.battery_full;
    }

    return Icon(
      iconData,
    );
  }
}
