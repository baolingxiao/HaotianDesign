import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../theme/app_theme.dart';

class ProgressRing extends StatelessWidget {
  final double percentage; // 0-100
  final double size;
  final double strokeWidth;

  const ProgressRing({
    super.key,
    required this.percentage,
    this.size = 120,
    this.strokeWidth = 12,
  });

  @override
  Widget build(BuildContext context) {
    final radius = (size - strokeWidth) / 2;
    final circumference = radius * 2 * math.pi;
    final offset = circumference - (percentage / 100) * circumference;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.rotate(
            angle: -math.pi / 2,
            child: CustomPaint(
              size: Size(size, size),
              painter: _ProgressRingPainter(
                percentage: percentage,
                size: size,
                strokeWidth: strokeWidth,
                radius: radius,
                circumference: circumference,
                offset: offset,
              ),
            ),
          ),
          Text(
            '${percentage.round()}%',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: AppTheme.foreground,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressRingPainter extends CustomPainter {
  final double percentage;
  final double size;
  final double strokeWidth;
  final double radius;
  final double circumference;
  final double offset;

  _ProgressRingPainter({
    required this.percentage,
    required this.size,
    required this.strokeWidth,
    required this.radius,
    required this.circumference,
    required this.offset,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(this.size / 2, this.size / 2);

    // 背景圆环
    final backgroundPaint = Paint()
      ..color = AppTheme.progressTrack
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, radius, backgroundPaint);

    // 进度圆环
    final progressPaint = Paint()
      ..color = AppTheme.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final progressPath = Path()
      ..addArc(
        Rect.fromCircle(center: center, radius: radius),
        0,
        2 * math.pi * (percentage / 100),
      );

    canvas.drawPath(progressPath, progressPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}


