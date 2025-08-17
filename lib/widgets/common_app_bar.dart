import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../r.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color? titleColor;
  final double? titleSize;
  final FontWeight? titleWeight;
  final Color? backgroundColor;
  final double? elevation;
  final bool centerTitle;
  final Widget? leading;
  final List<Widget>? actions;
  final bool automaticallyImplyLeading;
  final VoidCallback? onBackPressed;
  final Widget? titleWidget;

  const CommonAppBar({
    Key? key,
    required this.title,
    this.titleColor = Colors.white,
    this.titleSize = 18.0,
    this.titleWeight = FontWeight.w600,
    this.backgroundColor = const Color(0xFF283D49),
    this.elevation = 0.0,
    this.centerTitle = true,
    this.leading,
    this.actions,
    this.automaticallyImplyLeading = true,
    this.onBackPressed,
    this.titleWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title:
          titleWidget ??
          Text(
            title,
            style: TextStyle(
              color: titleColor,
              fontSize: titleSize,
              fontWeight: titleWeight,
            ),
          ),
      backgroundColor: backgroundColor,
      elevation: elevation,
      centerTitle: centerTitle,
      leading: leading ?? _buildLeading(),
      actions: actions,
      automaticallyImplyLeading: automaticallyImplyLeading,
    );
  }

  Widget? _buildLeading() {
    if (!automaticallyImplyLeading) return null;

    return IconButton(
      icon: Image.asset(R.assetsImagesIconTitleBack, width: 28.w),
      onPressed: onBackPressed ?? () => Get.back(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// 带渐变背景的AppBar
class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color? titleColor;
  final double? titleSize;
  final FontWeight? titleWeight;
  final List<Color>? gradientColors;
  final double? elevation;
  final bool centerTitle;
  final Widget? leading;
  final List<Widget>? actions;
  final bool automaticallyImplyLeading;
  final VoidCallback? onBackPressed;
  final Widget? titleWidget;

  const GradientAppBar({
    Key? key,
    required this.title,
    this.titleColor = Colors.white,
    this.titleSize = 18.0,
    this.titleWeight = FontWeight.w600,
    this.gradientColors,
    this.elevation = 0.0,
    this.centerTitle = true,
    this.leading,
    this.actions,
    this.automaticallyImplyLeading = true,
    this.onBackPressed,
    this.titleWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors:
              gradientColors ?? [Colors.blue.shade600, Colors.blue.shade800],
        ),
      ),
      child: AppBar(
        title:
            titleWidget ??
            Text(
              title,
              style: TextStyle(
                color: titleColor,
                fontSize: titleSize,
                fontWeight: titleWeight,
              ),
            ),
        backgroundColor: Colors.transparent,
        elevation: elevation,
        centerTitle: centerTitle,
        leading: leading ?? _buildLeading(),
        actions: actions,
        automaticallyImplyLeading: automaticallyImplyLeading,
      ),
    );
  }

  Widget? _buildLeading() {
    if (!automaticallyImplyLeading) return null;

    return IconButton(
      icon: Image.asset(R.assetsImagesIconTitleBack),
      onPressed: onBackPressed ?? () => Get.back(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
