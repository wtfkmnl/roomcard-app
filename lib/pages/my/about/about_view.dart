import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../r.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A2332),
      appBar: AppBar(
        title: const Text(
          '关于我们',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Color(0xFF283D49),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Image.asset(R.assetsIconArrowBack),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Image.asset(R.assetsIconAboutUsLogo),
                  22.verticalSpace,
                  Text(
                    '公平竞技，畅玩社交',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            22.verticalSpace,
            Text(
              '我们致力于打造最公平、最好玩的德州扑克社交平台：',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            6.verticalSpace,
            _buildFeaturesList(),
            16.verticalSpace,
            _buildBottomDescription(),
          ],
        ),
      ),
    );
  }

  /// 构建特性列表
  Widget _buildFeaturesList() {
    final features = [
      '社交开黑：私密房间，自由约战，规则由你定',
      '俱乐部/联盟：创建专属社群，举办比赛，争夺荣誉',
      '区块链洗牌：每一局结果公开可查，杜绝作弊嫌疑',
      '牌局回放：每一手败仗都变成进阶教程',
      '实时数据：胜率/风格分析让你比对手更懂自己',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: features.map((feature) => _buildFeatureItem(feature)).toList(),
    );
  }

  /// 构建特性项
  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(R.assetsIconGreenSelect),
          6.horizontalSpace,
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: Color(0xFFB3BEC1), fontSize: 12.sp),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '在这里，信任由技术保障，乐趣由好有共创！',
          style: TextStyle(color: Colors.white, fontSize: 12.sp),
        ),

        8.verticalSpace,
        Text(
          '此致敬礼',
          style: TextStyle(color: Colors.white, fontSize: 12.sp),
        ),
        8.verticalSpace,
        Text(
          'KO Poker开发团队',
          style: TextStyle(color: Colors.white, fontSize: 12.sp),
        ),
      ],
    );
  }
}
