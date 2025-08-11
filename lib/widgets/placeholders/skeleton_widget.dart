import 'package:roomcard/theme/app_theme.dart';
import 'package:roomcard/utils/common_extension/common_extension.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

///骨架屏，如果想要文字骨架屏效果可参考以下示例
///```
///Shimmer.fromColors(
///        baseColor: Colors.red,
///        highlightColor: Colors.yellow,
///         child: Text(
///         'Shimmer',
///         textAlign: TextAlign.center,
///         style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
///         ),
///       )
///```
class SkeletonWidget extends StatelessWidget {
  final Widget? child;
  final Color? baseColor;
  final Color? highlightColor;
  final BorderRadius? borderRadius;
  const SkeletonWidget({
    super.key,
    this.child,
    this.baseColor,
    this.highlightColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? AppTheme().current.backgroundColor4,
      highlightColor: highlightColor ?? '#353535'.hexToColor,
      child:
          child ??
          Container(
            decoration: BoxDecoration(
              color: baseColor ?? AppTheme().current.backgroundColor4,
              borderRadius: borderRadius,
            ),
          ),
    );
  }
}

///低耦合高内聚理念， 这个文件抽取到其他项目可以单独删除这个类。
class SkeletonWidgetUtil {
  ///内部采用`FutureBuilder`实现。waiting状态下就是骨架屏。
  ///比较适合固定高度的控件。
  static Widget loadWithFuture<T>(
    Future<T> future, {
    required Widget Function(BuildContext context, BoxConstraints constraints)
    builder,
    EdgeInsets padding = EdgeInsets.zero,
    BorderRadius? borderRadius,
  }) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
            padding: padding,
            child: ClipRRect(
              borderRadius: borderRadius ?? BorderRadius.circular(0),
              child: SkeletonWidget(),
            ),
          );
        }
        return LayoutBuilder(builder: builder);
      },
    );
  }
}
