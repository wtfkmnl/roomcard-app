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
            child:
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/home/create_club_btn.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                width:   186.pxw,
                height:   66.pxh,
                child: Stack(
                  children: [
                    Positioned(left: 22.pxw,top:-8.pxh,child:  Container(width: 54.pxw, height: 62.pxh, child: Image.asset('assets/images/home/btn_icon_2.png'))),
                    Center(
                      child: Text(leftTitle,style: TextStyle(
                        fontSize: 14.pxSp,
                        fontWeight: FontWeight.w600,
                      )).paddingOnly(bottom: 10.pxh,left: 40.pxw),
                    )
                  ],
                ),
              ).onTap(leftOnTap)
          ),
          // 右侧按钮
          Positioned(
            top: 5.pxh,
            right: 12.pxw,
            child:
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/home/add_club_btn.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                width:   186.pxw,
                height:   61.pxh,
                child: Stack(

                  children: [
                    Positioned(left: 22.pxw,top:-8.pxh,child:  Container(width: 67.pxw, height: 56.pxh, child: Image.asset('assets/images/home/btn_icon_1.png'))),
                    Center(
                      child: Text(rightTitle,style: TextStyle(
                        fontSize: 14.pxSp,
                        fontWeight: FontWeight.w600,
                      )).paddingOnly(bottom: 10.pxh,left: 50.pxw),
                    )
                  ],
                ),
              ).onTap(rightOnTap)
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
      child: Stack(

        children: [
         Positioned(left: 20.pxw,child:  Container(width: 56.pxw, height: 46.pxh, child: Image.asset('assets/images/home/btn_icon_1.png'))),
          Center(
            child: Text(title,style: TextStyle(
              fontSize: 14.pxSp,
              fontWeight: FontWeight.w600,
            )).paddingOnly(bottom: 10.pxh,left: 40.pxw),
          )
        ],
      ),
    ).onTap(
      onTap
    );
  }
} 