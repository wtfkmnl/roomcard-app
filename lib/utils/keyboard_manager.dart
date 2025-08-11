import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KeyboardManager {
  ///隐藏键盘
  static void hidden() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  ///如果有键盘就隐藏
  static void hiddenHasKeyboard() {
    if (KeyboardManager.hasKeyboard()) {
      KeyboardManager.hidden();
    }
  }

  ///是否有键盘
  static bool hasKeyboard() {
    return MediaQuery.of(Get.context!).viewInsets.bottom > 0;
  }
}
