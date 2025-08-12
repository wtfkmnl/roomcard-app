import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roomcard/utils/num_px.dart';
import 'package:roomcard/theme/app_theme.dart';
import 'dart:ui'; // Added for ImageFilter

/// 游戏类型枚举
enum GameType {
  all,
  tournament,
  classicTexas,
  shortDeck,
  omaha,
  pineapple,
  texasCowboy,
  aof,
}

/// 游戏类型数据模型
class GameTypeItem {
  final GameType type;
  final String name;
  final IconData icon;
  final bool isSelected;

  GameTypeItem({
    required this.type,
    required this.name,
    required this.icon,
    this.isSelected = false,
  });
}

/// 主页侧边栏抽屉
class AppDrawer extends StatelessWidget {
  final GameType selectedGameType;
  final Function(GameType) onGameTypeSelected;

  const AppDrawer({
    super.key,
    required this.selectedGameType,
    required this.onGameTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor:Color(0xE3081B25),
      child: Container(

        child:Column(
          children: [
            // 顶部标题
            _buildHeader(),

            // 菜单项列表
            Expanded(
              child: _buildMenuList(),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建头部
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.pxw, vertical: 32.pxh),
      child: Text(
        '菜单',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.pxSp,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  /// 构建菜单列表
  Widget _buildMenuList() {
    final menuItems = [
      GameTypeItem(
        type: GameType.all,
        name: '全部',
        icon: Icons.grid_view,
        isSelected: selectedGameType == GameType.all,
      ),
      GameTypeItem(
        type: GameType.tournament,
        name: '竞标赛',
        icon: Icons.emoji_events,
        isSelected: selectedGameType == GameType.tournament,
      ),
      GameTypeItem(
        type: GameType.classicTexas,
        name: '经典德州',
        icon: Icons.style,
        isSelected: selectedGameType == GameType.classicTexas,
      ),
      GameTypeItem(
        type: GameType.shortDeck,
        name: '短牌',
        icon: Icons.view_agenda,
        isSelected: selectedGameType == GameType.shortDeck,
      ),
      GameTypeItem(
        type: GameType.omaha,
        name: '奥马哈',
        icon: Icons.view_column,
        isSelected: selectedGameType == GameType.omaha,
      ),
      GameTypeItem(
        type: GameType.pineapple,
        name: '大菠萝',
        icon: Icons.local_florist,
        isSelected: selectedGameType == GameType.pineapple,
      ),
      GameTypeItem(
        type: GameType.texasCowboy,
        name: '德州牛仔',
        icon: Icons.face,
        isSelected: selectedGameType == GameType.texasCowboy,
      ),
      GameTypeItem(
        type: GameType.aof,
        name: 'AOF',
        icon: Icons.settings,
        isSelected: selectedGameType == GameType.aof,
      ),
    ];

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.pxw),
      itemCount: menuItems.length,
      itemBuilder: (context, index) {
        return _buildMenuItem(menuItems[index]);
      },
    );
  }

  /// 构建菜单项
  Widget _buildMenuItem(GameTypeItem item) {
    return Container(
      width: 233.pxw,
      height: 52.pxh,
      margin: EdgeInsets.only(bottom: 8.pxh),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.pxw),
        gradient: item.isSelected
            ? const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0x4AF9C678), // rgba(249, 198, 120, 0.29)
                  Color(0x00112A37), // rgba(17, 42, 55, 0)
                ],
                stops: [0.0, 0.8455],
              )
            : null,
        color: item.isSelected ? null : const Color(0x700B1C26), // #0B1C2670
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onGameTypeSelected(item.type),
          borderRadius: BorderRadius.circular(8.pxw),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.pxw),
            child: Row(
              children: [
                // 图标
                Icon(
                  item.icon,
                  color: item.isSelected ? const Color(0xFFF9C678) : Colors.white70,
                  size: 20.pxw,
                ),
                
                SizedBox(width: 12.pxw),
                
                // 菜单名称
                Expanded(
                  child: Text(
                    item.name,
                    style: TextStyle(
                      color: item.isSelected ? const Color(0xFFF9C678) : Colors.white,
                      fontSize: 16.pxSp,
                      fontWeight: item.isSelected ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                ),
                
                // 右箭头
                Icon(
                  Icons.arrow_forward_ios,
                  color: item.isSelected ? const Color(0xFFF9C678) : Colors.grey[400],
                  size: 16.pxw,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 