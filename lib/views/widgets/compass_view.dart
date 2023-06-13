// ignore_for_file: public_member_api_docs

import 'dart:math';

import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart';

class CompassView extends StatefulWidget {
  const CompassView({
    required double? bearing,
    required double heading,
    super.key,
    Color foregroundColor = Colors.white,
    Color bearingColor = Colors.blue,
  })  : _bearingColor = bearingColor,
        _foregroundColor = foregroundColor,
        _heading = heading,
        _bearing = bearing;

  final double? _bearing;
  final double _heading;
  final Color _foregroundColor;
  final Color _bearingColor;

  @override
  State<CompassView> createState() => _CompassViewState();
}

class _CompassViewState extends State<CompassView> {
  @override
  Widget build(BuildContext context) => Align(
        alignment: AlignmentDirectional.topEnd,
        child: Container(
          width: 250,
          height: 250,
          margin: const EdgeInsetsDirectional.symmetric(
            vertical: 32,
            horizontal: 16,
          ),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(
              0.2,
            ),
            shape: BoxShape.circle,
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Rose Painter
              CustomPaint(
                painter: _CompassViewPainter(
                  heading: widget._heading,
                  foregroundColor: widget._foregroundColor,
                ),
              ),

              // Bearing Indicator
              if (widget._bearing != null)
                Padding(
                  padding: const EdgeInsets.all(
                    35,
                  ),
                  child: Transform.rotate(
                    angle: (widget._bearing! - widget._heading).toRadians(),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Icon(
                        CupertinoIcons.arrowtriangle_up_fill,
                        color: widget._bearingColor,
                        size: 20,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
}

class _CompassViewPainter extends CustomPainter {
  _CompassViewPainter({
    required this.heading,
    required this.foregroundColor,
    this.majorTickCount = 12,
    this.minorTickCount = 180,
    this.cardinalities = const {0: 'N', 90: 'E', 180: 'S', 270: 'W'},
  });

  final double heading;
  final Color foregroundColor;
  final int majorTickCount;
  final int minorTickCount;
  final CardinalityMap cardinalities;

  late final bearingIndicatorPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = foregroundColor
    ..strokeWidth = 4.0
    ..blendMode = BlendMode.difference;

  late final majorScalePaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = foregroundColor
    ..strokeWidth = 2.0;

  late final minorScalePaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = foregroundColor.withOpacity(0.7)
    ..strokeWidth = 1.0;

  late final majorScaleStyle = TextStyle(
    color: foregroundColor,
    fontSize: 15,
  );

  late final cardinalityStyle = TextStyle(
    color: foregroundColor,
    fontSize: 24,
  );

  late final _majorTicks = _layoutScale(majorTickCount);
  late final _minorTicks = _layoutScale(minorTickCount);

  @override
  void paint(Canvas canvas, Size size) {
    assert(size.width == size.height, 'Size must be square');
    const origin = Offset.zero;
    final center = size.center(origin);
    final radius = size.width / 2;

    const tickPadding = 55.0;
    const tickLength = 20.0;

    // paint major scale
    for (final angle in _majorTicks) {
      final tickStart = Offset.fromDirection(
        _correctedAngle(angle).toRadians(),
        radius - tickPadding,
      );

      final tickEnd = Offset.fromDirection(
        _correctedAngle(angle).toRadians(),
        radius - tickPadding - tickLength,
      );

      canvas.drawLine(
        center + tickStart,
        center + tickEnd,
        majorScalePaint,
      );
    }

    // paint minor scale
    for (final angle in _minorTicks) {
      final tickStart = Offset.fromDirection(
        _correctedAngle(angle).toRadians(),
        radius - tickPadding,
      );

      final tickEnd = Offset.fromDirection(
        _correctedAngle(angle).toRadians(),
        radius - tickPadding - tickLength,
      );

      canvas.drawLine(
        center + tickStart,
        center + tickEnd,
        minorScalePaint,
      );
    }

    // paint bearing indicator
    final tickStart = Offset.fromDirection(
      -90.toRadians(),
      radius,
    );

    final tickEnd = Offset.fromDirection(
      -90.toRadians(),
      radius - tickPadding - tickLength,
    );

    canvas.drawLine(
      center + tickStart,
      center + tickEnd,
      bearingIndicatorPaint,
    );

    // paint major scale text
    for (final angle in _majorTicks) {
      const majorScaleTextPadding = 20.0;

      final textPainter = TextSpan(
        text: angle.toStringAsFixed(0),
        style: majorScaleStyle,
      ).toPainter()
        ..layout();

      final layoutOffset = Offset.fromDirection(
        _correctedAngle(angle).toRadians(),
        radius - majorScaleTextPadding,
      );

      final offset = center + layoutOffset - textPainter.center;
      textPainter.paint(canvas, offset);
    }

    // paint cardinality text
    for (final cardinality in cardinalities.entries) {
      const majorScaleTextPadding = 100.0;

      final angle = cardinality.key.toDouble();
      final text = cardinality.value;

      final textPainter = TextSpan(
        text: text,
        style: cardinalityStyle,
      ).toPainter()
        ..layout();

      final layoutOffset = Offset.fromDirection(
        _correctedAngle(angle).toRadians(),
        radius - majorScaleTextPadding,
      );

      final offset = center + layoutOffset - textPainter.center;
      textPainter.paint(canvas, offset);
    }
  }

  @override
  bool shouldRepaint(_CompassViewPainter oldDelegate) =>
      oldDelegate.heading != heading ||
      oldDelegate.foregroundColor != foregroundColor ||
      oldDelegate.majorTickCount != majorTickCount ||
      oldDelegate.minorTickCount != minorTickCount;

  List<double> _layoutScale(int ticks) {
    final scale = 360 / ticks;
    return List.generate(ticks, (i) => i * scale);
  }

  double _correctedAngle(double angle) => angle - heading - 90;
}

typedef CardinalityMap = Map<num, String>;

extension on TextPainter {
  Offset get center => size.center(Offset.zero);
}

extension on TextSpan {
  TextPainter toPainter({TextDirection textDirection = TextDirection.ltr}) =>
      TextPainter(text: this, textDirection: textDirection);
}

extension on num {
  double toRadians() => this * pi / 180;
}
