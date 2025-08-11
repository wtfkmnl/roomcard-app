import 'package:get/get.dart';
import 'package:roomcard/base/base_controller.dart';
import '../../../routes/app_router.dart';
import 'setting_state.dart';

class SettingLogic extends BaseController<SettingState> {
  @override
  SettingState initState() {
    return SettingState();
  }

  /// 切换账号点击
  void onSwitchAccountTap() {
    print('切换账号');
  }

  /// 多语言点击
  void onLanguageTap() {
    print('多语言设置');
    _showLanguageDialog();
  }

  /// 安全管理点击
  void onSecurityTap() {
    print('安全管理');
    AppRouter.mineSafeManager.toPage();
  }

  /// 游戏音效开关切换
  void onGameSoundToggle(bool value) {
    state.gameSound.value = value;
    print('游戏音效: $value');
  }

  /// 消息声音开关切换
  void onMessageSoundToggle(bool value) {
    state.messageSound.value = value;
    print('消息声音: $value');
  }

  /// 消息震动开关切换
  void onMessageVibrationToggle(bool value) {
    state.messageVibration.value = value;
    print('消息震动: $value');
  }

  /// 关于我们点击
  void onAboutUsTap() {
    print('关于我们');
    Get.toNamed(AppRouter.mineAbout.path);
  }

  /// 版本号点击
  void onVersionTap() {
    print('版本号: ${state.version.value}');
  }

  /// 显示多语言选择对话框
  void _showLanguageDialog() {
  }
}