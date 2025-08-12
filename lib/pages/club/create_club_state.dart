import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roomcard/base/base_state.dart';

/// 创建俱乐部页面状态管理
class CreateClubState extends BaseState with StateAutoManager {
  /// 俱乐部名称输入控制器
  final clubNameController = TextEditingController();
  
  /// 俱乐部公告输入控制器
  final announcementController = TextEditingController();
  
  /// 俱乐部名称字符长度
  final clubNameLength = 0.obs;
  
  /// 俱乐部公告字符长度
  final announcementLength = 0.obs;
  
  /// 选中的地区
  final selectedLocation = '中国'.obs;
  
  @override
  void onClose() {
    clubNameController.dispose();
    announcementController.dispose();
    super.onClose();
  }
} 