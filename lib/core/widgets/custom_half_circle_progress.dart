import 'dart:math';
import 'package:flutter/material.dart';



class CustomHalfCircleProgress extends StatelessWidget {
  final double size;
  final double percentage;

   CustomHalfCircleProgress({required this.size, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size / 2),
      painter: HalfCircleProgressPainter(percentage: percentage),
      child: Center(
        child: Text(
          '${percentage.toInt()}%',
          style: TextStyle(
            fontSize: size / 5,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class HalfCircleProgressPainter extends CustomPainter {
  final double percentage;

  HalfCircleProgressPainter({required this.percentage});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint backgroundPaint = Paint()
      ..color = Colors.grey[800]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width / 15;

    final Paint progressPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width / 15
      ..strokeCap = StrokeCap.round;

    final double radius = size.width / 2;
    final double startAngle = pi;
    final double sweepAngle = (pi * (percentage / 100));

    canvas.drawArc(Rect.fromCircle(center: Offset(size.width / 2, size.height), radius: radius), startAngle, pi, false, backgroundPaint);
    canvas.drawArc(Rect.fromCircle(center: Offset(size.width / 2, size.height), radius: radius), startAngle, sweepAngle, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
