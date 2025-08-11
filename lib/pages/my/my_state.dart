import 'package:roomcard/base/base_state.dart';
import 'package:get/get.dart';

class MyState  extends BaseState with StateAutoManager {

  ///登录成功状态监听
  final logined = false.obs;

  MyState() {
    /// Initialize variables
  }
}
