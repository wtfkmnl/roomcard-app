import 'package:roomcard/base/base_controller.dart';
import 'package:roomcard/base/base_state.dart';

class RechargeState extends BaseState {
  // 俱乐部页面的状态管理
  // 可以在这里添加需要的状态变量
}

class RechargeLogic extends BaseController<RechargeState> {
  @override
  RechargeState initState() {
    return RechargeState();
  }

  @override
  void onInit() {
    super.onInit();
    // 在这里添加初始化逻辑
  }

  @override
  void onClose() {
    super.onClose();
    // 在这里添加清理逻辑
  }
} 