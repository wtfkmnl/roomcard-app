import 'package:get/get.dart';
import 'setting_logic.dart';

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    /// 注册SettingLogic控制器
    Get.lazyPut(() => SettingLogic());
  }
}