import 'package:roomcard/theme/app_theme.dart';
import 'package:roomcard/utils/common_extension/common_extension.dart';
import 'package:roomcard/utils/num_px.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NetworkListenToast extends StatelessWidget {
  const NetworkListenToast({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 522.pxw,
        height: 183.pxh,
        decoration: BoxDecoration(
          color: '#444444'.hexToColor.withValues(alpha: 0.95),
          borderRadius: BorderRadius.circular(30.pxw),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 21.pxw,
          children: [
            Lottie.asset(
              'assets/lottie/no_network.json',
              width: 60.pxw,
              height: 60.pxh,
            ),
            Text(
              '网络连接中...',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppTheme().current.textColor1 /* 文字-1级 */,
                fontSize: 45.pxSp,
                height: 1.40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
