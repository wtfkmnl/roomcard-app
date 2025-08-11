import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 自定义开关组件
class CustomSwitch extends StatelessWidget {
  /// 开关状态
  final bool value;
  
  final ValueChanged<bool> onChanged;
  
  final double? width;
  
  final double? height;
  
  final Color? activeThumbColor;
  
  final Color? activeTrackColor;
  
  final Color? inactiveThumbColor;
  
  final Color? inactiveTrackColor;
  final Duration? animationDuration;
  
  final double? thumbMargin;

  const CustomSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.width,
    this.height,
    this.activeThumbColor,
    this.activeTrackColor,
    this.inactiveThumbColor,
    this.inactiveTrackColor,
    this.animationDuration,
    this.thumbMargin,
  });

  @override
  Widget build(BuildContext context) {
    final switchWidth = width ?? 52.w;
    final switchHeight = height ?? 22.h;
    final margin = thumbMargin ?? 2.w;
    final thumbSize = switchHeight - (margin * 2);
    
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        width: switchWidth,
        height: switchHeight,
        decoration: BoxDecoration(
          color: value 
              ? (activeTrackColor ?? Color(0x2917CD72))
              : (inactiveTrackColor ?? Color(0xFF1A2E3C)),
          borderRadius: BorderRadius.circular(switchHeight / 2),
        ),
        child: AnimatedAlign(
          duration: animationDuration ?? Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: thumbSize,
            height: thumbSize,
            margin: EdgeInsets.all(margin),
            decoration: BoxDecoration(
              color: value 
                  ? (activeThumbColor ?? Color(0xFF17CD72))
                  : (inactiveThumbColor ?? Color(0xFF445F6E)),
              borderRadius: BorderRadius.circular(thumbSize / 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}