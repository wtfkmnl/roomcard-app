import 'package:get/get.dart';
import 'package:roomcard/base/base_controller.dart';
import 'package:roomcard/routes/app_router.dart';
import 'safe_manager_state.dart';

class SafeManagerLogic extends BaseController<SafeManagerState> {
  @override
  SafeManagerState initState() {
    return SafeManagerState();
  }

  @override
  void onInit() {
    super.onInit();
    _loadSecuritySettings();
  }

  /// 加载安全设置
  void _loadSecuritySettings() {
    // TODO: 从服务器或本地存储加载安全设置
    // 这里使用模拟数据
    state.passwordProtection.value = false;
    state.phoneBinding.value = '去绑定';
    state.emailBinding.value = '去绑定';
    state.loginSecurityVerification.value = true;
  }

  /// 安全密码保护开关切换
  void onPasswordProtectionToggle(bool value) {
    state.passwordProtection.value = value;
    print('安全密码保护: $value');
    // TODO: 保存设置到服务器
  }

  /// 绑定手机点击
  void onPhoneBindingTap() {
    print('绑定手机');
    Get.toNamed(AppRouter.mineBindPhone.path);
  }

  /// 绑定邮箱点击
  void onEmailBindingTap() {
    print('绑定邮箱');
    // TODO: 实现邮箱绑定功能
    _showEmailBindingDialog();
  }

  /// 登录安全验证开关切换
  void onLoginSecurityVerificationToggle(bool value) {
    state.loginSecurityVerification.value = value;
    print('登录安全验证: $value');
    // TODO: 保存设置到服务器
  }

  /// 修改密码点击
  void onChangePasswordTap() {
    print('修改密码');
    // TODO: 实现修改密码功能
    _showChangePasswordDialog();
  }

  /// 安全验证说明图标点击
  void onSecurityTipTap() {
    state.showSecurityTipDialog.value = true;
  }

  /// 隐藏安全验证说明弹窗
  void hideSecurityTipDialog() {
    state.showSecurityTipDialog.value = false;
  }

  /// 显示邮箱绑定对话框
  void _showEmailBindingDialog() {
    // TODO: 实现邮箱绑定对话框
    Get.snackbar('提示', '邮箱绑定功能开发中...');
  }

  /// 显示修改密码对话框
  void _showChangePasswordDialog() {
    // TODO: 实现修改密码对话框
    Get.snackbar('提示', '修改密码功能开发中...');
  }
}
