import 'package:flutter/material.dart';
import 'package:roomcard/theme/app_theme.dart';
import 'package:roomcard/utils/common_extension/common_extension.dart';
import 'package:roomcard/utils/num_px.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
    required this.onSelectTab,
  });

  final void Function(int index) onSelectTab;

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
                    onTap: () {
                      Navigator.pop(context);
                      onSelectTab(0);
                    },
                  ),
                  _buildDrawerItem(
                    context: context,
                    icon: Icons.sports_esports,
                    title: '俱乐部',
                    onTap: () {
                      Navigator.pop(context);
                      onSelectTab(1);
                    },
                  ),
                  _buildDrawerItem(
                    context: context,
                    icon: Icons.account_balance_wallet,
                    title: '充值',
                    onTap: () {
                      Navigator.pop(context);
                      onSelectTab(2);
                    },
                  ),
                  _buildDrawerItem(
                    context: context,
                    icon: Icons.person,
                    title: '我的',
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
                    onTap: () {
                      Navigator.pop(context);
                      // TODO: 跳转到设置页面
                    },
                  ),
                  _buildDrawerItem(
                    context: context,
                    icon: Icons.help,
                    title: '帮助',
                    onTap: () {
                      Navigator.pop(context);
                      // TODO: 跳转到帮助页面
                    },
                  ),
                  _buildDrawerItem(
                    context: context,
                    icon: Icons.info,
                    title: '关于',
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
    required VoidCallback onTap,
  }) {
    return Container(
      child: Text(
        title,
        style: TextStyle(
          color: AppTheme().current.textColor1,
          fontSize: 16.pxSp,
          fontWeight: FontWeight.w500,
        ),
      ),

    ).onTap(onTap);
  }
}

