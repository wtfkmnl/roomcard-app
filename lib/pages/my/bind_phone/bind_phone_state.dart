import 'package:flutter/cupertino.dart';
import 'package:roomcard/base/base_state.dart';
import 'package:get/get.dart';

class BindPhoneState extends BaseState with StateAutoManager {
  /// 选中的国家代码
  final selectedCountryCode = '+86'.obs;
  
  /// 手机号输入控制器
  final phoneController = TextEditingController();
  
  /// 验证码输入控制器
  final verifyCodeController = TextEditingController();
  
  /// 手机号
  final phoneNumber = ''.obs;
  
  /// 验证码
  final verifyCode = ''.obs;
  
  /// 是否可以发送验证码
  final canSendCode = false.obs;
  
  /// 验证码倒计时
  final countdown = 0.obs;
  
  /// 是否可以确定绑定
  final canConfirm = false.obs;
  
  /// 国家代码列表
  final countryCodes = <String>['+86', '+1', '+44', '+81', '+82', '+65', '+60', '+66', '+84', '+91'].obs;

}