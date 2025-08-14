import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roomcard/utils/num_px.dart';
import 'package:roomcard/theme/app_theme.dart';
import '../home_logic.dart';

/// 游戏模式选择组件
class GameModeSection extends StatelessWidget {
  final HomeLogic logic;

  const GameModeSection({super.key, required this.logic});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(
        () => Row(
          children: [
            _buildModeButton('俱乐部', 'assets/images/home/club-1.png', 'assets/images/home/club.png', logic.state.selectedGameMode.value == 0, () => logic.selectGameMode(0)),
            SizedBox(width: 12.pxw),
            _buildModeButton('朋友局', 'assets/images/home/friend-1.png', 'assets/images/home/friend.png', logic.state.selectedGameMode.value == 1, () => logic.selectGameMode(1)),
            SizedBox(width: 12.pxw),
            _buildModeButton('大厅', 'assets/images/home/lobby-1.png', 'assets/images/home/lobby.png', logic.state.selectedGameMode.value == 2, () => logic.selectGameMode(2)),
          ],
        ),
      ),
    );
  }

  /// 构建模式按钮
  Widget _buildModeButton(String label, String icon, String activeIcon, bool isSelected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 40.pxh,
          child: isSelected ? Image.asset(icon,) : Image.asset(activeIcon),
        ),
      ),
    );
  }
}
