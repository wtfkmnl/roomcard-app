import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:roomcard/utils/common_extension/common_extension.dart';
import 'package:roomcard/utils/num_px.dart';
import 'package:roomcard/theme/app_theme.dart';
import 'join_club_logic.dart';
import '../../widgets/numeric_keypad_widget.dart';

/// 加入俱乐部页面
class JoinClubPage extends StatefulWidget {
  const JoinClubPage({super.key});

  @override
  State<JoinClubPage> createState() => _JoinClubPageState();
}

class _JoinClubPageState extends State<JoinClubPage> implements NumericKeypadCallback {
  final logic = Get.put(JoinClubLogic());
  final state = Get.find<JoinClubLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
Container(
  width: double.infinity,
  child: Stack(
    alignment: Alignment.center,
    children: [
      Positioned(left:16.pxw,child: Image.asset('assets/images/club/back_icon.png', width: 28.pxw,height: 28.pxh,).onTap(() => Get.back())),
      Text('加入俱乐部', style: TextStyle(
        color: Colors.white,
        fontSize: 18.pxSp,
        fontWeight: FontWeight.w600,
      )),
    ],
  ),
),
            // 主要内容区域
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.pxw),
                child: Column(
                  children: [
                    Gap(32.pxh),
                    
                    // 输入提示区域
                    _buildInputHintSection(),
                    
                    Gap(24.pxh),
                    
                    // 俱乐部ID输入框
                    _buildClubIdInput(),

                    Gap(24.pxh),
                    // 确认按钮
                    _buildConfirmButton(),
                    
                    Gap(32.pxh),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  /// 构建输入提示区域
  Widget _buildInputHintSection() {
    return Container(
      width: 100.pxw,
      padding: EdgeInsets.symmetric(horizontal: 6.pxw,vertical: 6.pxh),
      decoration: BoxDecoration(
        color: const Color(0xAB2A2A2A),
        borderRadius: BorderRadius.circular(8.pxw),
        border: Border.all(
          color: const Color(0xAB3A3A3A),
          width: 1.pxw,
        ),
      ),
      child: Text(
        '输入俱乐部ID',
        style: TextStyle(
          color: AppTheme().current.textColor1,
          fontSize: 14.pxSp,
        ),
      ),
    );
  }

  /// 构建俱乐部ID输入框
  Widget _buildClubIdInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ID输入框组
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(8, (index) => _buildIdInputBox(index)),
        ),
      ],
    );
  }

  /// 构建ID输入框
  Widget _buildIdInputBox(int index) {
    return Obx(() {
      final hasValue = state.clubId[index].isNotEmpty;
      final isFocused = state.currentFocusIndex.value == index;
      
      return GestureDetector(
        onTap: () {
          // 点击数字框时设置焦点并弹出键盘
          state.currentFocusIndex.value = index;
          _showNumericKeypad();
        },
        child: Container(
          width: 36.pxw,
          height: 44.pxh,
          decoration: BoxDecoration(
            color: hasValue ? const Color(0xFF2A3F4F) : Colors.transparent,
            border: Border.all(
              color: isFocused ? const Color(0xFFFF6B35) : const Color(0xFF2A2A2A),
              width: 2.pxw,
            ),
            borderRadius: BorderRadius.circular(6.pxw),
          ),
          child: Center(
            child: Text(
              state.clubId[index],
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.pxSp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      );
    });
  }

  /// 构建确认按钮
  Widget _buildConfirmButton() {
    return Container(
      width: double.infinity,
      height: 48.pxh,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFDAA520), Color(0xFFB8860B)], // 金色渐变
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(8.pxw),
        boxShadow: [
          BoxShadow(
            color: const Color(0x40DAA520),
            offset: Offset(0, 4.pxh),
            blurRadius: 8.pxw,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => logic.joinClub(),
          borderRadius: BorderRadius.circular(8.pxw),
          child: Center(
            child: Text(
              '确定',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.pxSp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 显示数字键盘
  void _showNumericKeypad() {
    Get.bottomSheet(
      NumericKeypadWidget(
        callback: this,
        title: '请输入俱乐部ID',
        showCloseButton: true,
        onClose: () => Get.back(),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  // NumericKeypadCallback 实现
  @override
  void onNumberPressed(String number) {
    // 在当前焦点位置输入数字
    if (state.currentFocusIndex.value < 8) {
      state.clubId[state.currentFocusIndex.value] = number;
      // 自动移动到下一个输入框
      if (state.currentFocusIndex.value < 7) {
        state.currentFocusIndex.value++;
      }
    }
  }

  @override
  void onDeletePressed() {
    // 删除当前焦点位置的数字
    if (state.currentFocusIndex.value > 0) {
      state.currentFocusIndex.value--;
      state.clubId[state.currentFocusIndex.value] = '';
    } else if (state.currentFocusIndex.value == 0 && state.clubId[0].isNotEmpty) {
      state.clubId[0] = '';
    }
  }

  @override
  void onPastePressed() {
    logic.onPastePressed();
  }
} 