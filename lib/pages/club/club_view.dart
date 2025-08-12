import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:roomcard/utils/num_px.dart';
import 'package:roomcard/theme/app_theme.dart';
import '../home/widgets/game_action_section.dart';
import 'club_logic.dart';
import 'widgets/club_card_list_widget.dart';

class ClubPage extends StatelessWidget {
  const ClubPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(ClubLogic());
    
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // 创建/加入俱乐部区域
            GameActionSection(
              leftTitle: '创建俱乐部',
              rightTitle: '加入俱乐部',
              leftOnTap: () => logic.onCreateClub(),
              rightOnTap: () => logic.onJoinClub(),
            ),
            

            // 标题：我加入的俱乐部
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.pxw),
              child: Row(
                children: [
                  Text(
                    '我加入的俱乐部',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.pxSp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            
            Gap(16.pxh),
            
            // 俱乐部卡片列表
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.pxw),
                child: Obx(() => ClubCardListWidget(
                  clubs: logic.state.clubCardList.value,
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 