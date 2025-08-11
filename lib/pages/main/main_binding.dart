import 'package:roomcard/pages/home/home_logic.dart';
import 'package:roomcard/pages/my/my_logic.dart';
import 'package:get/get.dart';
import 'main_logic.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainLogic());

    ///首页的五个tabbar
    Get.lazyPut(() => HomeLogic());
    Get.lazyPut(() => MyLogic());

    ///end
  }
}
