import 'package:get/get.dart';
import 'business_logic.dart';

class BusinessBinding extends Bindings {
  @override
  void dependencies() {
    /// 注册BusinessLogic控制器
    Get.lazyPut(() => BusinessLogic());
  }
}