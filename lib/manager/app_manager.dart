

class AppManager {
  /// App盘口编码
  // static const String companyCode = "zzzcode";
  static const String companyCode = "test4";

  ///APP 版本号
  late final String appVersion;

  ///APP 名称
  late final String appName;

  bool get isLogin {
    return false;
  }

  /// 单例模式
  AppManager._();

  static AppManager? _instance;

  factory AppManager() => _instance ??= AppManager._();

  Future<void> init() async {

  }



}
