import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../easy_loading.dart';

class Progress extends StatefulWidget {
  final double value;

  const Progress({
    Key key,
    @required this.value,
  }) : super(key: key);

  @override
  ProgressState createState() => ProgressState();
}

class ProgressState extends State<Progress> {
  /// color of progress indicator
  final Color _color =
      EasyLoading.instance.loadingStyle == EasyLoadingStyle.custom
          ? EasyLoading.instance.progressColor
          : EasyLoading.instance.loadingStyle == EasyLoadingStyle.dark
              ? Colors.white
              : Colors.black;

  /// size of progress indicator
  final double _size = EasyLoading.instance.indicatorSize;

  /// width of progress indicator
  final double _width = EasyLoading.instance.progressWidth;

  double _value = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void updateProgress(double value) {
    setState(() {
      _value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _size,
      height: _size,
      child: _CircleProgress(
        value: _value,
        color: _color,
        width: _width,
      ),
    );
  }
}

class _CircleProgress extends ProgressIndicator {
  final double value;
  final double width;
  final Color color;

  _CircleProgress({
    @required this.value,
    @required this.width,
    @required this.color,
  });

  @override
  __CircleProgressState createState() => __CircleProgressState();
}

class __CircleProgressState extends State<_CircleProgress> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CirclePainter(
        color: widget.color,
        value: widget.value,
        width: widget.width,
      ),
    );
  }
}

class _CirclePainter extends CustomPainter {
  final Color color;
  final double value;
  final double width;

  _CirclePainter({
    @required this.color,
    @required this.value,
    @required this.width,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = width
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Offset.zero & size,
      -math.pi / 2,
      math.pi * 2 * value,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(_CirclePainter oldDelegate) => value != oldDelegate.value;
}
