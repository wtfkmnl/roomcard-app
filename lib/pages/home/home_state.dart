
import 'package:roomcard/base/base_state.dart';
import 'package:get/get.dart';
import 'widgets/game_card_list_widget.dart';
import '../../widgets/app_drawer.dart';

class HomeState extends BaseState with StateAutoManager {
  /// 当前选中的游戏模式索引 (0: 俱乐部, 1: 朋友局, 2: 大厅)
  final selectedGameMode = 0.obs;
  
  /// 当前选中的游戏大小索引 (0: 微型, 1: 小型, 2: 正常, 3: 高级)
  final selectedGameSize = 0.obs;
  
  /// 是否只显示空位
  final showEmptySlotsOnly = false.obs;
  
  /// 当前选中的游戏操作 (0: 创建牌局, 1: 加入牌局)
  final selectedGameAction = 0.obs;
  
  /// 用户余额
  final userBalance = 0.obs;
  
  /// 游戏列表数据
  final gameList = <GameCardData>[].obs;
  
  /// 当前选中的游戏类型
  final selectedGameType = GameType.all.obs;

  HomeState() {
    /// Initialize variables
  }
}
