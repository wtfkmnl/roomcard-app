import 'package:flutter/cupertino.dart';
import 'package:roomcard/base/base_state.dart';
import 'package:get/get.dart';

class BindEmailState extends BaseState with StateAutoManager {
  /// 邮箱输入控制器
  final emailController = TextEditingController();
  
  /// 验证码输入控制器
  final verifyCodeController = TextEditingController();
  
  /// 邮箱地址
  final emailAddress = ''.obs;
  
  /// 验证码
  final verifyCode = ''.obs;
  
  /// 是否可以发送验证码
  final canSendCode = false.obs;
  
  /// 验证码倒计时
  final countdown = 0.obs;
  
  /// 是否可以确定绑定
  final canConfirm = false.obs;
}