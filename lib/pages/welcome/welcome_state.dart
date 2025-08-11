import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:roomcard/base/base_state.dart';

class WelcomeState extends BaseState {
  /// 启动图
  // late Widget launchBg = Container(color: Colors.white,);
  /// 客服是否展示
  final showKeFu = false.obs;

  /// app版本号是否展示
  final showAppVersion = false.obs;

  /// 重新请求是否展示
  final showReconnect = false.obs;

  /// 倒计时是否展示
  final showDowncount = false.obs;

  File? launchBgFile;

  /// 计时器
  Timer? timer;

  /// 倒计时计数
  final downCount = 5.obs;

  /// 错误内容
  final errorStr = "".obs;
  // 重复请求次数
  int autoRetryCount = 0;
  // 自动重试次数
  int retryCount = 2;

  /// 网络状态监听
  StreamSubscription? listener;

  /// 进入首页
  bool intoMain = false;

  WelcomeState() {
    /// Initialize variables
  }

  @override
  void onClose() {
    timer?.cancel();
    listener?.cancel();
    super.onClose();
  }
}
