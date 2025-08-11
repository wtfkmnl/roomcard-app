import 'package:get/get.dart';
import 'package:roomcard/base/base_controller.dart';
import '../../routes/app_router.dart';
import 'my_state.dart';

class MyLogic extends BaseController<MyState> {
  @override
  MyState initState() {
    return MyState();
  }

  /// 好友转账点击
  void onFriendTransferTap() {
    print('好友转账');
  }

  /// 资金明细点击
  void onFundDetailTap() {
    print('资金明细');
  }

  /// 战绩点击
  void onGameRecordTap() {
    print('战绩');
  }

  /// 牌谱点击
  void onCardRecordTap() {
    print('牌谱');
  }

  /// 消息公告点击
  void onMessageTap() {
    print('消息公告');
  }

  /// 商务合作点击
  void onBusinessTap() {
    print('商务合作');
    Get.toNamed(AppRouter.mineBusiness.path);
  }

  /// 设置点击
  void onSettingsTap() {
    print('设置');
    Get.toNamed(AppRouter.mineSetting.path);
  }

  /// 提现点击
  void onWithdrawTap() {
    print('提现');
  }

  /// 充值点击
  void onRechargeTap() {
    print('充值');
  }
}
