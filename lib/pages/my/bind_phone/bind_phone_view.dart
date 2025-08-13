import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../r.dart';
import '../../../widgets/buttons/gradient_button.dart';
import 'bind_phone_logic.dart';
import 'bind_phone_state.dart';

class BindPhonePage extends StatelessWidget {
  const BindPhonePage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<BindPhoneLogic>();
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
          '绑定手机',
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
            // 手机号输入框
            _buildPhoneInput(logic, state),

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

  /// 手机号输入框
  Widget _buildPhoneInput(BindPhoneLogic logic, BindPhoneState state) {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: const Color(0xFF283D49),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF37505E), width: 1),
      ),
      child: Row(
        children: [
          // 国家代码选择
          GestureDetector(
            onTap: logic.selectCountryCode,
            child: Container(
              padding: EdgeInsets.only(left: 16.w, right: 6.w),
              child: Row(
                children: [
                  Image.asset(R.assetsImagesIconPhoneBindPhone),
                  4.horizontalSpace,
                  Obx(
                    () => Text(
                      state.selectedCountryCode.value,
                      style: TextStyle(color: Colors.white, fontSize: 16.sp),
                    ),
                  ),
                  4.horizontalSpace,
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white54,
                    size: 20.w,
                  ),
                ],
              ),
            ),
          ),

          // 分隔线
          Container(width: 1, height: 24.h, color: const Color(0xFF37505E)),

          // 手机号输入
          Expanded(
            child: TextField(
              controller: state.phoneController,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: '请输入您的手机号码',
                hintStyle: TextStyle(
                  color: Color(0xFF57646D),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 6.w,
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
  Widget _buildVerifyCodeInput(BindPhoneLogic logic, BindPhoneState state) {
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
