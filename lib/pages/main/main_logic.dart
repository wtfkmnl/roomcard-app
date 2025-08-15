import 'package:roomcard/api/app_config.dart';
import 'package:roomcard/base/base_controller.dart';
import 'package:roomcard/pages/main/models/nav_item.dart';
import 'package:roomcard/pages/home/home_view.dart';
import 'package:roomcard/pages/club/club_view.dart';
import 'package:roomcard/pages/recharge/recharge_view.dart';
import 'package:roomcard/pages/my/my_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'main_state.dart';

class MainLogic extends BaseController<MainState>
    with GetSingleTickerProviderStateMixin {
  @override
  MainState initState() {
    return MainState();
  }

  @override
  void onInit() {
    super.onInit();
    AppConfigApi.dlicgh();
    // 初始化底部导航栏数据
    _initBottomData();

    // 创建 TabController 用于页面切换
    state.tabController = TabController(
      length: state.navItems.length,
      vsync: this,
    );
  }

  /// 初始化底部导航栏数据
  void _initBottomData() {
    state.navItems = [
      NavItem(
        iconPath: 'assets/images/bottom_nav/home_icon.svg',
        activeIconPath: 'assets/images/bottom_nav/home_active_icon.svg',
        label: '首页',
        page: const HomePage(),
      ),
      NavItem(
        iconPath: 'assets/images/bottom_nav/club_icon.svg',
        activeIconPath: 'assets/images/bottom_nav/club_active_icon.svg',
        label: '俱乐部',
        page: const ClubPage(),
      ),
      NavItem(
        iconPath: 'assets/images/bottom_nav/recharge_icon.svg',
        activeIconPath: 'assets/images/bottom_nav/recharge_active_icon.svg',
        label: '充值',
        page: const RechargePage(),
      ),
      NavItem(
        iconPath: 'assets/images/bottom_nav/my_icon.svg',
        activeIconPath: 'assets/images/bottom_nav/my_active_icon.svg',
        label: '我的',
        page: const MyPage(),
      ),
    ];
  }

  /// 底部导航栏点击事件
  void onTapBottom(int index) {
    state.navIndex.value = index;
    state.tabController?.animateTo(index);
  }
}
