import 'package:get/get.dart';
import 'my_logic.dart';

class MyBinding extends Bindings {
  @override
  void dependencies() {
    /// 注册MyLogic控制器
    Get.lazyPut(() => MyLogic());
  }
}
