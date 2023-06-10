// ignore_for_file: public_member_api_docs

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MapboxMapController? _mapboxMapController;

  // late final ValueNotifier<bool?> _animateToUserLocation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _mapboxMapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Placeholder(),
        // body: MapboxMap(
        //   onMapCreated: (controller) {
        //     _mapboxMapController = controller;
        //   },
        //   // compassViewPosition: CompassViewPosition.BottomRight,
        //   // compassViewMargins: const Point<int>(50, 50),
        //   styleString: MapboxStyles.SATELLITE,
        //   accessToken: dotenv.env['MAPBOX_SECRET_TOKEN'],
        //   initialCameraPosition: const CameraPosition(
        //     target: LatLng(
        //       8.9296802,
        //       7.3182658,
        //     ),
        //     zoom: 15,
        //   ),
        // ),
      );
}
