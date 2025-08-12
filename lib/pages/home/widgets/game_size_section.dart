import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roomcard/utils/num_px.dart';
import 'package:roomcard/theme/app_theme.dart';
import '../home_logic.dart';

/// 游戏大小选择组件
class GameSizeSection extends StatelessWidget {
  final HomeLogic logic;

  const GameSizeSection({
    super.key,
    required this.logic,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(() => Row(
        children: [
          _buildSizeButton('微型', logic.state.selectedGameSize.value == 0, () => logic.selectGameSize(0)),
          SizedBox(width: 12.pxw),
          _buildSizeButton('小型', logic.state.selectedGameSize.value == 1, () => logic.selectGameSize(1)),
          SizedBox(width: 12.pxw),
          _buildSizeButton('正常', logic.state.selectedGameSize.value == 2, () => logic.selectGameSize(2)),
          SizedBox(width: 12.pxw),
          _buildSizeButton('高级', logic.state.selectedGameSize.value == 3, () => logic.selectGameSize(3)),
        ],
      )),
    );
  }

  /// 构建大小按钮
  Widget _buildSizeButton(String label, bool isSelected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 26.pxh,
          width: 74.pxw,
          decoration: BoxDecoration(
            color: isSelected 
                ? AppTheme().current.themeColor1 
                : AppTheme().current.backgroundColor2,
            borderRadius: BorderRadius.circular(14.pxw),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected 
                    ? AppTheme().current.textColorInButton 
                    : AppTheme().current.textColor1,
                fontSize: 12.pxSp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
} 