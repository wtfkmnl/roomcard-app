import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roomcard/theme/app_theme.dart';
import 'package:roomcard/utils/num_px.dart';
import '../../r.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/custom_slider_widget.dart';
import '../../widgets/custom_dropdown_widget.dart';
import '../../widgets/custom_switch.dart';
import 'create_room_logic.dart';
import 'create_room_state.dart';

class CreateRoomPage extends StatelessWidget {
  const CreateRoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<CreateRoomLogic>();
    final state = Get.find<CreateRoomLogic>().state;

    return Scaffold(
      backgroundColor: const Color(0xFF1C2C36),
      appBar: const CommonAppBar(title: '创建朋友局'),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.pxw),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 游戏模式选择
            _buildGameModeSection(logic, state),
            SizedBox(height: 24.pxh),

            // 房间名称/ID
            _buildRoomNameSection(logic, state),
            SizedBox(height: 24.pxh),

            // 小盲/大盲和带入记分牌
            _buildBlindsAndScoreSection(logic, state),
            SizedBox(height: 24.pxh),

            // 人满即开
            _buildPlayersToStartSection(logic, state),
            SizedBox(height: 24.pxh),

            // 前注设置
            _buildAnteSection(logic, state),
            SizedBox(height: 24.pxh),

            // 牌局时长
            _buildGameDurationSection(logic, state),
            SizedBox(height: 24.pxh),

            // 买入设置
            _buildBuyInSection(logic, state),
            SizedBox(height: 32.pxh),
            // 模式切换
            _buildModeSwitch(logic, state),
            SizedBox(height: 12.pxh),

            // 创建按钮
            _buildCreateButton(logic),
            //底部安全距离
            SizedBox(height: MediaQuery.of(context).padding.bottom + 16.pxh),
          ],
        ),
      ),
    );
  }

  Widget _buildGameModeSection(CreateRoomLogic logic, CreateRoomState state) {
    final gameModes = ['经典德州', '奥马哈', '德州短牌', 'AOF'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.pxh),
        Row(
          children: gameModes.asMap().entries.map((entry) {
            final index = entry.key;
            final mode = entry.value;
            return Expanded(
              child: Obx(
                () => GestureDetector(
                  onTap: () => logic.selectGameMode(index),
                  child: Container(
                    margin: EdgeInsets.only(right: index < gameModes.length - 1 ? 8.pxw : 0),
                    padding: EdgeInsets.symmetric(vertical: 10.pxh),
                    decoration: BoxDecoration(color: state.selectedGameMode.value == index ? const Color(0xFFF9C678) : const Color(0xFF0F212E), borderRadius: BorderRadius.circular(20.pxw)),
                    child: Text(
                      mode,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: state.selectedGameMode.value == index ? const Color(0xFF703E00) : Colors.white, fontSize: 14.pxSp, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildRoomNameSection(CreateRoomLogic logic, CreateRoomState state) {
    return Container(
      width: 343.pxw,
      height: 48.pxh,
      padding: EdgeInsets.symmetric(horizontal: 24.5.pxw, vertical: 10.pxh),
      decoration: BoxDecoration(
        color: const Color(0xFF0F212E),
        borderRadius: BorderRadius.circular(14.pxw),
        border: Border.all(color: const Color(0xFF2F4553), width: 2.pxw),
        boxShadow: [
          BoxShadow(color: const Color(0xFF000000).withOpacity(0.2), offset: const Offset(0, 1), blurRadius: 3, spreadRadius: 0),
          BoxShadow(color: const Color(0xFF000000).withOpacity(0.12), offset: const Offset(0, 1), blurRadius: 2, spreadRadius: 0),
        ],
      ),
      child: TextField(
        controller: logic.roomNameController,
        focusNode: logic.roomNameFocusNode,
        style: TextStyle(color: Colors.white, fontSize: 14.pxSp, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: '请输入房间名称',
          hintStyle: TextStyle(color: const Color(0xFF57646D), fontSize: 14.pxSp, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget _buildBlindsAndScoreSection(CreateRoomLogic logic, CreateRoomState state) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '小盲/大盲',
                    style: TextStyle(color: Colors.white, fontSize: 14.pxSp),
                  ),
                  SizedBox(height: 8.pxh),
                  Text(
                    '1 / 2',
                    style: TextStyle(color: Colors.white, fontSize: 16.pxSp, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            SizedBox(width: 24.pxw),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '带入记分牌',
                    style: TextStyle(color: Colors.white, fontSize: 14.pxSp),
                  ),
                  SizedBox(height: 8.pxh),
                  Text(
                    '100',
                    style: TextStyle(color: Colors.white, fontSize: 16.pxSp, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12.pxw),
        CustomSliderWidget(currentIndex: 0,pointsCount:5, onChanged: (index) => print('Blinds value: $index')),
      ],
    );
  }

  Widget _buildPlayersToStartSection(CreateRoomLogic logic, CreateRoomState state) {
    final players = ['2', '3', '4', '5', '6'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '人满即开',
          style: TextStyle(color: Colors.white, fontSize: 14.pxSp),
        ),
        SizedBox(height: 12.pxh),
        CustomSliderWidget(needStepIndex:true,currentIndex: 0,pointsCount:5, onChanged: (index) => print('Blinds value: $index')),
      ],
    );
  }

  Widget _buildAnteSection(CreateRoomLogic logic, CreateRoomState state) {
    final antes = ['0', '1', '2', '3', '4', '6', '8', '10'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '前注设置',
          style: TextStyle(color: Colors.white, fontSize: 14.pxSp),
        ),
        SizedBox(height: 12.pxh),
        CustomSliderWidget(needStepIndex:true,currentIndex: 0,pointsCount:10, onChanged: (index) => print('Blinds value: $index')),
      ],
    );
  }

  Widget _buildGameDurationSection(CreateRoomLogic logic, CreateRoomState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '牌局时长',
              style: TextStyle(color: Colors.white, fontSize: 14.pxSp),
            ),
            Text(
              '${state.gameDuration.value.toStringAsFixed(1)}小时',
              style: TextStyle(color: Colors.white, fontSize: 14.pxSp, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        SizedBox(height: 12.pxh),
        CustomSliderWidget(currentIndex: 0,pointsCount:3, onChanged: (index) => print('Blinds value: $index')),
      ],
    );
  }

  Widget _buildBuyInSection(CreateRoomLogic logic, CreateRoomState state) {
    return Container(
      //背景色#283D49
      decoration: BoxDecoration(
        color: const Color(0xFF283D49),
        borderRadius: BorderRadius.circular(14.pxw),
       border: Border.all(
          color: const Color(0xFF37505E),
          width: 1.pxw,
        ),

      ),
      padding: EdgeInsets.symmetric(horizontal: 16.pxw,vertical: 10.pxh),

      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '最小买入记分牌',
            style: TextStyle(color: Color(0xFFB3BEC1), fontSize: 12.pxSp),
          ),
          SizedBox(height: 8.pxh),
          Obx(() => CustomDropdownWidget<int>(
            value: state.minBuyIn.value,
            items: [50, 100, 200, 500, 1000, 2000, 5000],
            onChanged: (value) => logic.setMinBuyIn(value),
            height: 48.pxh,
          )),
          SizedBox(height: 16.pxh),
          Text(
            '记分牌买入上限',
            style: TextStyle(color: Color(0xFFB3BEC1), fontSize: 12.pxSp),
          ),
          SizedBox(height: 8.pxh),
          Obx(() => CustomDropdownWidget<int>(
            value: state.buyInLimit.value,
            items: [100, 200, 500, 1000, 2000, 5000, 10000, 20000],
            onChanged: (value) => logic.setBuyInLimit(value),
            height: 48.pxh,
          )),
        ],
      ),
    );
  }

  Widget _buildModeSwitch(CreateRoomLogic logic, CreateRoomState state) {
    return Container(
      width: double.infinity,
      //背景色#283D49
      decoration: BoxDecoration(
        color: const Color(0xFF283D49),
        borderRadius: BorderRadius.circular(14.pxw),
       border: Border.all(
          color: const Color(0xFF37505E),
          width: 1.pxw,
        ),

      ),
      padding: EdgeInsets.symmetric(horizontal: 16.pxw,vertical: 10.pxh),

      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [
              Text(
                'Straddle',
                style: TextStyle(color: Colors.white, fontSize: 12.pxSp),
              ),
              Spacer(),
              CustomSwitch(value: false, onChanged: (value) => (){}),
            ],
          ),
          SizedBox(height: 8.pxh),


          Row(
            children: [
              Text(
                '保险模式',
                style: TextStyle(color: Colors.white, fontSize: 12.pxSp),
              ),
              Spacer(),
              CustomSwitch(value: false, onChanged: (value) => (){}),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCreateButton(CreateRoomLogic logic) {
     return Column(
       children: [
         Row(
           children: [
             Text('消耗:0',
             style: TextStyle(color: Colors.white, fontSize: 12.pxSp)
             ),
             Image.asset('assets/images/home/diamond.png',width: 14.pxw,height: 14.pxw,),

           ],
         ),
         SizedBox(height: 4.pxh),
         GestureDetector(
           onTap: logic.createRoom,
           child: Container(
             height: 230/3.pxh,
             decoration: BoxDecoration(
               image: DecorationImage(
                 image: AssetImage('assets/images/game/game_btn_bg.png'),
                 fit: BoxFit.fitHeight,
               ),
             ),
             alignment: Alignment.center,
             child: Text(
               '开局',
               style: TextStyle(
                 color: Color(0xFF703E00),
                 fontSize: 18.pxSp,
                 fontWeight: FontWeight.w600,
               ),
             ).marginOnly(bottom: 8.pxh),
           ),
         )
       ],
     );
  }
}
