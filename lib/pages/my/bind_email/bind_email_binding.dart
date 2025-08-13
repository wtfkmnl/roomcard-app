import 'package:get/get.dart';
import 'bind_email_logic.dart';

class BindEmailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BindEmailLogic>(() => BindEmailLogic());
  }
}