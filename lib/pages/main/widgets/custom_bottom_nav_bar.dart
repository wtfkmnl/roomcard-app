
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:roomcard/utils/num_px.dart';

import '../../../theme/app_theme.dart';
import '../../../utils/svg_util.dart';
import '../../../widgets/texts/gradient_text.dart';
import '../models/nav_item.dart';

/// 自定义底部导航栏组件
class CustomBottomNavBar extends StatelessWidget {
  /// 当前选中索引
  final int currentIndex;

  /// 点击导航项时的回调
  final ValueChanged<int> onTap;

  /// 底部导航栏项集合
  final List<NavItem> items;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // 底部导航栏整体高度，根据是否有底部安全区进行适配
      height:   87.pxh ,
      width: Get.width,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              const Color(0xFF0A1C26).withValues(alpha: 0.78), // rgba(10, 28, 38, 0.78)
              const Color(0xFF2D4A5A).withValues(alpha: 0.78), // rgba(45, 74, 90, 0.78)
            ],
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.pxw),
            topRight: Radius.circular(20.pxw),
          ),
          border: Border(
            top: BorderSide(
              width: 1.5,
              color: Colors.white.withValues(alpha: 0.2),
            ),
          ),
        ),
        padding: EdgeInsets.only(top: 10.pxh),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(items.length, (index) {
            final item = items[index];
            final isSelected = currentIndex == index;

            return _buildButtonItem(index, isSelected, item);
          }),
        ),
      ),
    );
  }

  Expanded _buildButtonItem(int index, bool isSelected, NavItem item) {
    return Expanded(
      child: GestureDetector(
        // 点击导航项触发回调
        onTap: () => onTap(index),
        behavior: HitTestBehavior.translucent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 图标，根据是否选中切换资源和大小
            SvgUtil.asset(
              isSelected ? item.activeIconPath : item.iconPath,
              width: isSelected ? 32.pxw : 22.pxw,
              height: isSelected ? 32.pxh : 22.pxh,
            ),
            // 文字，只在非激活状态显示
            if (!isSelected)
              SizedBox(
                height: 20.pxh,
                child: Text(
                  item.label,
                  style: TextStyle(
                    color: AppTheme().current.textColor1, // 使用白色文字
                    fontSize: 10.pxSp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
