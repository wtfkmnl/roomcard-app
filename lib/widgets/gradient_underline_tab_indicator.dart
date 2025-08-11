import 'package:roomcard/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class GradientUnderlineTabIndicator extends Decoration {
  final Gradient? gradient;
  final BorderSide borderSide;
  final List<String> texts;
  ///计算宽度
  final double fontSize;
  final TabController controller;

  ///实际上决定了宽度
  ///```
  /// EdgeInsets.symmetric(horizontal: 30.0),
  ///```
  final EdgeInsetsGeometry insets;
  final double radius; // 新增圆角参数

  const GradientUnderlineTabIndicator({
    this.gradient,
    this.borderSide = const BorderSide(width: 2.0, color: Colors.black),
    this.insets = EdgeInsets.zero,
    this.radius = 4.0, // 默认圆角半径
    required this.texts,
    required this.fontSize,
    required this.controller,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _GradientUnderlinePainter(
      decoration: this,
      fontSize: fontSize,
      onChanged: onChanged,
      texts: texts,
      controller: controller,
    );
  }
}

class _GradientUnderlinePainter extends BoxPainter {
  final GradientUnderlineTabIndicator decoration;
  final double fontSize;
  final List<String> texts;
  final TabController controller;

  _GradientUnderlinePainter({
    required this.decoration,
    VoidCallback? onChanged,
    required this.fontSize,
    required this.texts,
    required this.controller,
  }) : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Rect rect = offset & configuration.size!;
    final TextDirection textDirection = configuration.textDirection!;
    final Rect indicator = decoration.insets
        .resolve(textDirection)
        .deflateRect(rect);
    // 获取文字宽度（假设每个Tab的TextStyle一致）
    final textSpan = TextSpan(
      text: texts[controller.index], // 占位文字，实际应动态获取
      style: TextStyle(fontSize: fontSize), // 需与TabBar中的TextStyle一致
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: textDirection,
    )..layout();
    double textWidth = textPainter.width;

    // 计算下划线位置（居中于Tab文字）
    final double centerX = indicator.left + (indicator.width) / 2.0;
    final double bottom = indicator.bottom - decoration.borderSide.width / 2.0;

    final gradient =
        decoration.gradient ??
        LinearGradient(
          colors: [
            AppTheme().current.goldColor3,
            AppTheme().current.goldGradientColor,
          ], // 你的渐变色
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        );
    final Paint paint = Paint()
      ..shader = gradient.createShader(
        Rect.fromLTRB(
          centerX - textWidth / 2,
          bottom,
          centerX + textWidth / 2,
          bottom,
        ),
      )
      ..strokeWidth = decoration.borderSide.width
      ..style = PaintingStyle.stroke;

    // 创建带圆角的矩形路径
    final double width = textWidth; // 减去默认的内边距
    final double height = decoration.borderSide.width;
    final RRect roundedRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        centerX - width / 2,
        bottom -
            height +
            decoration.borderSide.width / 2 -
            (decoration.borderSide.width * 0.5),
        width,
        height,
      ),
      Radius.circular(decoration.radius),
    );

    // 绘制带圆角的渐变下划线
    canvas.drawRRect(roundedRect, paint);
  }
}
