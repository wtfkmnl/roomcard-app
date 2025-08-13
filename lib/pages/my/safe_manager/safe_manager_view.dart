import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../r.dart';
import '../../../widgets/custom_switch.dart';
import 'safe_manager_logic.dart';

class SafeManagerPage extends StatelessWidget {
  SafeManagerPage({super.key});

  final GlobalKey _tipIconKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<SafeManagerLogic>();
    final state = logic.state;

    return Scaffold(
      backgroundColor: const Color(0xFF1A2332),
      appBar: AppBar(
        title: Text(
          '安全管理',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Color(0xFF283D49),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Image.asset(R.assetsImagesIconTitleBack),
          onPressed: () => Get.back(),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // 安全密码保护
              Obx(
                () => _buildSwitchItem(
                  title: '安全密码保护',
                  value: state.passwordProtection.value,
                  onChanged: logic.onPasswordProtectionToggle,
                ),
              ),

              16.verticalSpace,

              // 绑定手机
              Obx(
                () => _buildMenuItem(
                  title: '绑定手机',
                  value: state.phoneBinding.value,
                  onTap: logic.onPhoneBindingTap,
                  showArrow: true,
                ),
              ),

              16.verticalSpace,

              // 绑定邮箱
              Obx(
                () => _buildMenuItem(
                  title: '绑定邮箱',
                  value: state.emailBinding.value,
                  onTap: logic.onEmailBindingTap,
                  showArrow: true,
                ),
              ),

              16.verticalSpace,

              // 登录安全验证
              Obx(
                () => _buildSwitchItemWithIndicator(
                  title: '登录安全验证',
                  value: state.loginSecurityVerification.value,
                  onChanged: logic.onLoginSecurityVerificationToggle,
                  onTipTap: logic.onSecurityTipTap,
                  tipIconKey: _tipIconKey,
                ),
              ),

              16.verticalSpace,

              // 修改密码
              _buildMenuItem(
                title: '修改密码',
                onTap: logic.onChangePasswordTap,
                showArrow: true,
              ),
            ],
          ),

          // 安全验证说明弹窗
          Obx(
            () =>
                state.showSecurityTipDialog.value
                    ? _buildSecurityTipDialog(logic, _tipIconKey)
                    : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  /// 构建开关项
  Widget _buildSwitchItem({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2A3441),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFF37505E), width: 1),
      ),
      child: ListTile(
        horizontalTitleGap: 12.w,
        title: Text(
          title,
          style: TextStyle(
            color: Color(0xFFB3BEC1),
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: CustomSwitch(value: value, onChanged: onChanged),
      ),
    );
  }

  /// 带指示器的开关项
  Widget _buildSwitchItemWithIndicator({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
    required VoidCallback onTipTap,
    required GlobalKey tipIconKey,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2A3441),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFF37505E), width: 1),
      ),
      child: ListTile(
        horizontalTitleGap: 12.w,
        title: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                color: Color(0xFFB3BEC1),
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            8.horizontalSpace,
            GestureDetector(
              key: tipIconKey, // 设置GlobalKey
              onTap: onTipTap,
              child: Image.asset(R.assetsImagesIconSafeValidate),
            ),
          ],
        ),
        trailing: CustomSwitch(value: value, onChanged: onChanged),
      ),
    );
  }

  /// 菜单项
  Widget _buildMenuItem({
    required String title,
    String? value,
    required VoidCallback onTap,
    bool showArrow = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2A3441),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFF37505E), width: 1),
      ),
      child: ListTile(
        horizontalTitleGap: 12.w,
        title: Text(
          title,
          style: TextStyle(
            color: Color(0xFFB3BEC1),
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (value != null) ...[
              Text(
                value,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (showArrow) const SizedBox(width: 8),
            ],
            if (showArrow)
              Image.asset(R.assetsImagesIconArrowNext, width: 20.w),
          ],
        ),
        onTap: onTap,
      ),
    );
  }

  /// 安全验证说明弹窗
  Widget _buildSecurityTipDialog(SafeManagerLogic logic, GlobalKey tipIconKey) {
    return GestureDetector(
      onTap: logic.hideSecurityTipDialog,
      child: Container(
        color: Colors.transparent,
        width: double.infinity,
        height: double.infinity,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final RenderBox? renderBox =
                tipIconKey.currentContext?.findRenderObject() as RenderBox?;
            if (renderBox == null) {
              return const SizedBox.shrink();
            }

            final RenderBox? stackRenderBox =
                context.findRenderObject() as RenderBox?;
            if (stackRenderBox == null) {
              return const SizedBox.shrink();
            }

            final Offset iconGlobalPosition = renderBox.localToGlobal(
              Offset.zero,
            );
            final Offset iconLocalPosition = stackRenderBox.globalToLocal(
              iconGlobalPosition,
            );
            final Size iconSize = renderBox.size;

            // 计算弹窗位置
            final double dialogTop =
                iconLocalPosition.dy + iconSize.height + 2.h;
            final double triangleLeft =
                iconLocalPosition.dx + (iconSize.width / 2) - 6.w - 16.w;

            return Stack(
              children: [
                Positioned(
                  left: 16.w,
                  right: 16.w,
                  top: dialogTop,
                  child: GestureDetector(
                    onTap: () {},
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 三角形指示器
                        Padding(
                          padding: EdgeInsets.only(
                            left: triangleLeft.clamp(0.0, double.infinity),
                          ),
                          child: CustomPaint(
                            size: Size(12.w, 8.h),
                            painter: TrianglePainter(),
                          ),
                        ),
                        // 弹窗内容
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 8.h,
                            horizontal: 12.w,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            '开启都能录安全验证码后，换设备登陆或长期未登录，在登录时绑定手机或邮箱，以用于接收安全验证码。',
                            style: TextStyle(
                              color: Color(0xFF2F4553),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width / 2, 0); // 顶点
    path.lineTo(0, size.height); // 左下角
    path.lineTo(size.width, size.height); // 右下角
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
