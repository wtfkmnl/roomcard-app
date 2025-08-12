import 'package:flutter/material.dart';
import 'package:roomcard/utils/num_px.dart';
import 'package:roomcard/theme/app_theme.dart';

/// 空状态显示组件
class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/home/club_main_not_icon.png',
            width: 360/3.pxw,
            height: 348/3.pxh,
          ),
          
          SizedBox(height: 12.pxh),
          
          Text(
            '暂无数据',
            style: TextStyle(
              color: AppTheme().current.textColor4,
              fontSize: 12.pxSp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
} 