import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final List<Color>? gradientColors;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;

  const GradientButton({
    super.key,
    required this.text,
    this.onTap,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.gradientColors,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.borderRadius,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin ?? EdgeInsets.symmetric(horizontal: 16.w),
        width: width ?? double.infinity,
        height: height ?? 43.h,
        padding: padding ?? EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 8.h,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors ?? [const Color(0xFFBF9048), const Color(0xFFF9C678)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: borderRadius ?? BorderRadius.circular(8.r),
          boxShadow: boxShadow,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor ?? const Color(0xFF703E00),
              fontSize: fontSize ?? 18.sp,
              fontWeight: fontWeight ?? FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}