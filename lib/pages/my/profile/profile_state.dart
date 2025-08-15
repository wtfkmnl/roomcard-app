import 'package:roomcard/base/base_state.dart';
import 'package:get/get.dart';

import '../../../global.dart';

class ProfileState extends BaseState with StateAutoManager {
  /// 用户头像
  final avatar = (Global.instance.memberInfo?.headPortrait ?? '').obs;

  /// 用户昵称
  final nickname = (Global.instance.memberInfo?.nickName ?? '-').obs;

  /// 用户ID
  final userId = '${Global.instance.memberInfo?.rowId ?? '-'}'.obs;

  /// 生日
  final birthday = '未设置'.obs;

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
