import 'package:roomcard/utils/num_px.dart';
import 'package:flutter/material.dart';

enum YellowButtonSize { small, middle, large }

class YellowButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final YellowButtonSize size;

  const YellowButton({
    super.key,
    required this.text,
    this.onTap,
    this.size = YellowButtonSize.small,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: Stack(
        children: [
          Image.asset(switch (size) {
            YellowButtonSize.small => 'assets/images/public/按钮.png',
            YellowButtonSize.middle => 'assets/images/public/按钮中.png',
            YellowButtonSize.large => 'assets/images/public/按钮大.png',
          }, fit: BoxFit.fitWidth),
          Positioned(
            top: 0,
            bottom: 30.pxh,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF151515) /* 文字-按钮内 */,
                  fontSize: 48.pxSp,
                  fontWeight: FontWeight.w600,
                  height: 1.38,
                  shadows: [
                    Shadow(
                      offset: Offset(0, 3.pxh),
                      blurRadius: 0,
                      color: Color(0xFFFEE797),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
