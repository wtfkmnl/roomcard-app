import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:roomcard/utils/num_px.dart';
import 'package:roomcard/theme/app_theme.dart';
import 'package:roomcard/widgets/common_app_bar.dart';
import 'club_detail_logic.dart';
import '../../r.dart';

/// 俱乐部详情页面
class ClubDetailPage extends StatefulWidget {
  const ClubDetailPage({super.key});

  @override
  State<ClubDetailPage> createState() => _ClubDetailPageState();
}

class _ClubDetailPageState extends State<ClubDetailPage> {
  final logic = Get.put(ClubDetailLogic());
  final state = Get.find<ClubDetailLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C2C36),
      appBar: const CommonAppBar(title: ''),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 185.pxh,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/images/club/club_detail_bg.png'), fit: BoxFit.fill),
                ),
                child: _buildClubInfoCard(),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '俱乐部公告',
                    style: TextStyle(color: Colors.white, fontSize: 14.pxSp, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean euismod bibendum laoreet. Proin gravida dolor sit amet lacus accumsan et viverra justo commodo. Proin sodales pulvinar sic tempor. Sociis natoque penatibus et',
                    style: TextStyle(color: Color(0xFFB3BEC1), fontSize: 12.pxSp, fontWeight: FontWeight.w600),
                  ),
                ],
              ).paddingSymmetric(horizontal: 16.pxw),
              // 主要内容区域
              Gap(16.pxw),
              _buildMenuList().paddingSymmetric(horizontal: 16.pxw),
              // 底部留白，确保滚动到底部时有足够空间
              Gap(32.pxh),
            ],
          ),
        ),
      ),
    );
  }

  /// 构建俱乐部信息卡片
  Widget _buildClubInfoCard() {
    return Stack(
      children: [
        Column(
          children: [
            Gap(16.pxw),
            // 俱乐部标志
            Container(
              width: 94.pxw,
              height: 97.pxh,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.pxw),
                image: DecorationImage(image: AssetImage('assets/images/club/club_detail_header.png'), fit: BoxFit.cover),
              ),
            ),

            // 俱乐部信息
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 俱乐部名称
                Text(
                  '俱乐部名称',
                  style: TextStyle(color: Colors.white, fontSize: 18.pxSp, fontWeight: FontWeight.w600),
                ),

                Gap(2.pxh),

                // 俱乐部ID和成员数量
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person, color: AppTheme().current.textColor3, size: 16.pxw),

                    Gap(4.pxw),

                    Text(
                      '俱乐部ID',
                      style: TextStyle(color: AppTheme().current.textColor3, fontSize: 14.pxSp),
                    ),
                  ],
                ),
              ],
            ),

            Text(
              '地区',
              style: TextStyle(color: AppTheme().current.textColor3, fontSize: 14.pxSp),
            ),
          ],
        ),
        Positioned(
          child: Icon(Icons.arrow_forward_ios, color: AppTheme().current.textColor3, size: 16.pxw),
          right: 16.pxw,
          top: 16.pxh,
        ),
      ],
    );
  }

  /// 构建选项菜单列表
  Widget _buildMenuList() {
    return Column(
      children: [
        // 创始人信息
        _buildFounderItem(),
        Gap(16.pxh),
        // 俱乐部成员员工
        _buildClubMembersItem(),
        Gap(16.pxh),
        // 其他菜单项
        ..._buildMenuItems(),
      ],
    );
  }

  /// 构建创始人信息项
  Widget _buildFounderItem() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.pxw, vertical: 12.pxh),
      decoration: BoxDecoration(
        color: const Color(0xFF283D49),
        borderRadius: BorderRadius.circular(12.pxw),
        border: Border.all(color: const Color(0xFF37505E), width: 1.pxw),
      ),
      child: Row(
        children: [
          Text(
            '创始人',
            style: TextStyle(color: Colors.white, fontSize: 14.pxSp, fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          // 头像
          Container(
            width: 32.pxw,
            height: 32.pxw,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.pxw),
              image: const DecorationImage(
                image: AssetImage('assets/images/club/club_detail_header.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Gap(8.pxw),
          // 昵称
          Text(
            '创始人昵称',
            style: TextStyle(color: Colors.white, fontSize: 14.pxSp, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  /// 构建俱乐部成员员工项
  Widget _buildClubMembersItem() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.pxw, vertical: 12.pxh),
      decoration: BoxDecoration(
        color: const Color(0xFF283D49),
        borderRadius: BorderRadius.circular(12.pxw),
        border: Border.all(color: const Color(0xFF37505E), width: 1.pxw),
      ),
      child: Column(
        children: [
          // 第一行：左侧是"俱乐部成员员工"，右侧是箭头
          Row(
            children: [
              Text(
                '俱乐部成员员工',
                style: TextStyle(color: Colors.white, fontSize: 14.pxSp, fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              Icon(Icons.arrow_forward_ios, color: AppTheme().current.textColor3, size: 16.pxw),
            ],
          ),
          Gap(12.pxh),
          // 第二行：成员头像和昵称，显示五个
          Row(
            children: [
              // 成员1
              _buildMemberAvatar('成员1'),
              Gap(8.pxw),
              // 成员2
              _buildMemberAvatar('成员2'),
              Gap(8.pxw),
              // 成员3
              _buildMemberAvatar('成员3'),
              Gap(8.pxw),
              // 成员4
              _buildMemberAvatar('成员4'),
              Gap(8.pxw),
              // 成员5
              _buildMemberAvatar('成员5'),
            ],
          ),
        ],
      ),
    );
  }

  /// 构建成员头像
  Widget _buildMemberAvatar(String nickname) {
    return Column(
      children: [
        Container(
          width: 48.pxw,
          height: 48.pxh,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.pxw),
            image: const DecorationImage(
              image: AssetImage('assets/images/club/club_detail_header.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Gap(4.pxh),
        Text(
          nickname,
          style: TextStyle(color: Colors.white, fontSize: 12.pxSp, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  /// 构建菜单项列表
  List<Widget> _buildMenuItems() {
    final menuItems = [
      {'title': '管理员', 'subtitle': '', 'type': 'navigation', 'onTap': () => logic.onManagerTap()},
      {'title': '安全邮箱', 'subtitle': '未绑定', 'type': 'navigation', 'onTap': () => logic.onSecurityEmailTap()},
      {'title': '俱乐部等级', 'subtitle': '', 'type': 'navigation', 'onTap': () => logic.onClubLevelTap()},
      {'title': '联盟', 'subtitle': '', 'type': 'navigation', 'onTap': () => logic.onAllianceTap(), 'isHighlighted': true},
      {'title': '只允许群主和管理员开局', 'subtitle': '', 'type': 'switch', 'value': true, 'onChanged': (value) => logic.onOnlyManagerStartChanged(value)},
      {'title': '只允许他人搜索到该俱乐部', 'subtitle': '', 'type': 'switch', 'value': true, 'onChanged': (value) => logic.onSearchableChanged(value)},
    ];

    return menuItems
        .map(
          (item) => _buildMenuItem(
            title: item['title'] as String,
            subtitle: item['subtitle'] as String,
            type: item['type'] as String,
            onTap: item['onTap'] as VoidCallback?,
            onChanged: item['onChanged'] as Function(bool)?,
            value: item['value'] as bool?,
            isHighlighted: item['isHighlighted'] as bool? ?? false,
            isLast: item == menuItems.last,
          ),
        )
        .toList();
  }

  /// 构建菜单项
  Widget _buildMenuItem({required String title, required String subtitle, required String type, VoidCallback? onTap, Function(bool)? onChanged, bool? value, bool isHighlighted = false, bool isLast = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.pxw, vertical: 12.pxh),
        margin: EdgeInsets.only(bottom: 16.pxh),
        decoration: BoxDecoration(
          color: isHighlighted ? AppTheme().current.themeColor1.withOpacity(0.2) : const Color(0xFF283D49),
          borderRadius: BorderRadius.circular(12.pxw),
          border: Border.all(color: isHighlighted ? AppTheme().current.themeColor1 : const Color(0xFF37505E), width: 1.pxw),


        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(color: Colors.white, fontSize: 14.pxSp, fontWeight: FontWeight.w600),
                  ),
                  if (subtitle.isNotEmpty) ...[
                    Gap(4.pxh),
                    Text(
                      subtitle,
                      style: TextStyle(color: AppTheme().current.textColor3, fontSize: 12.pxSp),
                    ),
                  ],
                ],
              ),
            ),
            if (type == 'navigation')
              Icon(Icons.arrow_forward_ios, color: AppTheme().current.textColor3, size: 16.pxw)
            else if (type == 'switch')
              Switch(value: value ?? false, onChanged: onChanged, activeColor: Colors.green, activeTrackColor: Colors.green.withOpacity(0.3), inactiveThumbColor: Colors.grey, inactiveTrackColor: Colors.grey.withOpacity(0.3)),
          ],
        ),
      ),
    );
  }
}
