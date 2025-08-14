import 'package:flutter/cupertino.dart';
import 'package:roomcard/base/base_state.dart';
import 'package:get/get.dart';

import '../../global.dart';

class MyState extends BaseState with StateAutoManager {

  /// 用户信息
  final userName = (Global.instance.memberInfo?.nickName ?? '-').obs;
  final userId = 'ID:${Global.instance.memberInfo?.rowId ?? '-'}'.obs;
  final userBalance = '0'.obs;
  final userAvatar = Global.instance.memberInfo?.headPortrait.obs; // 头像

  MyState() {
    /// Initialize variables
  }
}
