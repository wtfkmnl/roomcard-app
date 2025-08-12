import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:roomcard/models/acct_info_model.dart';
import 'package:roomcard/utils/commonUtils.dart';

class GlobalDataService extends GetxService {
  static GlobalDataService get instance => Get.find<GlobalDataService>();

  var timeZoneOffset = Duration.zero;
  var timeZoneOffsetFlag = false;

  final keyboardVisibilityController = KeyboardVisibilityController();
  late StreamSubscription<bool> keyboardSubscription;

  final _keyboardOn = false.obs;
  bool get keyboardOn => _keyboardOn.value;
  set keyboardOn(bool value) => _keyboardOn.value = value;

  final _isLogin = false.obs;
  bool get isLogin => _isLogin.value;
  set isLogin(bool value) => _isLogin.value = value;

  final _preLoginStatus = false.obs;
  bool get preLoginStatus => _preLoginStatus.value;
  set preLoginStatus(bool value) => _preLoginStatus.value = value;

  final _networkReachable = false.obs;
  bool get networkReachable => _networkReachable.value;
  set networkReachable(bool value) => _networkReachable.value = value;

  final _accountInfo = AcctInfoModel.fromParams().obs;
  AcctInfoModel get accountInfo => _accountInfo.value;
  set accountInfo(AcctInfoModel value) => _accountInfo.value = value;

  final _onRefreshingAccountInfo = false.obs;
  bool get onRefreshingAccountInfo => _onRefreshingAccountInfo.value;
  set onRefreshingAccountInfo(bool value) =>
      _onRefreshingAccountInfo.value = value;

  final _activityTabShowActivityRedDot = false.obs;
  bool get activityTabShowActivityRedDot =>
      _activityTabShowActivityRedDot.value;
  set activityTabShowActivityRedDot(bool value) =>
      _activityTabShowActivityRedDot.value = value;

  final _activityTabShowTaskRedDot = false.obs;
  bool get activityTabShowTaskRedDot => _activityTabShowTaskRedDot.value;
  set activityTabShowTaskRedDot(bool value) =>
      _activityTabShowTaskRedDot.value = value;

  /// 收藏的游戏
  final _gameCollectedKeys = <String>[].obs;
  List<String> get gameCollectedKeys => _gameCollectedKeys;
  set gameCollectedKeys(List<String> value) => _gameCollectedKeys.value = value;

  // final Rx<AgentRedDotInfoModel> _agentRedDotInfo = AgentRedDotInfoModel.fromParams().obs;
  // AgentRedDotInfoModel get agentRedDotInfo => _agentRedDotInfo.value;
  // set agentRedDotInfo(AgentRedDotInfoModel value) => _agentRedDotInfo.value = value;

  late final StreamSubscription _netStatusSubscription;

  List<ConnectivityResult>? networkStatus;

  late final StreamSubscription _eventSubscription;

  // 用于记录 只打开一次的通告/活动的 Id
  final onceNoticeRowIds = [].obs;
  // 用于记录 登录前只打开一次的通告/活动的 Id
  final beginLoginOnceNoticeRowIds = [].obs;
  // 用于记录 每次登陆都要打开的通告/活动 id
  final loginNoticeRowIds = [].obs;

  @override
  void onInit() {
    ever(_isLogin, (val) {
      if (!val) {
        loginNoticeRowIds.value = [];
      }
    });
    keyboardSubscription = keyboardVisibilityController.onChange.listen((
      bool visible,
    ) {
      printSome("keyboard ${visible ? "on" : "off"}");
      GlobalDataService.instance.keyboardOn = visible;
      // SharedEventBus.eventBus.fire(KeyboardStatusChangeEvent(visible: visible));
    });

    _netStatusSubscription = Connectivity().onConnectivityChanged.listen((
      event,
    ) async {
      var newValue = CommonUtils.isNetworkReachable(event);
      var oldValue = CommonUtils.isNetworkReachable(networkStatus);
      bool change = newValue != oldValue;
      if (change) {
        networkStatus = event;
        networkReachable = newValue;
        // SharedEventBus.eventBus.fire(
        //   NetworkStatusChangeEvent(status: newValue),
        // );
      }
    });
    Connectivity().checkConnectivity().then((value) => networkStatus = value);

    // _eventSubscription = SharedEventBus.eventBus.on().listen((event) {
    //   if (event is LoginStatusEvent) {
    //     if (isLogin) {
    //       playedGames = [];
    //     } else {
    //       refreshPlayedGames();
    //       // handleTaskBadge();
    //     }
    //   }
    // });

    timeZoneOffset = DateTime.now().timeZoneOffset;

    super.onInit();
  }

  void clearData() {
    // activityTabBadgeValue = 0;
    activityTabShowActivityRedDot = false;
    activityTabShowTaskRedDot = false;
    // agentRedDotInfo = AgentRedDotInfoModel.fromParams();
    isLogin = false;
    accountInfo = AcctInfoModel.fromParams();
  }

  // String getGameIconWithName({required String game}) {
  //   if (game == "CHAMPION_SHIP") {
  //     return R.assetsImagesGameJbs;
  //   } else if (game == "TEXAS_HOLDEM") {
  //     return R.assetsImagesGameDezhou;
  //   } else if (game == "BULLFIGHT") {
  //     return R.assetsImagesGameNiuNiu;
  //   } else if (game == "GOLDEN_FLOWER") {
  //     return R.assetsImagesGameJinHua;
  //   } else {
  //     return R.assetsImagesGameJinHua;
  //   }
  // }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    _netStatusSubscription.cancel();
    _eventSubscription.cancel();
    super.onClose();
  }
}
