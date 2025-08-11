import 'package:roomcard/base/base_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'models/nav_item.dart';

class MainState extends BaseState with StateAutoManager {
  ///底部tabbar索引
  final navIndex = 0.obs;

  ///内容页面
  TabController? tabController;

  ///内容配置数据
  var navItems = <NavItem>[];

  @override
  void onClose() {
    tabController?.dispose();
    super.onClose();
  }
}
