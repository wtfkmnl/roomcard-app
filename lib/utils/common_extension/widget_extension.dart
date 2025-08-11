part of 'common_extension.dart';

extension WidgetExtension on Widget {
  /// 添加边距
  Widget padding([EdgeInsetsGeometry value = const EdgeInsets.all(8)]) =>
      Padding(padding: value, child: this);

  /// 添加Container边距
  Widget innerPadding([EdgeInsetsGeometry value = const EdgeInsets.all(8)]) =>
      Builder(
        builder: (context) => Container(padding: value, child: this),
      );

  /// 设置大小
  Widget sized({double? width, double? height}) =>
      SizedBox(width: width, height: height, child: this);

  /// 居中
  Widget center() => Center(child: this);

  /// 居左
  Widget alignLeft() => Align(alignment: Alignment.centerLeft, child: this);

  /// 居右
  Widget alignRight() => Align(alignment: Alignment.centerRight, child: this);

  /// 添加圆角背景
  Widget withRoundedBackground({
    Color color = Colors.white,
    double radius = 12.0,
    EdgeInsetsGeometry? padding,
  }) => Container(
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius),
    ),
    padding: padding,
    child: this,
  );

  /// 添加点击事件（无水波纹）
  Widget onTap(VoidCallback onTap) =>
      GestureDetector(onTap: onTap, child: this);

  /// 添加点击事件（带水波纹）
  Widget onInkTap(VoidCallback onTap) => Material(
    color: Colors.transparent,
    child: InkWell(onTap: onTap, child: this),
  );

  /// 添加阴影和圆角
  Widget withShadow({
    Color color = Colors.white,
    double radius = 12.0,
    List<BoxShadow>? boxShadow,
  }) => Container(
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius),
      boxShadow:
          boxShadow ??
          [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
    ),
    child: this,
  );

  /// 设置透明度（适用于渐隐/灰化控件）
  Widget opacity(double value) => Opacity(opacity: value, child: this);

  /// 条件渲染：当 condition 为 true 时保留该控件，否则返回 SizedBox.shrink()
  Widget visible(bool condition) => condition ? this : const SizedBox.shrink();

  /// 添加 Hero 动画（仅限页面跳转使用）
  Widget withHero(String tag) => Hero(tag: tag, child: this);

  /// 添加圆形裁剪（通常用于头像/图标）
  Widget circular({double? radius}) => ClipRRect(
    borderRadius: BorderRadius.circular(radius ?? 999),
    child: this,
  );

  /// 设置背景颜色（常用于 ListTile/Container
  ///  装饰）
  Widget withBackground(Color color) => Container(color: color, child: this);

  /// 添加边框
  Widget withBorder({
    Color color = Colors.grey,
    double width = 1.0,
    double radius = 8.0,
  }) => Container(
    decoration: BoxDecoration(
      border: Border.all(color: color, width: width),
      borderRadius: BorderRadius.circular(radius),
    ),
    child: this,
  );

  /// 添加旋转动画（注意角度为弧度）
  Widget rotated(double angle) => Transform.rotate(angle: angle, child: this);

  /// 添加缩放动画
  Widget scaled(double scale) => Transform.scale(scale: scale, child: this);

  /// 作为 Expanded 子组件使用
  Widget expanded({int flex = 1}) => Expanded(flex: flex, child: this);

  /// 作为 Flexible 子组件使用
  Widget flexible({int flex = 1, FlexFit fit = FlexFit.loose}) =>
      Flexible(flex: flex, fit: fit, child: this);

  /// 添加 Tooltip（长按或悬浮提示）
  Widget withTooltip(String message) => Tooltip(message: message, child: this);
}
