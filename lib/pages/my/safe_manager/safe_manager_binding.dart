import 'package:get/get.dart';
import 'safe_manager_logic.dart';

class SafeManagerBinding extends Bindings {
  @override
  void dependencies() {
    /// 注册SafeManagerLogic控制器
    Get.lazyPut(() => SafeManagerLogic());
  }
}