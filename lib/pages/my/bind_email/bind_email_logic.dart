import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roomcard/base/base_controller.dart';
import 'bind_email_state.dart';

class BindEmailLogic extends BaseController<BindEmailState> {
  Timer? _countdownTimer;

  @override
  BindEmailState initState() {
    return BindEmailState();
  }

  @override
  void onInit() {
    super.onInit();
    // 监听邮箱输入
    state.emailController.addListener(() {
      state.emailAddress.value = state.emailController.text;
      _updateCanSendCode();
      _updateCanConfirm();
    });

    // 监听验证码输入
    state.verifyCodeController.addListener(() {
      state.verifyCode.value = state.verifyCodeController.text;
      _updateCanConfirm();
    });
  }

  /// 返回按钮点击
  void onBackPressed() {
    Get.back();
  }

  /// 更新是否可以发送验证码
  void _updateCanSendCode() {
    // 简单的邮箱格式验证
    bool isValidEmail = state.emailAddress.value.contains('@') && 
                       state.emailAddress.value.contains('.') &&
                       state.emailAddress.value.length > 5;
    state.canSendCode.value = isValidEmail && state.countdown.value == 0;
  }

  /// 更新是否可以确定绑定
  void _updateCanConfirm() {
    bool isValidEmail = state.emailAddress.value.contains('@') && 
                       state.emailAddress.value.contains('.') &&
                       state.emailAddress.value.length > 5;
    state.canConfirm.value = isValidEmail && state.verifyCode.value.length >= 4;
  }

  /// 发送验证码
  void sendVerifyCode() {
    if (!state.canSendCode.value) return;

    print('发送验证码到邮箱: ${state.emailAddress.value}');

    // 开始倒计时
    state.countdown.value = 60;
    state.canSendCode.value = false;

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.countdown.value > 0) {
        state.countdown.value--;
      } else {
        timer.cancel();
        _updateCanSendCode();
      }
    });

    // TODO: 调用发送验证码API
    Get.snackbar('提示', '验证码已发送到您的邮箱');
  }

  /// 确定绑定
  void confirmBind() {
    if (!state.canConfirm.value) return;

    print('绑定邮箱: ${state.emailAddress.value}');
    print('验证码: ${state.verifyCode.value}');

    // TODO: 调用绑定邮箱API
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF283D49),
        title: const Text('绑定成功', style: TextStyle(color: Colors.white)),
        content: Text(
          '邮箱 ${state.emailAddress.value} 绑定成功',
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // 关闭对话框
              Get.back(); // 返回上一页
            },
            child: const Text('确定', style: TextStyle(color: Color(0xFFF9C678))),
          ),
        ],
      ),
    );
  }

  @override
  void onClose() {
    _countdownTimer?.cancel();
    state.emailController.dispose();
    state.verifyCodeController.dispose();
    super.onClose();
  }
}