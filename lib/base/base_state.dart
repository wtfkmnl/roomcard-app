import 'dart:async';

import 'package:flutter/material.dart';

abstract class BaseState {
  ///即将初始化状态的方法
  // void onInit(); //理论state里是不需要有任何逻辑的。防止onInit逻辑过多

  ///即将关闭状态的方法
  void onClose() {
    debugPrint('[😋] "$runtimeType" onClose() called');
  }
}

const _controllerTypes = [
  TextEditingController,
  TabController,
  ScrollController,
  PageController,
  AnimationController,
];
mixin StateAutoManager on BaseState {
  bool _disposed = false;
  final _subscriptions = <StreamSubscription>[];
  final _controllers = <dynamic>[];

  ///自动管理StreamSubscription的cancel,如果参数为空则不会添加。
  ///```
  ///addAutoCancelSubscription(stream.listen((data) {})); // 自动管理
  ///```
  void addAutoCancelSubscription(StreamSubscription? sub) {
    if (_disposed) {
      throw StateError('Cannot add StreamSubscription after disposal');
    }
    if (sub != null) {
      _subscriptions.add(sub);
    }
  }

  ///自动管理各类Controller的dispose
  ///```
  ///useAutoDispose<TextEditController>(TextEditController()); // 自动管理
  ///```
  /// return T
  // T useAutoDispose<T>(T controller) {
  //   if (_disposed) throw StateError('Cannot add controller after disposal');
  //   if (_controllerTypes.contains(controller.runtimeType)) {
  //     _controllers.add(controller);
  //     return controller;
  //   }
  //   throw ArgumentError(
  //     '参数必须是:$_controllerTypes , 但是您的实际参数是:${controller.runtimeType}',
  //   );
  // }

  @override
  void onClose() {
    if (_disposed) return; // 防止重复调用
    _disposed = true;
    for (var item in _subscriptions) {
      item.cancel();
    }
    for (var item in _controllers) {
      if (_controllerTypes.contains(item)) {
        item.dispose();
      }
    }
    _subscriptions.clear();
    _controllers.clear();
    super.onClose();
  }
}
