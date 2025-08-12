import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roomcard/utils/common_extension/common_extension.dart';
import 'package:roomcard/utils/num_px.dart';

/// 游戏操作区域组件
class GameActionSection extends StatelessWidget {
  final String leftTitle;
  final String rightTitle;
  final VoidCallback leftOnTap;
  final VoidCallback rightOnTap;

  const GameActionSection({
    super.key,
    required this.leftTitle,
    required this.rightTitle,
    required this.leftOnTap,
    required this.rightOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375.pxw,
      height: 90.pxh,
      child: Stack(
        children: [
          // 左侧按钮
          Positioned(
            left: 12.pxw,
            child: _button(
              186.pxw,
              66.pxh,
              'assets/images/home/俱乐部-主页-创建按钮.png',
              leftTitle,
              leftOnTap,
            ),
          ),
          // 右侧按钮
          Positioned(
            top: 5.pxh,
            right: 12.pxw,
            child: _button(
              186.pxw,
             61.pxh,
             'assets/images/home/俱乐部-主页-加入按钮.png',
              rightTitle,
              rightOnTap,
            ),
          ),
        ],
      ),
    );
  }

  Widget _button (double width,double height,String imagePath,String title,VoidCallback onTap){
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.fill,
        ),
      ),
      width: width,
      height: height,
      child: Center(
        child: Text(title,style: TextStyle(
          fontSize: 14.pxSp,
          fontWeight: FontWeight.w600,
        )).paddingOnly(bottom: 10.pxh,left: 40.pxw),
      ),
    ).onTap(
      onTap
    );
  }
} 