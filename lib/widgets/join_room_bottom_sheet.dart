import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:roomcard/utils/num_px.dart';
import 'numeric_keypad_widget.dart';

class JoinRoomBottomSheet extends StatefulWidget {
  const JoinRoomBottomSheet({super.key});

  @override
  State<JoinRoomBottomSheet> createState() => _JoinRoomBottomSheetState();
}

class _JoinRoomBottomSheetState extends State<JoinRoomBottomSheet> implements NumericKeypadCallback {
  final List<String> roomCode = List.filled(6, '');
  int currentFocusIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.7,
      decoration: const BoxDecoration(
        color: Color(0xFF1C2C36),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // 标题
          Container(
            padding: EdgeInsets.symmetric(vertical: 20.pxh),
            child: Text(
              '加入牌局',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.pxSp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          
          // 提示文字
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.pxw),
            child: Text(
              '请输入六位房间号',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 14.pxSp,
              ),
            ),
          ),
          
          SizedBox(height: 24.pxh),
          
          // 房间号输入框
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.pxw),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (index) => _buildRoomCodeInput(index)),
            ),
          ),
          
          SizedBox(height: 32.pxh),
          
          // 数字键盘
          Expanded(
            child: NumericKeypadWidget(
              callback: this,
              title: '请输入六位房间号',
              showCloseButton: false,
            ),
          ),
          
          SizedBox(height: 20.pxh),
        ],
      ),
    );
  }

  Widget _buildRoomCodeInput(int index) {
    final isFocused = currentFocusIndex == index;
    final hasValue = roomCode[index].isNotEmpty;
    
    return Container(
      width: 40.pxw,
      height: 48.pxh,
      decoration: BoxDecoration(
        color: hasValue ? const Color(0xFF2A3F4F) : Colors.transparent,
        border: Border.all(
          color: isFocused ? const Color(0xFFFF6B35) : const Color(0xFF2A3F4F),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8.pxw),
      ),
      child: Center(
        child: Text(
          roomCode[index],
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.pxSp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // NumericKeypadCallback 实现
  @override
  void onNumberPressed(String number) {
    if (currentFocusIndex < 6) {
      setState(() {
        roomCode[currentFocusIndex] = number;
        if (currentFocusIndex < 5) {
          currentFocusIndex++;
        }
      });
    }
  }

  @override
  void onDeletePressed() {
    if (currentFocusIndex > 0) {
      setState(() {
        currentFocusIndex--;
        roomCode[currentFocusIndex] = '';
      });
    } else if (currentFocusIndex == 0 && roomCode[0].isNotEmpty) {
      setState(() {
        roomCode[0] = '';
      });
    }
  }

  @override
  void onPastePressed() async {
    final ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);
    if (data != null && data.text != null && data.text!.length >= 6) {
      final roomCodeString = data.text!.substring(0, 6);
      if (roomCodeString.length == 6 && RegExp(r'^\d{6}$').hasMatch(roomCodeString)) {
        setState(() {
          for (int i = 0; i < 6; i++) {
            roomCode[i] = roomCodeString[i];
          }
          currentFocusIndex = 5; // 粘贴后光标在最后一个输入框
        });
      } else {
        Get.snackbar('提示', '剪贴板内容不符合房间号格式');
      }
    } else {
      Get.snackbar('提示', '剪贴板内容不足6位或不是纯数字');
    }
  }
} 