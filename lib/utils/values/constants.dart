/// 常量
class Constants {
  // 本地存储key
  static const storageTraceId = 'traceId';
  static const storagePlayedGameCode = 'playedGameCode';
  static const storageThemeName = 'themeName';
  static const storageXAuthToken = 'XAuthToken';
  static const storageAuthorization = 'authorization';
  static const storageMsgIds = 'msgIds';
  static const storageDelteMsgIds = 'deletemsgIds';
  static const storageContentLen = 'contentLen';
  static const storageDefaultBank = 'defaultBank';
  static const storageSearch = 'Search';
  static const storageDefaultCropty = 'defaultCropty';
  static const storageDefaultEWallet = 'defaultEWallet';
  static const storageDefaultAlipayEWallet = 'defaultalipayEWallet';
  static const storageDefaultDigit = "defaultDigit";
  static const storageFeedBackIds = 'feedBackIds';
  static const storageAppInfoData = "storageAppInfoData";
  static const preAccount = "preAccount";

  static const storageMemberInfo = 'memberInfo';
  static const storageMemberIdAccount = 'memberIdAccount';
  static const storageMemberIdPhone = 'memberIdPhone';
  static const storageMemberPwd = 'memberPwd';
  static const storageMemberAccountPsw = 'accountPsw';

  /// 游戏收藏
  static const storageCollect = 'collect';
  static const storageGameCollect = 'gameCollect';
  static const storagePlayOftenGame = 'playOftenGame';
  static const storageXAuthTokenAgent = 'x-auth-token_agent';
  static const storageAuthorizationAgent = 'authorization_agent';
  static const noteAlertTodayClose = "noteAlertTodayClose";
  static const currencyList = 'currencyList';
  static const multipleValues = "multipleValues";
  static const storageSSCCounter = "storageSSCCounter";
  static const storageSysAuthType = "storageSysAuthType";
  static const storageRememberPassword = "storageRememberPassword";
  static const storageKsPanel2Counter = "storageKsPanel2Counter";
  static const storageLottery3kCounter = "storageLottery3kCounter";
  static const storageLottery5dCounter = "storageLottery5dCounter";
  static const storageGameData = "storageGameData";
  static const storageGameType = "storageGameType";
  static const storageBannerData = "storageBannerData";
  static const storageOpenAudio = "storageOpenAudio";

  static const storageDefaultLoginAccount = "storageDefaultLoginAccount";

  static const storageAccountInfoInSecurity = "storageAccountInfoInSecurity";

  static String counters = 'counters';
  static String lastSelectedCounter = 'lastSelectedCounter';
  static String betBoardFixedValue = 'betBoardFixedValue';

  static const storageTaskHomeAlert = "storageTaskHomeAlert";
  static const storageFreshTaskHomeAlert = "storageFreshTaskHomeAlert";
  static const storageActivityHomeAlert = "storageActivityHomeAlert";
  static const storageRedPacketHomeAlert = "storageRedPacketHomeAlert";
  static const activityRowIdList = "activityRowIdList";
  static const activityRowIdListUnLogin = "activityRowIdListUnLogin";
  static const activityTodayWithLogin = "activityTodayWithLogin";

  static const storageTaskHomeAlertNotLogin = "storageTaskHomeAlertNotLogin";
  static const storageFreshTaskHomeAlertNotLogin =
      "storageFreshTaskHomeAlertNotLogin";
  static const storageActivityHomeAlertNotLogin =
      "storageActivityHomeAlertNotLogin";

  /// 隐藏余额为0的币种
  static const storageHideZeroBalanceCurrency =
      "storageHideZeroBalanceCurrency";

  static const storePasswordAESKey = "storePasswordAES";

  // 语言
  static const storageLanguageCode = 'languageCode';
  // wp 服务器
  // static const amApiBaseUrl = 'https://h54.systesttohyooch.com:8442/v1';
  // 站点
  // static const site = "ZtEdJdbt"; //bv01正式
  // static String site = "XvwqHews"; //pg测试
  // static String site = "bb01"; //bb01
  // static String site = "UPmo2Od9"; //综合版
  // static const openShareKey = "b4SkcJan3o0oS7I";

  // 需要传入认证的路径
  static List<String> needAuthPaths = ['/mc/loginMember', '/mc/newMember'];

  // USDT协议
  static List<String> protocols = ["TRC20", "BEP2", "BEPSC", "ERC20"];

  ///邀请码
  // static String? invitationCode;

  ///下载地址
  // static String? downloadSite;

  ///PIX 类型
  static List<String> pixTypes = ["EMAIL", "PHONE", "CPF", "EVP"];

  ///埋点 事件名
  //购买
  static String purchase = "Purchase";
  //完成支付
  static String completePayment = "CompletePayment";
  //打开H5
  static String viewContent = "ViewContent";
  //充值
  static String firstDeposit = "FirstDeposit";
  //完成注册
  static String completeRegistration = "CompleteRegistration";


  static String storageHomePop = "storageHomePop";

  static String storageHomeCacheDeZhou = "storageCacheDeZhou";
}
