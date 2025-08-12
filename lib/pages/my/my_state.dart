import 'package:roomcard/base/base_state.dart';
import 'package:get/get.dart';

class MyState extends BaseState with StateAutoManager {
  /// 登录成功状态监听
  final logined = true.obs;

  /// 用户信息
  final userName = 'Duo-123'.obs;
  final userId = 'ID:30702607'.obs;
  final userBalance = '19999999.000'.obs;
  final userAvatar = ''.obs; // 头像

  MyState() {
    /// Initialize variables
  }
}
