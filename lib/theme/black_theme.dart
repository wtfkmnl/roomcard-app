import 'dart:ui';

import 'package:roomcard/utils/common_extension/common_extension.dart';
import 'package:flutter/material.dart';

import 'theme_default_logic.dart';
import 'base_theme.dart';

class BlackTheme extends BaseTheme<BlackTheme> with ThemeDefaultLogic {
  @override
  Color get textColor1 => '#FFFFFF'.hexToColor; // 主要文字颜色 - 白色

  @override
  Color get textColor2 => '#FFFFFF'.hexToColor; // 次要文字颜色 - 白色

  @override
  Color get textColor3 => '#FFFFFF'.hexToColor; // 三级文字颜色 - 白色

  @override
  Color get textColor4 => '#FFFFFF'.hexToColor; // 四级文字颜色 - 白色

  @override
  Color get textColor5 => '#FFFFFF'.hexToColor; // 五级文字颜色 - 白色

  @override
  Color get textColorInButton => '#151515'.hexToColor;

  // 图标颜色

  @override
  Color get iconColor1 => '#FFFFFF'.hexToColor; // 主要图标颜色 - 白色

  @override
  Color get iconColor2 => '#FFFFFF'.hexToColor; // 次要图标颜色 - 白色

  @override
  Color get iconColor4 => '#FFFFFF'.hexToColor; // 四级图标颜色 - 白色

  @override
  Color get iconColor5 => '#FFFFFF'.hexToColor; // 五级图标颜色 - 白色

  @override
  Color get iconColorInButton => '#151515'.hexToColor;

  // 主题色

  @override
  Color get themeColor1 => '#DCC277'.hexToColor;

  @override
  Color get themeColor2 => '#FADB7E'.hexToColor;

  @override
  Color get themeColor3 => '#FFD250'.hexToColor;

  @override
  Color get themeColor5 => '#8E8673'.hexToColor;

  @override
  Color get themeColor6 => '#29261F'.hexToColor;

  // 背景色

  @override
  Color get backgroundColor1 => '#151515'.hexToColor;

  @override
  Color get backgroundColor2 => '#1F1F1F'.hexToColor;

  @override
  Color get backgroundColorCard => '#151515'.hexToColor.withValues(alpha: 0.6);

  @override
  Color get backgroundColorNav => '#242424'.hexToColor;

  @override
  Color get backgroundColor4 => '#2C2C2C'.hexToColor;

  // 输入框

  @override
  Color get fillColor1 => '#0C0C0C'.hexToColor;

  // 遮罩色

  @override
  Color get overlayFull => '#000000'.hexToColor.withValues(alpha: 0.8);

  // 分割线

  @override
  Color get lineColor1 => '#0C0C0C'.hexToColor;

  @override
  Color get lineColor2 => '#454545'.hexToColor;

  @override
  Color get lineColor3 => '#454545'.hexToColor.withValues(alpha: 0.3);

  // 辅助色

  @override
  Color get assistRed => '#FF6868'.hexToColor;

  @override
  Color get assistAlert => '#DB1B24'.hexToColor;

  @override
  Color get assistGreen => '#68FF7E'.hexToColor;

  // -------------------- 其他FIG未标注颜色 --------------------
  @override
  Color get color15 => '#151515'.hexToColor;

  @override
  Color get goldColor3 => '#F7C038'.hexToColor;
  @override
  Color get goldGradientColor => '#F9DC81'.hexToColor;
  @override
  Color get color5E => '#5E5E5E'.hexToColor;
  @override
  Color get color31 => '#313131'.hexToColor;
  @override
  Color get color24 => '#242424'.hexToColor;
}
