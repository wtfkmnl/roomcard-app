import 'package:roomcard/base/base_state.dart';
import 'package:get/get.dart';

class SafeManagerState extends BaseState with StateAutoManager {
  /// 安全密码保护开关
  final passwordProtection = false.obs;
  
  /// 绑定手机状态
  final phoneBinding = '去绑定'.obs;
  
  /// 绑定邮箱状态
  final emailBinding = '去绑定'.obs;
  
  /// 登录安全验证开关
  final loginSecurityVerification = true.obs;

  /// 安全验证说明弹窗显示状态
  final showSecurityTipDialog = false.obs;

  SafeManagerState() {
    /// Initialize variables
  }
}