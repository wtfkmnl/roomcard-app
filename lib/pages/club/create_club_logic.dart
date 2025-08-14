import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roomcard/base/base_controller.dart';
import 'package:roomcard/base/base_state.dart';
import 'create_club_state.dart';

/// 创建俱乐部页面逻辑控制器
class CreateClubLogic extends BaseController<CreateClubState> {
  @override
  CreateClubState initState() {
    return CreateClubState();
  }

  @override
  void onInit() {
    super.onInit();
    // 初始化逻辑
  }

  /// 选择头像
  void selectAvatar(String avatarPath) {
    state.selectedAvatar.value = avatarPath;
  }

  /// 创建俱乐部
  void createClub() {
    final clubName = state.clubNameController.text.trim();
    final announcement = state.announcementController.text.trim();
    
    if (clubName.isEmpty) {
      Get.snackbar('提示', '请输入俱乐部名称');
      return;
    }
    
    if (clubName.length < 2) {
      Get.snackbar('提示', '俱乐部名称至少需要2个字符');
      return;
    }
    
    // TODO: 实现创建俱乐部的API调用
    print('创建俱乐部: $clubName, 公告: $announcement, 头像: ${state.selectedAvatar.value}');
    
    Get.snackbar('成功', '俱乐部创建成功！');
    Get.back();
  }
} 