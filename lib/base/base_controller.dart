import 'dart:async';

import 'base_state.dart';
import 'package:get/get.dart';

abstract class BaseController<S extends BaseState> extends GetxController {
  late final S _state;
  S get state {
    return _state;
  }

  @override
  void onInit() {
    super.onInit(); // 必须首先调用
    _state = initState();
    // _state.onInit(); // 明确状态初始化
  }

  ///内部自动调用了state.onClose() 函数
  @override
  void onClose() {
    _state.onClose();

    for (var item in _subscriptions) {
      item.cancel();
    }
    _subscriptions.clear();

    for (var item in _timers) {
      item.cancel();
    }
    _timers.clear();

    super.onClose(); // 必须最后调用
  }

  S initState() {
    throw StateError('必须在super.onInit()之后进行调用, 并且实现initState方法和初始化对应的state.');
  }

  final _subscriptions = <StreamSubscription>[];
  final _timers = <Timer>[];

  ///自动管理StreamSubscription的cancel,如果参数为空则不会添加。
  ///```
  ///addAutoCancelSubscription(stream.listen((data) {})); // 自动管理
  ///```
  void addAutoCancel(dynamic type) {
    if (type == null) {
      return;
    }
    if (type is StreamSubscription) {
      _subscriptions.add(type);
    } else if (type is Timer) {
      _timers.add(type);
    }
  }
}
