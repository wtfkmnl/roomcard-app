import 'package:flutter/material.dart';
import 'package:roomcard/theme/app_theme.dart';
import 'package:roomcard/utils/num_px.dart';

class ConfirmButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final double? fontSize;
  final Color? textColor;
  final List<Color>? gradientColors;
  final double? borderRadius;

  const ConfirmButton({
    Key? key,
    required this.text,
    this.onTap,
    this.width,
    this.height,
    this.fontSize,
    this.textColor,
    this.gradientColors,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 48.pxh,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors ?? [
            const Color(0xFFBF9048),
            const Color(0xFFF9C678),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(borderRadius ?? 8.pxw),
        boxShadow: [
          // 内阴影 (模拟 inset)
          BoxShadow(
            color: const Color(0xFFBD8742),
            offset: const Offset(0, -2), // 上方阴影
            blurRadius: 0,
            spreadRadius: 0,
          ),
          // 外阴影
          BoxShadow(
            color: const Color(0x2EEEAE4C), // #EEAE4C2E 转换为 ARGB
            offset: const Offset(0, 4),
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius ?? 8.pxw),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: textColor ?? const Color(0xFF703E00),
                fontSize: fontSize ?? 18.pxSp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
} 