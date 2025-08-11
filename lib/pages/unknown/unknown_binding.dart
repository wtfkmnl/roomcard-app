import 'package:get/get.dart';
import 'unknown_logic.dart';

class UnknownBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UnknownLogic());
  }
}
