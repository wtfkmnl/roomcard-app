import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// SvgUtil 工具类，隔离 flutter_svg 第三方依赖，方便后期替换和统一管理。
class SvgUtil {
  /// 加载 SVG 资源文件
  static Widget asset(
    String assetName, {
    Key? key,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    Color? color,
    ColorFilter? colorFilter,
    AlignmentGeometry alignment = Alignment.center,
    String? semanticsLabel,
    bool matchTextDirection = false,
    WidgetBuilder? placeholderBuilder,
  }) {
    return SvgPicture.asset(
      assetName,
      key: key,
      width: width,
      height: height,
      fit: fit,
      colorFilter:
          colorFilter ??
          (color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null),
      alignment: alignment,
      semanticsLabel: semanticsLabel,
      matchTextDirection: matchTextDirection,
      placeholderBuilder: placeholderBuilder,
    );
  }

  /// 加载 SVG 网络图片
  static Widget network(
    String url, {
    Key? key,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    Color? color,
    ColorFilter? colorFilter,
    AlignmentGeometry alignment = Alignment.center,
    String? semanticsLabel,
    bool matchTextDirection = false,
    WidgetBuilder? placeholderBuilder,
  }) {
    return SvgPicture.network(
      url,
      key: key,
      width: width,
      height: height,
      fit: fit,
      colorFilter:
          colorFilter ??
          (color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null),
      alignment: alignment,
      semanticsLabel: semanticsLabel,
      matchTextDirection: matchTextDirection,
      placeholderBuilder: placeholderBuilder,
    );
  }
}
