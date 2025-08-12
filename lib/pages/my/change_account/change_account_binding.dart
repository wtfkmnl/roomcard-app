import 'package:get/get.dart';
import 'change_account_logic.dart';

class ChangeAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangeAccountLogic>(() => ChangeAccountLogic());
  }
}