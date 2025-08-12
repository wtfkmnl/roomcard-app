import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:roomcard/utils/num_px.dart';

/// 数字键盘回调接口
abstract class NumericKeypadCallback {
  void onNumberPressed(String number);
  void onDeletePressed();
  void onPastePressed();
}

/// 公共数字键盘组件
class NumericKeypadWidget extends StatelessWidget {
  final NumericKeypadCallback callback;
  final String title;
  final bool showCloseButton;
  final VoidCallback? onClose;

  const NumericKeypadWidget({
    super.key,
    required this.callback,
    this.title = '请输入',
    this.showCloseButton = false,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1C2C36).withOpacity(0.95),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 头部
          if (showCloseButton) _buildHeader(),
          
          // 数字键盘
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.pxw, vertical: 20.pxh),
            child: Column(
              children: [
                // 第一行：1, 2, 3
                Row(
                  children: [
                    Expanded(child: _buildNumberButton('1')),
                    SizedBox(width: 12.pxw),
                    Expanded(child: _buildNumberButton('2')),
                    SizedBox(width: 12.pxw),
                    Expanded(child: _buildNumberButton('3')),
                  ],
                ),
                
                SizedBox(height: 12.pxh),
                
                // 第二行：4, 5, 6
                Row(
                  children: [
                    Expanded(child: _buildNumberButton('4')),
                    SizedBox(width: 12.pxw),
                    Expanded(child: _buildNumberButton('5')),
                    SizedBox(width: 12.pxw),
                    Expanded(child: _buildNumberButton('6')),
                  ],
                ),
                
                SizedBox(height: 12.pxh),
                
                // 第三行：7, 8, 9
                Row(
                  children: [
                    Expanded(child: _buildNumberButton('7')),
                    SizedBox(width: 12.pxw),
                    Expanded(child: _buildNumberButton('8')),
                    SizedBox(width: 12.pxw),
                    Expanded(child: _buildNumberButton('9')),
                  ],
                ),
                
                SizedBox(height: 12.pxh),
                
                // 第四行：粘贴, 0, 删除
                Row(
                  children: [
                    Expanded(child: _buildPasteButton()),
                    SizedBox(width: 12.pxw),
                    Expanded(child: _buildNumberButton('0')),
                    SizedBox(width: 12.pxw),
                    Expanded(child: _buildDeleteButton()),
                  ],
                ),
              ],
            ),
          ),
          
          SizedBox(height: 20.pxh),
        ],
      ),
    );
  }

  /// 构建头部
  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.pxw, vertical: 16.pxh),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.pxSp,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          if (onClose != null)
            GestureDetector(
              onTap: onClose,
              child: Container(
                width: 32.pxw,
                height: 32.pxh,
                decoration: BoxDecoration(
                  color: const Color(0xFF2A3F4F),
                  borderRadius: BorderRadius.circular(16.pxw),
                ),
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 18.pxw,
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// 构建数字按钮
  Widget _buildNumberButton(String number) {
    return GestureDetector(
      onTap: () => callback.onNumberPressed(number),
      child: Container(
        height: 48.pxh,
        decoration: BoxDecoration(
          color: const Color(0xFF2A3F4F),
          borderRadius: BorderRadius.circular(8.pxw),
        ),
        child: Center(
          child: Text(
            number,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.pxSp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  /// 构建粘贴按钮
  Widget _buildPasteButton() {
    return GestureDetector(
      onTap: () => callback.onPastePressed(),
      child: Container(
        height: 48.pxh,
        decoration: BoxDecoration(
          color: const Color(0xFFFF6B35),
          borderRadius: BorderRadius.circular(8.pxw),
        ),
        child: Center(
          child: Text(
            '粘贴',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.pxSp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  /// 构建删除按钮
  Widget _buildDeleteButton() {
    return GestureDetector(
      onTap: () => callback.onDeletePressed(),
      child: Container(
        height: 48.pxh,
        decoration: BoxDecoration(
          color: const Color(0xFF2A3F4F),
          borderRadius: BorderRadius.circular(8.pxw),
        ),
        child: Center(
          child: Icon(
            Icons.close,
            color: Colors.white,
            size: 20.pxw,
          ),
        ),
      ),
    );
  }
} 