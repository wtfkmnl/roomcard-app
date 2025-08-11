import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PageBackUtils {
  // 点击返回
  clickGoBack() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((value) {
      Future.delayed(const Duration(milliseconds: 700), () {
        Get.back();
      });
    });
    return false;
  }
}

