import 'package:roomcard/theme/app_theme.dart';
import 'package:roomcard/utils/num_px.dart';
import 'package:roomcard/widgets/texts/text_shadow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 自带动画的默认Dialog
/// [fromOffsetY] Y轴偏移量, 介于 `-1 - 1`之间。
Future<T?> showDefaultDialog<T extends Object?>(
  BuildContext context, {
  bool barrierDismissible = true,
  double fromOffsetY = 1,
  Color barrierColor = const Color(0x80000000),
  required Widget Function(
    BuildContext context,
    Animation<double>,
    Animation<double>,
  )
  pageBuilder,
}) async {
  if (fromOffsetY < -1) fromOffsetY = -1;
  if (fromOffsetY > 1) fromOffsetY = 1;
  return await Get.generalDialog(
    barrierDismissible: barrierDismissible,
    barrierLabel: '',
    barrierColor: barrierColor,
    transitionDuration: Duration(milliseconds: 275),
    pageBuilder: (context, anim1, anim2) {
      final child = pageBuilder(context, anim1, anim2);
      debugPrint('[顶呱呱] 🐸 Open dialog -> $child');
      return child;
    },
    transitionBuilder: (_, animation, __, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: Offset(0, fromOffsetY), // 从底部（y=1）开始
          end: Offset.zero, // 滑动到顶部（y=0）
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
        child: child,
      );
    },
  );
}
