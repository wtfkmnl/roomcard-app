import 'dart:async';
import 'dart:io';

import 'package:roomcard/api/app_config.dart';
import 'package:roomcard/api/user.dart';
import 'package:roomcard/base/base_controller.dart';
import 'package:roomcard/global.dart';
import 'package:roomcard/services/global_data_service.dart';
import '../../routes/app_router.dart';
import 'welcome_state.dart';
import 'package:path_provider/path_provider.dart';

class WelcomeLogic extends BaseController<WelcomeState> {
  void _loadLaunchImage() {}

  Future<String> _saveBytesToSandbox(List<int> bytes, String fileName) async {
    String sandBoxPath = await _getSandBoxPath();
    // 在子目录中保存图片文件
    File imageFile = File('$sandBoxPath/$fileName');
    await imageFile.writeAsBytes(bytes);
    return imageFile.path;
  }

  static Future<String> _getSandBoxPath() async {
    // 获取应用程序的沙盒目录
    Directory appDocDir = await getApplicationDocumentsDirectory();
    // 创建一个名为 "images" 的子目录
    Directory imagesDir = Directory('${appDocDir.path}/images');
    if (!imagesDir.existsSync()) {
      imagesDir.createSync();
    }
    return imagesDir.path;
  }

  /// 请求桶域名
  void onInitRequestBucket() {
    state.showDowncount.value = true;
    state.downCount.value = 0;
    state.errorStr.value = "";
    startTimer();
  }

  // 开始倒计时
  void startTimer() {
    state.timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.downCount.value > 0) {
        state.downCount.value--;
      }
      if (state.downCount.value == 0) {
        goToMainPage();
      }
    });
  }

  // 进入主页面
  void goToMainPage() async {
    if (!state.intoMain) {
      state.intoMain = true;
      stopTimer();
      if (GlobalDataService.instance.isLogin) {
        await UserApi.getMemberInfo();
        AppRouter.main.offAll();
      } else {
        AppRouter.loginRegist.offAll();
      }
    }
  }

  // 关闭倒计时
  void stopTimer() {
    if (state.timer != null) {
      state.downCount.value = 0;
      state.timer?.cancel();
    }
  }

  Future<bool> onInitRequestConfig() async {
    //等待3秒
    await Future.delayed(const Duration(seconds: 3));
    return true;
  }

  @override
  void onInit() async {
    super.onInit();
    _loadLaunchImage();

    await onInitAppConfig();
    onInitRequestBucket();
  }

  // 启动APP配置
  Future<void> onInitAppConfig() async {}

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  @override
  WelcomeState initState() {
    // TODO: implement initState
    return WelcomeState();
  }
}
