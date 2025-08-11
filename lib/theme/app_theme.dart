import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';

import 'base_theme.dart';
import 'black_theme.dart';

enum AppThemeType { black }

class AppTheme {
  final appThemeID = 'AppThemeID';
  static final AppTheme _manager = AppTheme._();
  AppTheme._();

  final themes = <AppThemeType, BaseTheme>{AppThemeType.black: BlackTheme()};

  factory AppTheme() {
    return _manager;
  }
  BaseTheme get current {
    final themes = Get.theme.extensions.values;
    if (themes.isNotEmpty) {
      if (themes.first case BaseTheme theme) {
        return theme;
      }
    }
    return BlackTheme();
  }

  void change(AppThemeType type) {
    final theme = themes[type] ?? BlackTheme();
    Get.changeTheme(Get.theme.copyWith(extensions: [theme]));
    500.milliseconds.delay().then((_) {
      Get.forceAppUpdate();
    });
  }
}
