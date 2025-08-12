part of 'common_extension.dart';

///防重复点击时间戳记录
int avoidDuplicateTapStamp = 0;

extension WidgetExtension on Widget {
  /// 添加边距
  /// 内间距
  Widget padding({
    Key? key,
    EdgeInsetsGeometry? value,
    double? all,
    double? horizontal,
    double? vertical,
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) => Padding(
    key: key,
    padding:
        value ??
        EdgeInsets.only(
          top: top ?? vertical ?? all ?? 0.0,
          bottom: bottom ?? vertical ?? all ?? 0.0,
          left: left ?? horizontal ?? all ?? 0.0,
          right: right ?? horizontal ?? all ?? 0.0,
        ),
    child: this,
  );

  /// 添加Container边距
  Widget innerPadding([EdgeInsetsGeometry value = const EdgeInsets.all(8)]) =>
      Builder(builder: (context) => Container(padding: value, child: this));

  /// 设置大小
  Widget sized({double? width, double? height}) =>
      SizedBox(width: width, height: height, child: this);

  /// 居中
  Widget center() => Center(child: this);

  /// 居左
  Widget alignLeft() => Align(alignment: Alignment.centerLeft, child: this);
  Widget paddingTop(double val) => padding(top: val);

  ///条件隐藏
  Widget hide([bool v = true, bool holdSpace = false]) {
    if (holdSpace) {
      return Opacity(opacity: v ? 0 : 1, child: this);
    }
    return Offstage(offstage: v, child: this);
  }

  ///四个角同样的圆角
  Widget cornerRadiusCircularAll(double value) {
    return ClipRRect(borderRadius: BorderRadius.circular(value), child: this);
  }

  /// 背景图片
  Widget backgroundImage(DecorationImage image, {Key? key}) => DecoratedBox(
    key: key,
    decoration: BoxDecoration(image: image),
    child: this,
  );

  /// 内间距 下
  Widget paddingBottom(double val) => padding(bottom: val);

  /// 内间距 横向
  Widget paddingHorizontal(double val) => padding(horizontal: val);

  /// 内间距 左
  Widget paddingLeft(double val) => padding(left: val);

  /// 内间距 右
  Widget paddingRight(double val) => padding(right: val);

  /// 内间距 纵向
  Widget paddingVertical(double val) => padding(vertical: val);

  ///Expanded
  Widget fill([int p = 1, bool enable = true]) {
    return enable ? Expanded(flex: p, child: this) : this;
  }

  /// 对齐
  Widget align(AlignmentGeometry alignment, {Key? key}) =>
      Align(key: key, alignment: alignment, child: this);

  /// 对齐 中间
  Widget alignCenter() => align(Alignment.center);

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

  /// 背景颜色
  Widget backgroundColor(Color color, {Key? key}) => DecoratedBox(
    key: key,
    decoration: BoxDecoration(color: color),
    child: this,
  );

  ///四个角分别圆角
  Widget cornerRadiusCircularOnly({
    double topLeft = 0,
    double topRight = 0,
    double bottomLeft = 0,
    double bottomRight = 0,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(topLeft),
        topRight: Radius.circular(topRight),
        bottomLeft: Radius.circular(bottomLeft),
        bottomRight: Radius.circular(bottomRight),
      ),
      child: this,
    );
  }

  ///占位空间
  Widget separatorX(
    double v, {
    double? height,
    Color color = Colors.transparent,
    double? topMargin,
    double? bottomMargin,
  }) {
    if (color != Colors.transparent) {
      return Container(
        width: v,
        height: height,
        color: color,
        margin: () {
          if (topMargin != null && bottomMargin != null) {
            return EdgeInsets.only(top: topMargin, bottom: bottomMargin);
          } else if (topMargin != null) {
            return EdgeInsets.only(top: topMargin);
          } else if (bottomMargin != null) {
            return EdgeInsets.only(bottom: bottomMargin);
          }
        }(),
      );
    }
    return SizedBox(width: v, height: height);
  }

  ///占位空间 y
  Widget separatorY(
    double v, {
    double? width,
    Color color = Colors.transparent,
    double? leftMargin,
    double? rightMargin,
  }) {
    if (color != Colors.transparent) {
      return Container(
        width: width,
        height: v,
        color: color,
        margin: () {
          if (leftMargin != null && rightMargin != null) {
            return EdgeInsets.only(left: leftMargin, right: rightMargin);
          } else if (leftMargin != null) {
            return EdgeInsets.only(left: leftMargin);
          } else if (rightMargin != null) {
            return EdgeInsets.only(right: rightMargin);
          }
        }(),
      );
    }
    return SizedBox(height: v, width: width);
  }

  Widget gestureTap({
    void Function()? onTap,
    HitTestBehavior behavior = HitTestBehavior.translucent,
    int? avoidDuplicateTapMillsec = 0,
    bool splash = false,
    double radius = 0,
    Color? bgColor,
  }) {
    if (splash) {
      return Ink(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(radius),
          onTap: () {
            if (avoidDuplicateTapMillsec == null ||
                avoidDuplicateTapMillsec == 0) {
              onTap?.call();
              return;
            }
            var n = DateTime.now().millisecondsSinceEpoch;
            var delta = n - avoidDuplicateTapStamp;
            if (delta <= (avoidDuplicateTapMillsec)) {
              return;
            }
            avoidDuplicateTapStamp = n;
            onTap?.call();
          },
          child: this,
        ),
      );
    }

    return GestureDetector(
      behavior: behavior,
      onTap: () {
        if (avoidDuplicateTapMillsec == null || avoidDuplicateTapMillsec == 0) {
          onTap?.call();
          return;
        }
        var n = DateTime.now().millisecondsSinceEpoch;
        var delta = n - avoidDuplicateTapStamp;
        if (delta <= (avoidDuplicateTapMillsec)) {
          return;
        }
        avoidDuplicateTapStamp = n;
        onTap?.call();
      },
      child: this,
    );
  }
}
