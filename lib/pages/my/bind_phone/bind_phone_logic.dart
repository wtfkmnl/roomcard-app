import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roomcard/base/base_controller.dart';
import 'bind_phone_state.dart';

class BindPhoneLogic extends BaseController<BindPhoneState> {
  Timer? _countdownTimer;

  @override
  BindPhoneState initState() {
    return BindPhoneState();
  }

  @override
  void onInit() {
    super.onInit();
    // 监听手机号输入
    state.phoneController.addListener(() {
      state.phoneNumber.value = state.phoneController.text;
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
    state.canSendCode.value =
        state.phoneNumber.value.length >= 8 && state.countdown.value == 0;
  }

  /// 更新是否可以确定绑定
  void _updateCanConfirm() {
    state.canConfirm.value =
        state.phoneNumber.value.length >= 8 &&
        state.verifyCode.value.length >= 4;
  }

  /// 选择国家代码
  void selectCountryCode() {
    Get.bottomSheet(
      Container(
        height: 300,
        decoration: const BoxDecoration(
          color: Color(0xFF283D49),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: const Text(
                '选择国家/地区',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: state.countryCodes.length,
                itemBuilder: (context, index) {
                  final code = state.countryCodes[index];
                  return ListTile(
                    title: Text(
                      code,
                      style: const TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      state.selectedCountryCode.value = code;
                      Get.back();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 发送验证码
  void sendVerifyCode() {
    if (!state.canSendCode.value) return;

    print(
      '发送验证码到: ${state.selectedCountryCode.value} ${state.phoneNumber.value}',
    );

    // 开始倒计时
    state.countdown.value = 60;
    state.canSendCode.value = false;

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.countdown.value > 0) {
        state.countdown.value--;
      } else {
        timer.cancel();
        state.canSendCode.value = state.phoneNumber.value.length >= 8;
      }
    });

    // TODO: 调用发送验证码API
    Get.snackbar('提示', '验证码已发送');
  }

  /// 确定绑定
  void confirmBind() {
    if (!state.canConfirm.value) return;

    print(
      '绑定手机号: ${state.selectedCountryCode.value} ${state.phoneNumber.value}',
    );
    print('验证码: ${state.verifyCode.value}');

    // TODO: 调用绑定手机号API
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF283D49),
        title: const Text('绑定成功', style: TextStyle(color: Colors.white)),
        content: Text(
          '手机号 ${state.selectedCountryCode.value} ${state.phoneNumber.value} 绑定成功',
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
    state.phoneController.dispose();
    state.verifyCodeController.dispose();
    super.onClose();
  }
}
