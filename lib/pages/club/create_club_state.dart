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
  
  /// 当前选中的头像
  final selectedAvatar = 'assets/images/club/img_club_head_0.png'.obs;
  
  /// 可选择的头像列表
  final List<String> avatarOptions = [
    'assets/images/club/img_club_head_0.png',
    'assets/images/club/img_club_head_1.png',
    'assets/images/club/img_club_head_2.png',
    'assets/images/club/img_club_head_3.png',
    'assets/images/club/img_club_head_4.png',
    'assets/images/club/img_club_head_5.png',
    'assets/images/club/img_club_head_6.png',
    'assets/images/club/img_club_head_7.png',
    'assets/images/club/img_club_head_8.png',
    'assets/images/club/img_club_head_9.png',
  ];
  
  @override
  void onClose() {
    clubNameController.dispose();
    announcementController.dispose();
    super.onClose();
  }
} 