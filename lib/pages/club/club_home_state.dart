import 'package:roomcard/base/base_state.dart';
import 'package:get/get.dart';
import '../home/widgets/game_card_list_widget.dart';

class ClubHomeState extends BaseState with StateAutoManager {
  /// 当前选中的游戏类型索引
  final selectedGameTypeIndex = 0.obs;
  
  /// 游戏列表数据
  final gameList = <GameCardData>[].obs;

  ClubHomeState() {
    /// Initialize variables
  }
} 