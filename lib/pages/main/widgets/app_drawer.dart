import 'package:flutter/material.dart';
import 'package:roomcard/theme/app_theme.dart';
import 'package:roomcard/utils/common_extension/common_extension.dart';
import 'package:roomcard/utils/num_px.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
    required this.onSelectTab,
    required this.currentIndex,
  });

  final void Function(int index) onSelectTab;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    final double safeTop = MediaQuery.of(context).padding.top;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xE6081B25), // rgba(8, 27, 37, 0.9)
            Color(0xE618384A), // rgba(24, 56, 74, 0.9)
          ],
          stops: [0.0007, 0.8441], // 0.07%, 84.41%
        ),
      ),
      child: Drawer(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Padding(padding: EdgeInsets.only(left:16.pxw,top: safeTop),child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('菜单',style:TextStyle(
              fontSize: 20.pxSp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),),
            // 可在此添加头像/昵称等头部内容

            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildDrawerItem(
                    context: context,
                    icon: Icons.home,
                    title: '首页',
                    index: 0,
                    isSelected: currentIndex == 0,
                    onTap: () {
                      Navigator.pop(context);
                      onSelectTab(0);
                    },
                  ),
                  _buildDrawerItem(
                    context: context,
                    icon: Icons.sports_esports,
                    title: '俱乐部',
                    index: 1,
                    isSelected: currentIndex == 1,
                    onTap: () {
                      Navigator.pop(context);
                      onSelectTab(1);
                    },
                  ),
                  _buildDrawerItem(
                    context: context,
                    icon: Icons.account_balance_wallet,
                    title: '充值',
                    index: 2,
                    isSelected: currentIndex == 2,
                    onTap: () {
                      Navigator.pop(context);
                      onSelectTab(2);
                    },
                  ),
                  _buildDrawerItem(
                    context: context,
                    icon: Icons.person,
                    title: '我的',
                    index: 3,
                    isSelected: currentIndex == 3,
                    onTap: () {
                      Navigator.pop(context);
                      onSelectTab(3);
                    },
                  ),
                  Divider(
                    color: AppTheme().current.lineColor2,
                    height: 1,
                  ),
                  _buildDrawerItem(
                    context: context,
                    icon: Icons.settings,
                    title: '设置',
                    index: -1,
                    isSelected: false,
                    onTap: () {
                      Navigator.pop(context);
                      // TODO: 跳转到设置页面
                    },
                  ),
                  _buildDrawerItem(
                    context: context,
                    icon: Icons.help,
                    title: '帮助',
                    index: -1,
                    isSelected: false,
                    onTap: () {
                      Navigator.pop(context);
                      // TODO: 跳转到帮助页面
                    },
                  ),
                  _buildDrawerItem(
                    context: context,
                    icon: Icons.info,
                    title: '关于',
                    index: -1,
                    isSelected: false,
                    onTap: () {
                      Navigator.pop(context);
                      // TODO: 跳转到关于页面
                    },
                  ),
                ],
              ),
            ),
          ],
        ),),
      ),
    );
  }

  Widget _buildDrawerItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required int index,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Container(
      width: 233.pxw,
      height: 52.pxh,
      margin: EdgeInsets.only(bottom: 8.pxh),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.pxw),
        gradient: isSelected
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
        color: isSelected ? null : const Color(0x700B1C26), // #0B1C2670
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8.pxw),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.pxw),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: isSelected ? const Color(0xFFF9C678) : Colors.white70,
                  size: 20.pxw,
                ),
                SizedBox(width: 12.pxw),
                Text(
                  title,
                  style: TextStyle(
                    color: isSelected ? const Color(0xFFF9C678) : AppTheme().current.textColor1,
                    fontSize: 16.pxSp,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

