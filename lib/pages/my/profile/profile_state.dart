import 'package:roomcard/base/base_state.dart';
import 'package:get/get.dart';

class ProfileState extends BaseState with StateAutoManager {
  /// 用户头像
  RxString avatar = ''.obs;
  
  /// 用户昵称
  RxString nickname = 'Poker'.obs;
  
  /// 用户ID
  RxString userId = '93651'.obs;
  
  /// 生日
  RxString birthday = '未设置'.obs;
  
  /// 性别 0-未设置 1-男性 2-女性
  RxInt gender = 1.obs;
  
  /// 获取性别文本
  String get genderText {
    switch (gender.value) {
      case 1:
        return '男生';
      case 2:
        return '女生';
      default:
        return '未设置';
    }
  }

  ProfileState() {
    /// Initialize variables
  }
}