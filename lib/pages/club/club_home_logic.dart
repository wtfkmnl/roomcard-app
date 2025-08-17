import 'package:roomcard/base/base_controller.dart';
import 'package:roomcard/base/base_state.dart';
import 'package:get/get.dart';
import 'club_home_state.dart';
import '../home/widgets/game_card_list_widget.dart';

class ClubHomeLogic extends BaseController<ClubHomeState> {
  @override
  ClubHomeState initState() {
    return ClubHomeState();
  }

  @override
  void onInit() {
    super.onInit();
    
    // 初始化游戏列表测试数据
    _initGameList();
    
    print('ClubHomeLogic initialized');
  }

  /// 选择游戏类型
  void selectGameType(int index) {
    state.selectedGameTypeIndex.value = index;
    // TODO: 根据游戏类型筛选游戏列表
    print('选择游戏类型: $index');
  }

  /// 初始化游戏列表
  void _initGameList() {
    state.gameList.value = [
      GameCardData(
        title: '俱乐部德州扑克-6人桌',
        subtitle: '小盲/大盲 (前注)',
        gameType: '经典德州',
        prizeMoney: 5000.00,
        entryFee: 10.0,
        participants: 120,
        gameMode: '俱乐部局',
        timeInfo: '即奖开赛\n60分钟',
        status: 1,
        currentPlayers: 4,
        maxPlayers: 6,
      ),
      GameCardData(
        title: '奥马哈高牌赛',
        subtitle: '小盲/大盲 (前注)',
        gameType: '奥马哈',
        prizeMoney: 3000.00,
        entryFee: 5.0,
        participants: 85,
        gameMode: '俱乐部局',
        timeInfo: '即将开赛\n30分钟',
        status: 1,
        currentPlayers: 8,
        maxPlayers: 9,
      ),
      GameCardData(
        title: '短牌德州扑克',
        subtitle: '小盲/大盲 (前注)',
        gameType: '德州短牌',
        prizeMoney: 0.0,
        entryFee: 0.0,
        participants: 0,
        gameMode: '俱乐部局',
        timeInfo: '等待开始',
        status: 2,
        currentPlayers: 2,
        maxPlayers: 6,
      ),
    ];
  }
} 