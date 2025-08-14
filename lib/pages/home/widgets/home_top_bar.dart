import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:roomcard/utils/common_extension/common_extension.dart';
import 'package:roomcard/utils/num_px.dart';
import 'package:roomcard/theme/app_theme.dart';
import '../../../r.dart';
import '../home_logic.dart';

/// 首页顶部导航栏组件
class HomeTopBar extends StatelessWidget {
  final HomeLogic logic;

  const HomeTopBar({
    super.key,
    required this.logic,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.pxw, vertical: 16.pxh),
      child: Row(
        children: [
          // 侧边抽屉开关按钮
          GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: Container(
              width: 35.pxw,
              height: 35.pxh,
              decoration: BoxDecoration(
                color: Color(0x12FDFFFF), // 背景色
                borderRadius: BorderRadius.circular(8.pxw),
              ),
              child: Image.asset('assets/images/home/Home_header_menu.png'),
            ),
          ),
          
         Spacer(),
          
          // 金额展示
          Obx(() => Container(
            height: 40.pxh,
            width:151.pxw,
            decoration: BoxDecoration(
              color: '#FFFFFF'.hexToColor.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(12.pxw),
              border: Border.all(
                color: '#FFFFFF'.hexToColor.withValues(alpha: 0.08),         // 边框颜色，8%透明
                width: 2.pxw,                                                   // 边框宽度，根据需求调整
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: 10.pxw),
                Image.asset('assets/images/home/diamond.png',width: 14.pxw,height: 14.pxw,),
                Spacer(),
                Text(
                  '${logic.state.userBalance.value}',
                  style: TextStyle(
                    color: AppTheme().current.textColor1,
                    fontSize: 14.pxSp,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                Spacer(),

                // 充值按钮（加号）
                GestureDetector(
                  onTap: logic.goToRecharge,
                  child: Image.asset('assets/images/home/Home_title_.png',width: 32.pxw,height: 32.pxw,),
                ),
                SizedBox(width: 5.pxw),
              ],
            ),
          )),


          SizedBox(width: 10.pxw),
          
         Container(
           decoration: BoxDecoration(
             color: Color(0x12FDFFFF),
             borderRadius: BorderRadius.circular(8.pxw),
           ),
           width: 70.pxw,
           height: 35.pxh,
           child: Row(
             mainAxisAlignment:MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               Container(
                 width: 14.pxw,height: 14.pxh,
                 child: Image.asset('assets/images/home/Group.png' ,    fit: BoxFit.contain,),
               ),
         Gap(10.pxw),
               Container(
                 width: 1.pxw,
                 height: 18.pxh,
                 color: Color(0x2EFFFFFF),
               ),
               Gap(10.pxw),
               Container(
                 width: 14.pxw,height: 14.pxh,
                 child: Image.asset(R.assetsImagesHomeVector,    fit: BoxFit.contain,),
               )
             ],
           ),
         ),

          SizedBox(width: 4.pxw),

          // 排行图标
          Container(
            decoration: BoxDecoration(
              color: Color(0x12FDFFFF),
              borderRadius: BorderRadius.circular(8.pxw),
            ),
            width: 35.pxw,
            height: 35.pxh,
            child: Center(
              child: Container(
                width: 14.pxw,height: 14.pxh,
                child: Image.asset('assets/images/home/Vector.png',fit: BoxFit.contain,),
              ),
            ),
          ),
        ],
      ),
    );
  }


} 