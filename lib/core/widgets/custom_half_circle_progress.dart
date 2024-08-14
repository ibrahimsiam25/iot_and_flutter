import 'dart:math';
import 'package:flutter/material.dart';

class CustomHalfCircleProgress extends StatelessWidget {
  final int  percentage;

  CustomHalfCircleProgress({required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomPaint(
        painter: HalfCircleProgressPainter(percentage: percentage),
      ),
    );
  }
}

class HalfCircleProgressPainter extends CustomPainter {
  final int percentage;

  HalfCircleProgressPainter({required this.percentage});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint backgroundPaint = Paint()
      ..color = Colors.grey[800]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width / 15;

    final Rect rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height),
      radius: size.width / 2.5,
    );

    final Gradient gradient = LinearGradient(
      colors: [
        Color(0xff5ea0fe),
        Color(0xffa8e2ed),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    final Paint progressPaint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width / 15
      ..strokeCap = StrokeCap.round;

    final double radius = size.width / 2.5;
    final double startAngle = pi;
    final double sweepAngle = (pi * (percentage / 100));

    // Draw the background arc
    canvas.drawArc(
      Rect.fromCircle(center: Offset(size.width / 2, size.height), radius: radius),
      startAngle,
      pi,
      false,
      backgroundPaint,
    );

    // Draw the gradient progress arc
    canvas.drawArc(
      Rect.fromCircle(center: Offset(size.width / 2, size.height), radius: radius),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
