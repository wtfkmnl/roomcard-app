import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    ///这个生命周期由main来管理
    // Get.lazyPut(() => HomeLogic());
  }
}
