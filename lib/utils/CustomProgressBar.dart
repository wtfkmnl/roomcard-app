import 'package:roomcard/utils/num_px.dart';
import 'package:flutter/material.dart';
class CustomProgressBar extends StatelessWidget {
  final double progress; // 0.0 - 1.0

  const CustomProgressBar({required this.progress, super.key});

  @override
  Widget build(BuildContext context) {
    final double totalWidth = 558.pxw;
    final double barHeight = 18.pxh;

    return Stack(
      children: [
        // 背景层
        Container(
          width: totalWidth,
          height: barHeight,
          decoration: ShapeDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.47, 0.00),
              end: Alignment(0.47, 1.00),
              colors: [Color(0xFF111111), Color(0xFF333333)],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.pxw),
            ),
          ),
        ),
        // 进度层
        Container(
          width: totalWidth * progress.clamp(0.0, 1.0),
          height: barHeight,
          decoration: ShapeDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.77, 0.00),
              end: Alignment(0.50, 1.00),
              colors: [Color(0xFFF9DC81), Color(0xFFF7C038)],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.pxw),
            ),
            shadows: [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 6,
                offset: Offset(3, 3),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
