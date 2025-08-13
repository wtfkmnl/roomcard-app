import 'package:get/get.dart';
import 'bind_phone_logic.dart';

class BindPhoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BindPhoneLogic>(() => BindPhoneLogic());
  }
}