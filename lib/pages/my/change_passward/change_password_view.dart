import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:roomcard/routes/app_router.dart';
import '../../../theme/app_theme.dart';
import 'change_password_logic.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<ChangePasswordLogic>();
    final state = logic.state;

    return Scaffold(
      backgroundColor: const Color(0xFF1A252F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF283D49),
        elevation: 0,
        leading: TextButton(
          child: Text(
            '取消',
            style: TextStyle(
              color: Color(0xFFB3BEC1),
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () => AppRouter.back(),
        ),
        title: Text(
          '设置密码',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w, top: 8.h, bottom: 8.h),
            child: Obx(
              () => Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF9C678),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8.r),
                  onTap: state.canSave.value && !state.isSaving.value
                      ? logic.savePassword
                      : null,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 2.5.h,
                    ),
                    child: Text(
                      '完成',
                      style: TextStyle(
                        color: const Color(0xFF703E00),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            // 账号
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFF2A3441),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: const Color(0xFF37505E), width: 1),
              ),
              child: Column(
                children: [
                  // 账号
                  Row(
                    children: [
                      SizedBox(
                        width: 70.w,
                        child: Text(
                          '账号',
                          style: TextStyle(
                            color: const Color(0xFFB3BEC1),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        'sjhsjrfjewjfkk',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  16.verticalSpace,
                  Divider(color: Color(0xFF37505E), height: 1),
                  // 旧密码输入
                  _buildPasswordField(
                    label: '旧密码',
                    placeholder: '请输入旧密码',
                    controller: state.oldPasswordController,
                    focusNode: state.oldPasswordFocusNode,
                  ),
                  Divider(color: Color(0xFF37505E), height: 1),

                  // 新密码输入
                  _buildPasswordField(
                    label: '新密码',
                    placeholder: '请输入新的密码',
                    controller: state.newPasswordController,
                    focusNode: state.newPasswordFocusNode,
                  ),
                  Divider(color: Color(0xFF37505E), height: 1),

                  // 确认密码输入
                  _buildPasswordField(
                    label: '确认密码',
                    placeholder: '请再次输入新的密码',
                    controller: state.confirmPasswordController,
                    focusNode: state.confirmPasswordFocusNode,
                  ),
                  Divider(color: Color(0xFF37505E), height: 1),
                  4.verticalSpace,
                  // 密码提示
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      logic.getPasswordLengthHint(),
                      style: TextStyle(
                        color: const Color(0x5EB3BEC1),
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                  8.verticalSpace,
                  // 忘记旧密码
                  SizedBox(
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: logic.onForgotPassword,
                      child: Text(
                        '忘记旧密码?',
                        style: TextStyle(
                          color: const Color(0xFFB3BEC1),
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 加载指示器
            Obx(
              () => state.isSaving.value
                  ? Container(
                      margin: EdgeInsets.only(top: 20.h),
                      child: const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color(0xFFFFB800),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  /// 密码输入框
  Widget _buildPasswordField({
    required String label,
    required String placeholder,
    required TextEditingController controller,
    required FocusNode focusNode,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 70.w,
          child: Text(
            label,
            style: TextStyle(
              color: const Color(0xFFB3BEC1),
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            style: TextStyle(color: Colors.white, fontSize: 14.sp),
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: TextStyle(
                color: const Color(0xFFB3BEC1),
                fontSize: 14.sp,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
