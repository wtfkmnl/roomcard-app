// import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:get/get.dart';
import 'package:roomcard/models/acct_info_model.dart';
import 'package:roomcard/models/app_config_model/index.dart';
import 'package:roomcard/models/archive_config_model.dart';
import 'package:roomcard/models/global_dic_model.dart';
import 'package:roomcard/models/login_regist/index.dart';
import 'package:roomcard/models/member_info_model.dart';
import 'package:roomcard/utils/open_share/openshare_data_handle.dart';
import 'package:roomcard/utils/storage_util.dart';
import 'package:roomcard/utils/values/constants.dart';

double statusBarHeight = 0;
double bottomSafeMarginHeight = 0;
double safeAreaHeight = 0;

class Global {
  static final _instance = Global._internal();
  static Global get instance => _instance;

  Global._internal();

  bool onGame = false;
  // List<MsgRecord>? msgList;

  /// appConfig 配置信息
  GlobalDicModel? dicModel;
  AppConfigModel? appConfig;
  // AlertType? currentAlert;
  // AppInfo? appInfo;
  // 登录注册设置信息
  LoginRegisterSettingModel? loginRegisterSettingModel;
  var archiveModel = ArchiveConfigModel.fromParams();
  final openShareDataModel = OpenShareDataModel();

  String? loginVerifyType;
  String? registerVerifyType;
  String traceId = "";

  String? contentLen = StorageUtil.getString(Constants.storageContentLen);
  String? xAuthToken = StorageUtil.getString(Constants.storageXAuthToken);
  String? authorization = StorageUtil.getString(Constants.storageAuthorization);

  ///彩金弹窗执行block 游戏地方需要延迟执行彩金弹窗
  Future Function()? giftAlertBlock;
  bool giftAlertNeedWait = false;

  String? spToken;
  String? platformAcct;
  String spCategory = '';
  String spName = '';
  bool imTyService = false;
  MemberInfoModel? memberInfo;
  AppInfo? appInfo;

  bool didShowMaintenanceAlert = false;

  ///wingo音效开启是否
  RxBool isWingoMusic = true.obs;

  ///不需要加密的接口路径
  List<String> noEncryPath = ["/picture/upload"];

  ///必须要加密的接口
  List<String> mustEncryPath = ["sy/dlicgh"];

  bool isLogin = false;

  // 获取资金变动类型
  List<Map<String, dynamic>?> memberAcctFundList = [];
  // 获取稽查类型
  List<Map<String, dynamic>?> memberInspectFundList = [];

  ///首页|活动|体育|我的|VIP|充值|提现|代理|交易|投注|洗码|邀请分享|客服|积分转盘
  ///Home | Activities | Sports | My | VIP | Recharge | Withdrawal | Agent | Transactions | Betting | Rebate | Invitation_Sharing|CustomerService | PointTurntable
  List<String> appMainTabBarItems = [
    "Home",
    "Activities",
    "Sports",
    "CustomerService",
    "My",
  ];

  clearData() {
    contentLen = null;
    xAuthToken = null;
    authorization = null;
  }
}

const appStyle2Value = "2";
