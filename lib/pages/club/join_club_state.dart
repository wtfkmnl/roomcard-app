import 'package:get/get.dart';
import 'package:roomcard/base/base_state.dart';

/// 加入俱乐部页面状态管理
class JoinClubState extends BaseState with StateAutoManager {
  /// 俱乐部ID输入数组（8位）
  final clubId = List.filled(8, '').obs;
  
  /// 当前焦点索引
  final currentFocusIndex = 0.obs;
} 