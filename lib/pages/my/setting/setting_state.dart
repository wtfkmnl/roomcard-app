import 'package:roomcard/base/base_state.dart';
import 'package:get/get.dart';

class SettingState extends BaseState with StateAutoManager {
  /// 多语言设置
  final language = '简体中文'.obs;
  
  /// 游戏音效开关
  final gameSound = true.obs;
  
  /// 消息声音开关
  final messageSound = true.obs;
  
  /// 消息震动开关
  final messageVibration = true.obs;
  
  /// 版本号
  final version = 'V1.0.0'.obs;

  SettingState() {
    /// Initialize variables
  }
}