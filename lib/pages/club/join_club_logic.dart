import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:roomcard/base/base_controller.dart';
import 'package:roomcard/base/base_state.dart';
import 'join_club_state.dart';

/// 加入俱乐部页面逻辑控制器
class JoinClubLogic extends BaseController<JoinClubState> {
  @override
  JoinClubState initState() {
    return JoinClubState();
  }

  @override
  void onInit() {
    super.onInit();
    // 初始化逻辑
  }

  /// 数字按钮按下
  void onNumberPressed(String number) {
    // 这个方法现在在视图中直接实现
    if (state.currentFocusIndex.value < 8) {
      state.clubId[state.currentFocusIndex.value] = number;
      if (state.currentFocusIndex.value < 7) {
        state.currentFocusIndex.value++;
      }
    }
  }

  /// 删除按钮按下
  void onDeletePressed() {
    // 这个方法现在在视图中直接实现
    if (state.currentFocusIndex.value > 0) {
      state.currentFocusIndex.value--;
      state.clubId[state.currentFocusIndex.value] = '';
    } else if (state.currentFocusIndex.value == 0 && state.clubId[0].isNotEmpty) {
      state.clubId[0] = '';
    }
  }

  /// 粘贴按钮按下
  void onPastePressed() async {
    final ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);
    if (data != null && data.text != null && data.text!.length >= 8) {
      final clubIdString = data.text!.substring(0, 8);
      if (clubIdString.length == 8 && RegExp(r'^\d{8}$').hasMatch(clubIdString)) {
        for (int i = 0; i < 8; i++) {
          state.clubId[i] = clubIdString[i];
        }
        state.currentFocusIndex.value = 7; // 粘贴后光标在最后一个输入框
      } else {
        Get.snackbar('提示', '剪贴板内容不符合俱乐部ID格式');
      }
    } else {
      Get.snackbar('提示', '剪贴板内容不足8位或不是纯数字');
    }
  }

  /// 加入俱乐部
  void joinClub() {
    final clubIdString = state.clubId.join('');
    
    if (clubIdString.length < 8) {
      Get.snackbar('提示', '请输入完整的俱乐部ID');
      return;
    }
    
    // TODO: 实现加入俱乐部的API调用
    print('加入俱乐部ID: $clubIdString');
    
    Get.snackbar('成功', '成功加入俱乐部！');
    Get.back();
  }
} 