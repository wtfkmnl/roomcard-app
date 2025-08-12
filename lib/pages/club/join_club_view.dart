import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
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
      backgroundColor: const Color(0xFF1A1A1A),
      body: SafeArea(
        child: Column(
          children: [
            // 头部
            _buildHeader(),
            
            Gap(32.pxh),
            
            // 主要内容区域
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.pxw),
                child: Column(
                  children: [
                    // 输入提示
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.pxw),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2A2A2A),
                        borderRadius: BorderRadius.circular(8.pxw),
                      ),
                      child: Text(
                        '输入俱乐部ID',
                        style: TextStyle(
                          color: AppTheme().current.textColor4,
                          fontSize: 14.pxSp,
                        ),
                      ),
                    ),
                    
                    Gap(24.pxh),
                    
                    // 俱乐部ID输入框
                    _buildClubIdInput(),
                    
                    const Spacer(),
                    
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

  /// 构建头部
  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.pxw, vertical: 16.pxh),
      child: Row(
        children: [
          // 返回按钮
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 40.pxw,
              height: 40.pxh,
              decoration: BoxDecoration(
                color: const Color(0xFF3A3A3A),
                borderRadius: BorderRadius.circular(8.pxw),
              ),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 20.pxw,
              ),
            ),
          ),
          
          const Spacer(),
          
          // 标题
          Text(
            '加入俱乐部',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.pxSp,
              fontWeight: FontWeight.w600,
            ),
          ),
          
          const Spacer(),
          
          // 占位，保持标题居中
          SizedBox(width: 40.pxw),
        ],
      ),
    );
  }

  /// 构建俱乐部ID输入框
  Widget _buildClubIdInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 标签
        Text(
          '俱乐部ID',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.pxSp,
            fontWeight: FontWeight.w500,
          ),
        ),
        
        Gap(16.pxh),
        
        // ID输入框组
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(8, (index) => _buildIdInputBox(index)),
        ),
        
        Gap(24.pxh),
        
        // 点击输入提示
        GestureDetector(
          onTap: _showNumericKeypad,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 12.pxh),
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFF2A2A2A),
                style: BorderStyle.solid,
                width: 1.pxw,
              ),
              borderRadius: BorderRadius.circular(8.pxw),
            ),
            child: Center(
              child: Text(
                '点击输入',
                style: TextStyle(
                  color: AppTheme().current.textColor4,
                  fontSize: 14.pxSp,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// 构建ID输入框
  Widget _buildIdInputBox(int index) {
    return Obx(() {
      final hasValue = state.clubId[index].isNotEmpty;
      final isFocused = state.currentFocusIndex.value == index;
      
      return Container(
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
          colors: [Color(0xFFDAA520), Color(0xFFB8860B)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(8.pxw),
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
    logic.onNumberPressed(number);
  }

  @override
  void onDeletePressed() {
    logic.onDeletePressed();
  }

  @override
  void onPastePressed() {
    logic.onPastePressed();
  }
} 