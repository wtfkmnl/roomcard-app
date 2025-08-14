import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roomcard/utils/num_px.dart';
import 'package:roomcard/theme/app_theme.dart';
import '../home_logic.dart';

/// 我的牌局区域组件
class MyGamesSection extends StatelessWidget {
  final HomeLogic logic;

  const MyGamesSection({
    super.key,
    required this.logic,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.pxw, vertical: 14.pxh),
      height: 48.pxh,
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/home/title_bar_bg.png'),
            fit: BoxFit.fill,
          ),
        borderRadius: BorderRadius.circular(8.pxw),
      ),
      child: Row(
        children: [
          Text(
            '我的牌局',
            style: TextStyle(
              color: AppTheme().current.textColor1,
              fontSize: 18.pxSp,
              fontWeight: FontWeight.w600,
            ),
          ),

          const Spacer(),

          // 空位复选框
          Obx(() => Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => logic.toggleEmptySlotsOnly(!logic.state.showEmptySlotsOnly.value),
                child: Container(
                  width: 20.pxw,
                  height: 20.pxh,
                  child: Image.asset(
                    logic.state.showEmptySlotsOnly.value
                        ? 'assets/images/home/choose.png'
                        : 'assets/images/home/Border.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(width: 6.pxw),
              Text(
                '空位',
                style: TextStyle(
                  color: AppTheme().current.textColor4,
                  fontSize: 12.pxSp,
                  fontWeight: FontWeight.w600
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
} 