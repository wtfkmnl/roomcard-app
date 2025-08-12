import 'package:roomcard/base/base_state.dart';
import 'package:get/get.dart';

class CreateRoomState extends BaseState with StateAutoManager {
  /// 当前选中的游戏模式索引 (0: 经典德州, 1: 奥马哈, 2: 德州短牌, 3: AOF)
  final selectedGameMode = 0.obs;
  
  /// 小盲/大盲索引
  final blindsIndex = 0.obs;
  
  /// 带入记分牌索引
  final bringInScoreIndex = 0.obs;
  
  /// 人满即开人数索引
  final playersToStartIndex = 0.obs;
  
  /// 前注索引
  final anteIndex = 0.obs;
  
  /// 游戏时长（小时）
  final gameDuration = 1.0.obs;
  
  /// 最小买入记分牌
  final minBuyIn = 100.obs;
  
  /// 买入上限
  final buyInLimit = 1000.obs;

  CreateRoomState() {
    /// Initialize variables
  }
} 