import 'package:roomcard/base/base_controller.dart';
import 'package:roomcard/base/base_state.dart';
import 'package:get/get.dart';
import 'models/club_card_data.dart';

class ClubState extends BaseState {
  // 俱乐部页面的状态管理
  final clubCardList = <ClubCardData>[].obs;
}

class ClubLogic extends BaseController<ClubState> {
  @override
  ClubState initState() {
    return ClubState();
  }

  @override
  void onInit() {
    super.onInit();
    // 在这里添加初始化逻辑
    _initClubList();
  }
  
  /// 创建俱乐部
  void onCreateClub() {
    // TODO: 实现创建俱乐部逻辑
    print('Club: 创建俱乐部');
    Get.toNamed('/create-club');
  }
  
  /// 加入俱乐部
  void onJoinClub() {
    // TODO: 实现加入俱乐部逻辑
    print('Club: 加入俱乐部');
    Get.toNamed('/join-club');
  }
  
  /// 初始化俱乐部列表
  void _initClubList() {
    state.clubCardList.value = [
      ClubCardData(
        title: '但是我',
        clubId: '44708934',
        memberCount: 1,
        isCreator: true,
        isPublic: true,
        activeGames: 0,
        avatarPath: 'assets/images/Frame 83.png',
      ),
    ];
  }

  @override
  void onClose() {
    super.onClose();
    // 在这里添加清理逻辑
  }
} 