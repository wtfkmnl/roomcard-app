import 'package:roomcard/base/base_controller.dart';
import 'package:roomcard/base/base_state.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:roomcard/routes/app_router.dart';
import 'package:roomcard/widgets/join_room_bottom_sheet.dart';
import 'home_state.dart';
import 'widgets/game_card_list_widget.dart';
import '../../widgets/app_drawer.dart';

class HomeLogic extends BaseController<HomeState> {
  @override
  HomeState initState() {
    return HomeState();
  }

  @override
  void onInit() {
    super.onInit();
    
    // 初始化一些测试数据
    state.userBalance.value = 1000;
    
    // 初始化游戏列表测试数据
    _initGameList();
    
    // 打印调试信息
    print('HomeLogic initialized with balance: ${state.userBalance.value}');
  }

  /// 选择游戏模式
  void selectGameMode(int index) {
    state.selectedGameMode.value = index;
  }
  
  /// 选择游戏类型
  void selectGameType(GameType gameType) {
    state.selectedGameType.value = gameType;
    // TODO: 根据游戏类型筛选游戏列表
    print('选择游戏类型: $gameType');
  }
  
  /// 初始化游戏列表
  void _initGameList() {
    state.gameList.value = [
      GameCardData(
        title: '矿区夺钻赛-6人桌',
        subtitle: '小盲/大盲 (前注)',
        gameType: '经典德州',
        prizeMoney: 4000.00,
        entryFee: 8.8,
        participants: 185,
        gameMode: '朋友局',
        timeInfo: '即奖开赛\n48分钟',
        status: 1,
        currentPlayers: 6,
        maxPlayers: 6,
      ),
      GameCardData(
        title: '这里来牌局名称',
        subtitle: '小盲/大盲 (前注)',
        gameType: '经典德州',
        prizeMoney: 0.0,
        entryFee: 0.0,
        participants: 0,
        gameMode: '朋友局',
        timeInfo: '这里来牌局名称',
        status: 2,
        currentPlayers: 2,
        maxPlayers: 9,
      ),
    ];
  }

  /// 选择游戏大小
  void selectGameSize(int index) {
    state.selectedGameSize.value = index;
  }

  /// 切换空位显示
  void toggleEmptySlotsOnly(bool? value) {
    state.showEmptySlotsOnly.value = value ?? false;
  }

  /// 选择游戏操作
  void selectGameAction(int index) {
    state.selectedGameAction.value = index;
    if (index == 0) { // 创建牌局
      Get.toNamed(AppRouter.createRoom.path);
    } else if (index == 1) { // 加入牌局
      _showJoinRoomBottomSheet();
    }
  }

  /// 显示加入牌局底部抽屉
  void _showJoinRoomBottomSheet() {
    Get.bottomSheet(
      const JoinRoomBottomSheet(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  /// 刷新数据
  void refreshData() {
    // TODO: 实现刷新逻辑
    Get.snackbar('提示', '正在刷新数据...');
  }

  /// 跳转到充值页面
  void goToRecharge() {
    // TODO: 跳转到充值页面
    Get.snackbar('提示', '跳转到充值页面');
  }

  /// 打开通知
  void openNotifications() {
    // TODO: 打开通知
    Get.snackbar('提示', '打开通知');
  }

  /// 打开排行榜
  void openLeaderboard() {
    // TODO: 打开排行榜
    Get.snackbar('提示', '打开排行榜');
  }
}
