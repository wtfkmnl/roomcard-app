import 'package:roomcard/base/base_controller.dart';
import 'package:roomcard/base/base_state.dart';

class HomeState extends BaseState {
  // 简单的状态类
}

class HomeLogic extends BaseController<HomeState> {
  @override
  HomeState initState() {
    return HomeState();
  }
}
