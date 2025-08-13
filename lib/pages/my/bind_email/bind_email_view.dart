import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../r.dart';
import '../../../widgets/buttons/gradient_button.dart';
import 'bind_email_logic.dart';
import 'bind_email_state.dart';

class BindEmailPage extends StatelessWidget {
  const BindEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<BindEmailLogic>();
    final state = logic.state;

    return Scaffold(
      backgroundColor: const Color(0xFF1C2C36),
      appBar: AppBar(
        backgroundColor: const Color(0xFF283D49),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Image.asset(R.assetsImagesIconTitleBack),
          onPressed: logic.onBackPressed,
        ),
        title: Text(
          '绑定邮箱',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            // 邮箱输入框
            _buildEmailInput(logic, state),

            16.verticalSpace,

            // 验证码输入框
            _buildVerifyCodeInput(logic, state),

            40.verticalSpace,

            // 确定绑定按钮
            Obx(
              () => GradientButton(
                text: '确定绑定',
                onTap: state.canConfirm.value ? logic.confirmBind : null,
                margin: EdgeInsets.only(bottom: 0.h),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 邮箱输入框
  Widget _buildEmailInput(BindEmailLogic logic, BindEmailState state) {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: const Color(0xFF283D49),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF37505E), width: 1),
      ),
      child: Row(
        children: [
          16.horizontalSpace,
          // 邮箱图标
          Image.asset(R.assetsImagesIconPhoneBindEmail),

          // 邮箱输入
          Expanded(
            child: TextField(
              controller: state.emailController,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: '请输入绑定邮箱',
                hintStyle: TextStyle(
                  color: Color(0xFF57646D),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 4.w,
                  vertical: 16.h,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 验证码输入框
  Widget _buildVerifyCodeInput(BindEmailLogic logic, BindEmailState state) {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: const Color(0xFF283D49),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF37505E), width: 1),
      ),
      child: Row(
        children: [
          16.horizontalSpace,
          // 验证码图标
          Image.asset(R.assetsImagesIconPhoneBindCode),

          // 验证码输入
          Expanded(
            child: TextField(
              controller: state.verifyCodeController,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: '请输入验证码',
                hintStyle: TextStyle(
                  color: Color(0xFF57646D),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 4.w,
                  vertical: 16.h,
                ),
              ),
            ),
          ),

          // 获取验证码按钮
          Obx(
            () => GestureDetector(
              onTap: state.canSendCode.value ? logic.sendVerifyCode : null,
              child: Container(
                margin: EdgeInsets.only(right: 16.w),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  gradient:
                      state.canSendCode.value
                          ? const LinearGradient(
                            colors: [Color(0xFFBF9048), Color(0xFFF9C678)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          )
                          : null,
                  color:
                      state.canSendCode.value ? null : const Color(0xFF37505E),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  state.countdown.value > 0
                      ? '${state.countdown.value}s'
                      : '获取验证码',
                  style: TextStyle(
                    color:
                        state.canSendCode.value
                            ? const Color(0xFF703E00)
                            : Colors.white54,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
