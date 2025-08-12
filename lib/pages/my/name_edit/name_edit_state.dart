import 'package:roomcard/base/base_state.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class NameEditState extends BaseState with StateAutoManager {
  /// 昵称输入控制器
  final TextEditingController nicknameController = TextEditingController();
  
  /// 当前昵称
  final currentNickname = ''.obs;
  
  /// 输入的昵称
  final inputNickname = ''.obs;
  
  /// 是否可以保存（昵称有变化且符合规则）
  final canSave = false.obs;
  
  /// 是否正在保存
  final isSaving = false.obs;
  
  /// 昵称输入焦点
  final FocusNode nicknameFocusNode = FocusNode();

  NameEditState() {
    /// Initialize variables
  }
}