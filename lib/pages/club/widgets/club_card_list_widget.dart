import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:roomcard/utils/common_extension/common_extension.dart';
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
          style: TextStyle(color: AppTheme().current.textColor4, fontSize: 14.pxSp),
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
      height: 124.pxh,
      margin: EdgeInsets.only(bottom: 16.pxh),
      padding: EdgeInsets.only(left: 17.pxh, top: 16.pxh, right: 17.pxh),
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/club/club_list_bg.png'), fit: BoxFit.fill),
        color: const Color(0xFF2A3A4A),
        borderRadius: BorderRadius.circular(12.pxw),
      ),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 头像
                    Container(
                      width: 60.pxw,
                      height: 60.pxh,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(image: AssetImage('assets/images/club/img_club_head_0.png'), fit: BoxFit.cover),
                      ),
                    ),
                    Gap(14.pxw),
                    // 中间内容区域
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 俱乐部标题
                          Text(
                            club.title,
                            style: TextStyle(color: Colors.white, fontSize: 16.pxSp, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 8.pxh),
                          // 俱乐部ID
                          Row(
                            children: [
                              Container(width: 16.pxw, height: 16.pxh, child: Image.asset('assets/images/club_name_icon.png')),

                              SizedBox(width: 2.pxw),
                              Text(
                                club.clubId,
                                style: TextStyle(color: Color(0xFFB3BEC1), fontSize: 12.pxSp, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.pxh),
                          // 成员数量
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 6.pxw, vertical: 2.pxh), // 保证内部有点留白
                            decoration: BoxDecoration(color: Color(0x26FFFFFF), borderRadius: BorderRadius.circular(80.pxw)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min, // 宽度随内容变化
                              mainAxisAlignment: MainAxisAlignment.center, // 水平居中
                              crossAxisAlignment: CrossAxisAlignment.center, // 垂直居中
                              children: [
                                Container(width: 10.pxw, height: 10.pxh, child: Image.asset('assets/images/iconSettingMenuAccount.png')),

                                SizedBox(width: 4.pxw),
                                Text(
                                  '${club.memberCount}',
                                  style: TextStyle(color: Color(0xFFB3BEC1), fontSize: 10.pxSp, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    // 右侧信息区域
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // 右侧玩家信息
                        Container(
                          width: 49.pxw,
                          height: 18.pxh,
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(left: 10.pxw),
                          decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/game/img_level_1.png'))),
                          child: Text(
                            'VIP1',
                            style: TextStyle(color: AppTheme().current.textColor1, fontSize: 10.pxSp, fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(height: 12.pxh),
                        // 牌局数量

                        // 右侧玩家信息
                        Container(
                          width: 75.pxh,
                          height: 35.pxw,
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(left: 30.pxw),
                          decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/home/room_number.png"))),
                          child: Text(
                            '${club.activeGames}牌局',
                            style: TextStyle(color: AppTheme().current.textColor1, fontSize: 12.pxSp, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // 创建人标签
                if (club.isCreator)
                  Positioned(
                    top: 50.pxh,
                    left: (60 / 2 - 44 / 2).pxw,
                    child: Container(
                      alignment: Alignment.center,
                      width: 44.pxw,
                      height: 16.pxh,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80.pxw),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter, // 180deg 就是从上到下
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFFE0A965), // #E0A965
                            Color(0xFFBE7A24), // #BE7A24
                          ],
                        ),
                      ),
                      child: Text(
                        '创建人',
                        style: TextStyle(color: Colors.white, fontSize: 10.pxSp, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Container(
            height: 24.pxh,
            width: double.infinity,
            padding: EdgeInsets.only(bottom: 4.pxh),
            child: Row(
              children: [
                Spacer(),
                Container(width: 18.pxw, height: 18.pxh, child: Image.asset('assets/images/iconArrowNext.png')),
              ],
            ),
          ),
        ],
      ),
    ).onTap((){
      Get.toNamed('/club-home');

    });
  }
}
