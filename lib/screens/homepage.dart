import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff282D41),
      appBar: AppBar(
        title: const Text("Time"),
      ),
      body: Center(
        child: CustomPaint(
          size: const Size(400, 400),
          painter: ClockPainter(),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final x = size.width;
    final y = size.height;
    final center = Offset(x / 2, y / 2);
    final radius = min(x / 2, y / 2);
    final dateTime = DateTime.now();

    var clockFacePaint = Paint()
      ..color = const Color(0xff414673)
      ..style = PaintingStyle.fill;

    var borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16;

    var secondPaint = Paint()
      ..color = Colors.amber
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    var minutePaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    var hourPaint = Paint()
      ..color = Colors.purple.shade400
      ..style = PaintingStyle.stroke
      ..strokeWidth = 11
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius - 40, clockFacePaint);
    canvas.drawCircle(center, radius - 40, borderPaint);

    final secondLine = radius - 60;
    final minuteLine = radius - 80;
    final hourLine = radius - 100;

    final secondAngle = dateTime.second * 2 * pi / 60;
    final minuteAngle = (dateTime.minute + dateTime.second / 60) * 2 * pi / 60;
    final hourAngle = (dateTime.hour + dateTime.minute / 60) * 2 * pi / 12;

    final hourX = center.dx + hourLine * cos(hourAngle - pi / 2);
    final hourY = center.dy + hourLine * sin(hourAngle - pi / 2);
    canvas.drawLine(center, Offset(hourX, hourY), hourPaint);

    final minuteX = center.dx + minuteLine * cos(minuteAngle - pi / 2);
    final minuteY = center.dy + minuteLine * sin(minuteAngle - pi / 2);
    canvas.drawLine(center, Offset(minuteX, minuteY), minutePaint);

    final secondX = center.dx + secondLine * cos(secondAngle - pi / 2);
    final secondY = center.dy + secondLine * sin(secondAngle - pi / 2);
    canvas.drawLine(center, Offset(secondX, secondY), secondPaint);

    var centerCirclePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 10, centerCirclePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
