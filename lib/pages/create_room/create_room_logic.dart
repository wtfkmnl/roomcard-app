import 'package:roomcard/base/base_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'create_room_state.dart';

class CreateRoomLogic extends BaseController<CreateRoomState> {
  late FocusNode roomNameFocusNode;
  late TextEditingController roomNameController;

  @override
  CreateRoomState initState() {
    // 在initState中初始化controller和focusNode
    roomNameFocusNode = FocusNode();
    roomNameController = TextEditingController();
    return CreateRoomState();
  }

  @override
  void onInit() {
    super.onInit();
    // 初始化controller的文本
    roomNameController.text = state.roomName.value;
    
    // 监听controller的文本变化
    roomNameController.addListener(() {
      if (state.roomName.value != roomNameController.text) {
        state.roomName.value = roomNameController.text;
      }
    });
  }

  @override
  void onClose() {
    roomNameController.dispose();
    roomNameFocusNode.dispose();
    super.onClose();
  }

  /// 选择游戏模式
  void selectGameMode(int index) {
    state.selectedGameMode.value = index;
  }



  /// 设置小盲/大盲
  void setBlinds(int index) {
    state.blindsIndex.value = index;
  }

  /// 设置带入记分牌
  void setBringInScore(int index) {
    state.bringInScoreIndex.value = index;
  }

  /// 设置人满即开人数
  void setPlayersToStart(int index) {
    state.playersToStartIndex.value = index;
  }

  /// 设置前注
  void setAnte(int index) {
    state.anteIndex.value = index;
  }

  /// 设置游戏时长
  void setGameDuration(double value) {
    state.gameDuration.value = value;
  }

  /// 设置最小买入记分牌
  void setMinBuyIn(int value) {
    state.minBuyIn.value = value;
  }

  /// 设置买入上限
  void setBuyInLimit(int value) {
    state.buyInLimit.value = value;
  }

  /// 创建牌局
  void createRoom() {
    // TODO: 实现创建牌局的逻辑
    Get.back();
    Get.snackbar('提示', '牌局创建成功！');
  }
} 