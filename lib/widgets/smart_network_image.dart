import 'package:roomcard/utils/svg_util.dart';
import 'package:roomcard/widgets/placeholders/skeleton_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

///自带超高校缓存和自定义缓存的智能网络`图片`加载控件。基于cache image封装。
class SmartNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;

  ///缓存时间
  final Duration cacheDuration;

  /// - true: URL 变化时继续显示旧图，直到新图加载完成
  /// - false: URL 变化时立即清除旧图，显示占位符
  final bool useOldImageOnUrlChange;
  final Color? color;
  final BlendMode? colorBlendMode;
  final Alignment alignment;
  final bool showPreviewWhenLoading;

  const SmartNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
    this.cacheDuration = const Duration(days: 30),
    this.useOldImageOnUrlChange = true,
    this.color,
    this.colorBlendMode,
    this.alignment = Alignment.center,
    this.showPreviewWhenLoading = true,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      color: color,
      colorBlendMode: colorBlendMode,
      alignment: alignment,
      useOldImageOnUrlChange: useOldImageOnUrlChange,
      cacheKey: useOldImageOnUrlChange ? null : imageUrl,
      cacheManager: _createCacheManager(),
      placeholder: (context, url) {
        if (showPreviewWhenLoading && placeholder == null) {
          return _buildPlaceholder();
        }
        return placeholder ?? _buildPlaceholder();
      },
      errorWidget: (context, url, error) {
        return errorWidget ?? _buildErrorWidget();
      },
    );
  }

  Widget _buildPlaceholder() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SkeletonWidget();
      },
    );
  }

  Widget _buildErrorWidget() {
    return SvgUtil.asset('assets/images/public/图片加载失败默认图.svg');
  }

  CacheManager _createCacheManager() {
    return CacheManager(
      Config(imageUrl, stalePeriod: cacheDuration, maxNrOfCacheObjects: 100),
    );
  }
}
