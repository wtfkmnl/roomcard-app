import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../r.dart';
import 'my_logic.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(MyLogic());
    final state = logic.state;

    return Scaffold(
      backgroundColor: const Color(0xFF1C2C36),
      appBar: AppBar(
        title: const Text(
          '我的',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Image.asset(R.assetsIconArrowBack),
          onPressed: () => Get.back(),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // 背景图层
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 450.h,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(R.assetsIconMineTopBg),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.only(
              top: kToolbarHeight + MediaQuery.of(context).padding.top + 20.h,
              bottom: 100.h,
            ),
            child: Column(
              children: [
                // 用户信息卡片
                _buildUserInfoCard(logic, state),
                const SizedBox(height: 20),
                // 功能菜单列表
                _buildMenuList(logic),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 构建用户信息卡片
  Widget _buildUserInfoCard(MyLogic logic, state) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // 头像
          Container(
            width: 62.w,
            height: 62.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(31.w),
              color: Color(0xFF3A4142),
              border: Border.all(color: Color(0xFF3B4041), width: 1),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: 54.w,
                height: 54.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(27.w),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF6B6B), Color(0xFFFFE66D)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Icon(Icons.person, color: Colors.white, size: 33),
              ),
            ),
          ),
          8.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Text(
                  state.userName.value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              4.verticalSpace,
              Obx(
                () => Text(
                  state.userId.value,
                  style: const TextStyle(
                    color: Color(0xffB3BEC1),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              4.verticalSpace,
              // 余额信息
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    R.assetsIconMineWallet,
                    width: 19.w,
                    height: 23.h,
                  ),
                  4.horizontalSpace,
                  Obx(
                    () => Text(
                      state.userBalance.value,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Image.asset(R.assetsIconArrowNext, width: 28.w, height: 28.h),
              // 操作按钮
              14.verticalSpace,
              Row(
                children: [
                  GestureDetector(
                    onTap: logic.onWithdrawTap,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFABB9C2), Color(0xFF839197)],
                          // 从左到右的蓝紫渐变
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF5B6C72).withOpacity(0.3),
                            offset: const Offset(0, 2), // 底部2像素阴影
                            blurRadius: 4,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Text(
                        '提现',
                        style: const TextStyle(
                          color: Color(0xFF535B5F),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  10.horizontalSpace,
                  GestureDetector(
                    onTap: logic.onRechargeTap,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFBF9048), Color(0xFFF9C678)],
                          // 从左到右的蓝紫渐变
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFFBD8742).withOpacity(0.3),
                            offset: const Offset(0, 2), // 底部2像素阴影
                            blurRadius: 4,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Text(
                        '充值',
                        style: const TextStyle(
                          color: Color(0xFF535B5F),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 构建功能菜单列表
  Widget _buildMenuList(MyLogic logic) {
    final menuItems = [
      {
        'icon': R.assetsIconMineMenuTransform,
        'title': '好友转账',
        'color': const Color(0xFF4ECDC4),
        'onTap': logic.onFriendTransferTap,
      },
      {
        'icon': R.assetsIconMineMenuFinancial,
        'title': '资金明细',
        'color': const Color(0xFF45B7D1),
        'onTap': logic.onFundDetailTap,
      },
      {
        'icon': R.assetsIconMineMenuRecord,
        'title': '战绩',
        'color': const Color(0xFF96CEB4),
        'onTap': logic.onGameRecordTap,
      },
      {
        'icon': R.assetsIconMineMenuChess,
        'title': '牌谱',
        'color': const Color(0xFFFECEA8),
        'onTap': logic.onCardRecordTap,
      },
      {
        'icon': R.assetsIconMineMenuNews,
        'title': '消息公告',
        'color': const Color(0xFFFF6B9D),
        'onTap': logic.onMessageTap,
      },
      {
        'icon': R.assetsIconMineMenuBusiness,
        'title': '商务合作',
        'color': const Color(0xFFC44569),
        'onTap': logic.onBusinessTap,
      },
      {
        'icon': R.assetsIconMineMenuSetting,
        'title': '设置',
        'color': const Color(0xFF778CA3),
        'onTap': logic.onSettingsTap,
      },
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: menuItems
            .map(
              (item) => _buildMenuItem(
                icon: item['icon'] as String,
                title: item['title'] as String,
                color: item['color'] as Color,
                onTap: item['onTap'] as VoidCallback,
                isLast: item == menuItems.last,
              ),
            )
            .toList(),
      ),
    );
  }

  /// 构建菜单项
  Widget _buildMenuItem({
    required String icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
    bool isLast = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          color: const Color(0xFF283D49),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xFF37505E), width: 1),
        ),
        child: Row(
          children: [
            SizedBox(width: 40, height: 40, child: Image.asset(icon)),
            14.horizontalSpace,
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Image.asset(R.assetsIconArrowNext, width: 20.w),
          ],
        ),
      ),
    );
  }
}
