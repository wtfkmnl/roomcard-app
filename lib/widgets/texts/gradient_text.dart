import 'package:roomcard/theme/app_theme.dart';
import 'package:flutter/material.dart';

///文字颜色渐变。从右到左,TextStyle里的颜色会失效
///```
/// GradientText -> Text or AutoSizeText
/// ```
class GradientText extends StatelessWidget {
  final Widget child;
  final List<Color>? gradientColors;
  const GradientText({super.key, required this.child, this.gradientColors});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn, // 关键：只对文字内容应用渐变
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors:
              gradientColors ??
              [
                AppTheme().current.goldGradientColor,
                AppTheme().current.goldColor3,
              ], // 渐变颜色
          begin: Alignment.centerRight, // 渐变起点
          end: Alignment.centerLeft, // 渐变终点
        ).createShader(bounds);
      },
      child: child,
    );
  }
}
