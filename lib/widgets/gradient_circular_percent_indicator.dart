import 'dart:math' as math;

import 'package:flutter/material.dart';

/// - 任务哪里的圆形3D进度条。
/// - 示例代码:
/// ``` dart
/// GradientCircularPercentIndicator(
///   percent: 0.3, // 30%
///   size: 120,
///   gradientColors: [Color(0xFFFFE082), Color(0xFFFFD54F)],
///   backgroundColor: Color(0xFF232323),
/// )
/// ```
class GradientCircularPercentIndicator extends StatelessWidget {
  final double percent; // 0.0 ~ 1.0
  final double size;
  final List<Color> gradientColors;
  final Color backgroundColor;
  final List<BoxShadow>? boxShadow;
  final TextStyle? textStyle;

  const GradientCircularPercentIndicator({
    super.key,
    required this.percent,
    this.size = 120,
    this.gradientColors = const [Color(0xFFFFE082), Color(0xFFFFD54F)],
    this.backgroundColor = const Color(0xFF232323),
    this.boxShadow,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
        boxShadow:
            boxShadow ??
            [
              BoxShadow(
                color: Colors.black.withOpacity(0.6),
                blurRadius: 16,
                offset: Offset(0, 4),
              ),
            ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ShaderMask(
            shaderCallback: (rect) {
              return SweepGradient(
                startAngle: -math.pi / 2,
                endAngle: 3 * math.pi / 2,
                colors: gradientColors,
                stops: [0.0, 1.0],
              ).createShader(rect);
            },
            child: CustomPaint(
              size: Size(size, size),
              painter: _CirclePainter(percent: percent, color: Colors.white),
            ),
          ),
          Center(
            child: Text(
              '${(percent * 100).toInt()}%',
              style:
                  textStyle ??
                  TextStyle(
                    fontSize: size * 0.28,
                    fontWeight: FontWeight.bold,
                    color: gradientColors.first,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CirclePainter extends CustomPainter {
  final double percent;
  final Color color;
  _CirclePainter({required this.percent, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = size.width * 0.13;
    final bgPaint = Paint()
      ..color = color.withOpacity(0.13)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    final fgPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    // Draw background circle
    canvas.drawArc(
      Rect.fromLTWH(
        strokeWidth / 2,
        strokeWidth / 2,
        size.width - strokeWidth,
        size.height - strokeWidth,
      ),
      0,
      2 * math.pi,
      false,
      bgPaint,
    );
    // Draw foreground arc
    canvas.drawArc(
      Rect.fromLTWH(
        strokeWidth / 2,
        strokeWidth / 2,
        size.width - strokeWidth,
        size.height - strokeWidth,
      ),
      -math.pi / 2,
      2 * math.pi * percent,
      false,
      fgPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
