import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:roomcard/base/base_controller.dart';
import 'package:roomcard/utils/regex_util.dart';
import 'name_edit_state.dart';

class NameEditLogic extends BaseController<NameEditState> {
  @override
  NameEditState initState() {
    return NameEditState();
  }

  @override
  void onInit() {
    super.onInit();
    _initNickname();
    _setupListeners();
  }

  @override
  void onClose() {
    // 清理资源
    state.nicknameController.dispose();
    state.nicknameFocusNode.dispose();
    super.onClose();
  }

  /// 初始化昵称
  void _initNickname() {
    String currentName = Get.arguments?['nickname'] ?? '用户昵称';
    state.currentNickname.value = currentName;
    state.nicknameController.text = currentName;
    state.inputNickname.value = currentName;
    
    // 自动获取焦点并选中文本
    WidgetsBinding.instance.addPostFrameCallback((_) {
      state.nicknameFocusNode.requestFocus();
      state.nicknameController.selection = TextSelection(
        baseOffset: 0,
        extentOffset: state.nicknameController.text.length,
      );
    });
  }

  /// 设置监听器
  void _setupListeners() {
    // 监听输入变化
    state.nicknameController.addListener(() {
      String inputText = state.nicknameController.text;
      state.inputNickname.value = inputText;
      _checkCanSave();
    });
  }

  /// 检查是否可以保存
  void _checkCanSave() {
    String inputText = state.inputNickname.value.trim();
    bool hasChanged = inputText != state.currentNickname.value;
    bool isValid = _validateNickname(inputText);
    state.canSave.value = hasChanged && isValid && !state.isSaving.value;
  }

  /// 验证昵称
  bool _validateNickname(String nickname) {
    if (nickname.isEmpty) {
      return false;
    }
    
    // 长度限制：1-15个字符
    if (nickname.length > 15) {
      return false;
    }
    
    // 不能包含特殊字符（可根据需要调整）
    RegExp specialChars = RegExp(r'[<>{}[\]\\|`^~]');
    if (specialChars.hasMatch(nickname)) {
      return false;
    }
    
    return true;
  }

  /// 保存昵称
  Future<void> saveNickname() async {
    if (!state.canSave.value) return;
    
    String newNickname = state.inputNickname.value.trim();
    
    try {
      state.isSaving.value = true;
      state.canSave.value = false;
      
      await _saveNicknameToServer(newNickname);
      
      // 保存成功
      Get.back(result: {
        'success': true,
        'nickname': newNickname,
      });
      
      Get.snackbar(
        '提示',
        '昵称修改成功',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
      );
      
    } catch (e) {
      // 保存失败
      Get.snackbar(
        '错误',
        '昵称修改失败：${e.toString()}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    } finally {
      state.isSaving.value = false;
      _checkCanSave();
    }
  }

  /// 保存昵称到服务器
  Future<void> _saveNicknameToServer(String nickname) async {
    // 模拟网络请求
    await Future.delayed(const Duration(seconds: 1));
    
    // 模拟可能的错误
    // if (nickname.contains('test')) {
    //   throw Exception('昵称不能包含敏感词');
    // }
  }

  /// 返回上一页
  void goBack() {
    Get.back();
  }

  /// 清空输入
  void clearInput() {
    state.nicknameController.clear();
    state.inputNickname.value = '';
  }

  /// 获取昵称长度提示文本
  String getLengthHint() {
    int currentLength = state.inputNickname.value.length;
    return '$currentLength/15';
  }

  /// 获取错误提示文本
  String? getErrorHint() {
    String nickname = state.inputNickname.value.trim();
    
    if (nickname.isEmpty) {
      return null;
    }
    
    if (nickname.length > 15) {
      return '昵称不能超过15个字符';
    }
    
    RegExp specialChars = RegExp(r'[<>{}[\]\\|`^~]');
    if (specialChars.hasMatch(nickname)) {
      return '昵称不能包含特殊字符';
    }
    
    return null;
  }
}