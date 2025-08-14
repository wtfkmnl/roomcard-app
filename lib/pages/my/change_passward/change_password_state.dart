import 'package:flutter/material.dart';
import 'package:roomcard/base/base_state.dart';
import 'package:get/get.dart';

class ChangePasswordState extends BaseState with StateAutoManager {
  /// 旧密码输入控制器
  late TextEditingController oldPasswordController;
  
  /// 新密码输入控制器
  late TextEditingController newPasswordController;
  
  /// 确认密码输入控制器
  late TextEditingController confirmPasswordController;
  
  /// 旧密码焦点
  late FocusNode oldPasswordFocusNode;
  
  /// 新密码焦点
  late FocusNode newPasswordFocusNode;
  
  /// 确认密码焦点
  late FocusNode confirmPasswordFocusNode;
  
  /// 旧密码输入内容
  final oldPassword = ''.obs;
  
  /// 新密码输入内容
  final newPassword = ''.obs;
  
  /// 确认密码输入内容
  final confirmPassword = ''.obs;
  
  /// 是否可以保存
  final canSave = false.obs;
  
  /// 是否正在保存
  final isSaving = false.obs;
  

  ChangePasswordState() {
    oldPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    oldPasswordFocusNode = FocusNode();
    newPasswordFocusNode = FocusNode();
    confirmPasswordFocusNode = FocusNode();
  }

  @override
  void onClose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    oldPasswordFocusNode.dispose();
    newPasswordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    super.onClose();
  }
}