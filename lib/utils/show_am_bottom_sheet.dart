import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<T?> showAmBottomSheet<T>({
  Widget? content,
  Widget? header,
  Widget? footer,
  Color? backgroundColor,
  Clip? clipBehavior,
  bool wrapSingleChildScrollView = true,
  double? height, // 新增: 固定高度参数
  double? maxHeight, // 保留: 最大高度参数
  double? minHeight, // 新增: 最小高度参数
  bool? isDismissible = true,
  bool? bottomSafeArea,
  BorderRadius? borderRadius, // 新增: 自定义圆角
}) {
  return showModalBottomSheet<T>(
    isScrollControlled: true,
    isDismissible: isDismissible ?? true,
    context: Get.context!,
    useSafeArea: true,
    barrierColor: Colors.black.withOpacity(0.5),
    builder: (BuildContext context) {
      return Container(
        clipBehavior: clipBehavior ?? Clip.hardEdge,
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          borderRadius: borderRadius ??
              BorderRadius.only(
                topLeft: Radius.circular(22.5.w),
                topRight: Radius.circular(22.5.w),
              ),
        ),
        child: SafeArea(
          bottom: bottomSafeArea ?? false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              header ?? const SizedBox(),
              _buildContent(
                content: content,
                height: height,
                maxHeight: maxHeight,
                minHeight: minHeight ?? 10.h,
                wrapSingleChildScrollView: wrapSingleChildScrollView,
              ),
              footer ?? const SizedBox(),
            ],
          ),
        ),
      );
    },
  );
}

// 提取构建内容区域的逻辑为单独函数
Widget _buildContent({
  required Widget? content,
  double? height,
  double? maxHeight,
  required double minHeight,
  required bool wrapSingleChildScrollView,
}) {
  // 如果设置了固定高度，则使用SizedBox
  if (height != null) {
    return SizedBox(
      height: height,
      child: wrapSingleChildScrollView
          ? SingleChildScrollView(child: content)
          : content,
    );
  }

  // 否则使用ConstrainedBox设置最小/最大高度
  return ConstrainedBox(
    constraints: BoxConstraints(
      minHeight: minHeight,
      maxHeight: maxHeight ?? 700.h,
    ),
    child: wrapSingleChildScrollView
        ? SingleChildScrollView(child: content)
        : content,
  );
}
