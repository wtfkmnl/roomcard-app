import 'package:get/get.dart';
import 'package:roomcard/base/base_controller.dart';
import 'package:roomcard/routes/app_router.dart';
import 'change_password_state.dart';

class ChangePasswordLogic extends BaseController<ChangePasswordState> {
  @override
  ChangePasswordState initState() {
    return ChangePasswordState();
  }

  @override
  void onInit() {
    super.onInit();
    _setupListeners();
  }

  /// 设置监听器
  void _setupListeners() {
    // 监听旧密码输入
    state.oldPasswordController.addListener(() {
      state.oldPassword.value = state.oldPasswordController.text;
      _validatePasswords();
    });

    // 监听新密码输入
    state.newPasswordController.addListener(() {
      state.newPassword.value = state.newPasswordController.text;
      _validatePasswords();
    });

    // 监听确认密码输入
    state.confirmPasswordController.addListener(() {
      state.confirmPassword.value = state.confirmPasswordController.text;
      _validatePasswords();
    });
  }

  /// 验证密码
  void _validatePasswords() {
    final oldPwd = state.oldPassword.value.trim();
    final newPwd = state.newPassword.value.trim();
    final confirmPwd = state.confirmPassword.value.trim();

    // 检查所有字段是否填写
    if (oldPwd.isEmpty || newPwd.isEmpty || confirmPwd.isEmpty) {
      state.canSave.value = false;
      return;
    }

    // 检查新密码长度（8-16位）
    if (newPwd.length < 8 || newPwd.length > 16) {
      state.canSave.value = false;
      return;
    }

    // 检查新密码格式（英文字母、数字、字符组合）
    if (!_isValidPassword(newPwd)) {
      state.canSave.value = false;
      return;
    }

    // 检查两次新密码是否一致
    if (newPwd != confirmPwd) {
      state.canSave.value = false;
      return;
    }

    state.canSave.value = true;
  }

  /// 验证密码格式
  bool _isValidPassword(String password) {
    // 密码必须包含英文字母、数字、字符组合
    final hasLetter = RegExp(r'[a-zA-Z]').hasMatch(password);
    final hasDigit = RegExp(r'[0-9]').hasMatch(password);
    final hasSpecialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);
    
    return hasLetter && hasDigit && hasSpecialChar;
  }

  /// 获取密码长度提示
  String getPasswordLengthHint() {
    return '密码必须是8-16位英文字母、数字、字符组合（不能是纯数字）';
  }

  /// 获取确认密码错误提示
  String? getConfirmPasswordError() {
    if (state.confirmPassword.value.isEmpty) return null;
    if (state.newPassword.value != state.confirmPassword.value) {
      return '两次输入的密码不一致';
    }
    return null;
  }

  /// 保存密码
  Future<void> savePassword() async {
    if (!state.canSave.value || state.isSaving.value) return;

    state.isSaving.value = true;

    try {
      // TODO: 调用API修改密码
      await Future.delayed(const Duration(seconds: 2)); // 模拟网络请求
      
      // 模拟成功
      Get.snackbar(
        '成功',
        '密码修改成功',
        snackPosition: SnackPosition.TOP,
      );
      
      // 返回上一页
      AppRouter.back();
    } catch (e) {
      Get.snackbar(
        '错误',
        '密码修改失败，请重试',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      state.isSaving.value = false;
    }
  }

  /// 忘记旧密码
  void onForgotPassword() {
    Get.snackbar(
      '提示',
      '请联系客服重置密码',
      snackPosition: SnackPosition.TOP,
    );
  }

  /// 清空输入
  void clearInput() {
    state.oldPasswordController.clear();
    state.newPasswordController.clear();
    state.confirmPasswordController.clear();
  }
}