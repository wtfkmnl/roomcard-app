import 'package:roomcard/base/base_controller.dart';
import 'package:roomcard/base/base_state.dart';

class MyState extends BaseState {
  // 简单的状态类
}

class MyLogic extends BaseController<MyState> {
  @override
  MyState initState() {
    return MyState();
  }
}
