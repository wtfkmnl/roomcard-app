import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KeyboardHelper {
  ///关闭键盘
  static void close([BuildContext? context]) {
    // if (context != null) {
    //   FocusScope.of(context).unfocus();
    // } else {
    //   SystemChannels.textInput.invokeMethod('TextInput.hide');
    // }

    FocusScopeNode currentFocus;
    if (context != null) {
      currentFocus = FocusScope.of(context);
    } else {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      return;
    }

    /// 键盘是否是弹起状态
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      if (FocusManager.instance.primaryFocus != null) {
        FocusManager.instance.primaryFocus!.unfocus();
      }
    }
  }
}
