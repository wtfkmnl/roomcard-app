import 'package:flutter/material.dart';
import 'package:roomcard/utils/num_px.dart';
import 'package:roomcard/theme/app_theme.dart';
import '../models/club_card_data.dart';

/// 俱乐部卡片列表组件
class ClubCardListWidget extends StatelessWidget {
  final List<ClubCardData> clubs;

  const ClubCardListWidget({super.key, required this.clubs});

  @override
  Widget build(BuildContext context) {
    if (clubs.isEmpty) {
      return Center(
        child: Text(
          '暂无俱乐部数据',
          style: TextStyle(
            color: AppTheme().current.textColor4,
            fontSize: 14.pxSp,
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: clubs.length,
      itemBuilder: (context, index) {
        return _buildClubCard(clubs[index]);
      },
    );
  }

  /// 构建俱乐部卡片
  Widget _buildClubCard(ClubCardData club) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.pxh),
      padding: EdgeInsets.all(16.pxw),
      decoration: BoxDecoration(
        color: const Color(0xFF2A3A4A),
        borderRadius: BorderRadius.circular(12.pxw),
      ),
      child: Row(
        children: [
          // 左侧头像和创建人标签
          Column(
            children: [
              // 头像
              Container(
                width: 60.pxw,
                height: 60.pxh,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(club.avatarPath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 8.pxh),
              // 创建人标签
              if (club.isCreator)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.pxw, vertical: 4.pxh),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF6B35),
                    borderRadius: BorderRadius.circular(4.pxw),
                  ),
                  child: Text(
                    '创建人',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.pxSp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
          
          SizedBox(width: 16.pxw),
          
          // 中间内容区域
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 俱乐部标题
                Text(
                  club.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.pxSp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8.pxh),
                // 俱乐部ID
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: const Color(0xFFFFD700),
                      size: 16.pxw,
                    ),
                    SizedBox(width: 4.pxw),
                    Text(
                      club.clubId,
                      style: TextStyle(
                        color: AppTheme().current.textColor4,
                        fontSize: 12.pxSp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.pxh),
                // 成员数量
                Row(
                  children: [
                    Icon(
                      Icons.people,
                      color: AppTheme().current.textColor4,
                      size: 16.pxw,
                    ),
                    SizedBox(width: 4.pxw),
                    Text(
                      '${club.memberCount}',
                      style: TextStyle(
                        color: AppTheme().current.textColor4,
                        fontSize: 12.pxSp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // 右侧信息区域
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // 公开/私密标签
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.pxw, vertical: 4.pxh),
                decoration: BoxDecoration(
                  color: const Color(0xFF4FC3F7),
                  borderRadius: BorderRadius.circular(4.pxw),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 12.pxw,
                    ),
                    SizedBox(width: 4.pxw),
                    Text(
                      '大众',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.pxSp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.pxh),
              // 牌局数量
              Container(
                padding: EdgeInsets.all(8.pxw),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppTheme().current.textColor4,
                    style: BorderStyle.solid,
                    width: 1.pxw,
                  ),
                  borderRadius: BorderRadius.circular(8.pxw),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.casino,
                      color: AppTheme().current.textColor4,
                      size: 16.pxw,
                    ),
                    SizedBox(width: 4.pxw),
                    Text(
                      '${club.activeGames}牌局',
                      style: TextStyle(
                        color: AppTheme().current.textColor4,
                        fontSize: 12.pxSp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.pxh),
              // 右箭头
              Icon(
                Icons.arrow_forward_ios,
                color: AppTheme().current.textColor4,
                size: 16.pxw,
              ),
            ],
          ),
        ],
      ),
    );
  }
} 