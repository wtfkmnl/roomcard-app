import 'package:flutter/material.dart';

///主题色定义的属性优先和FUI里的颜色描述一一对应。
///颜色命名和GUI色值的描述一致。
abstract class BaseTheme<T extends ThemeExtension<T>>
    extends ThemeExtension<T> {
  // -------------------- 文字颜色 --------------------

  /// 文字 - 1级
  Color get textColor1;  //白色

  /// 文字 - 2级
  Color get textColor2;  //c8

  /// 文字 - 3级
  Color get textColor3; //89

  /// 文字 - 4级
  Color get textColor4;  //5e

  /// 文字 - 4级
  Color get textColor5;  //c7

  /// 文字 - 按钮内
  Color get textColorInButton;

  // -------------------- 图标颜色 --------------------

  /// 图标 - 1级
  Color get iconColor1;

  /// 图标 - 2级
  Color get iconColor2;

  /// 图标 - 4级
  Color get iconColor4;

  /// 图标 - 5级
  Color get iconColor5;

  /// 图标 - 按钮内
  Color get iconColorInButton;

  // -------------------- 主题色 --------------------

  /// 主题色 - 1级
  Color get themeColor1;  //dcc277

  /// 主题色 - 2级
  Color get themeColor2;

  /// 主题色 - 3级
  Color get themeColor3;

  /// 主题色 - 5级
  Color get themeColor5;

  /// 主题色 - 6级
  Color get themeColor6;

  // -------------------- 背景色 --------------------

  /// 背景色 - 1级
  Color get backgroundColor1;

  /// 背景色 - 2级
  Color get backgroundColor2;

  /// 背景色 - 卡片内（60%透明）
  Color get backgroundColorCard;

  /// 背景色 - 导航栏
  Color get backgroundColorNav;

  /// 背景色 - 4级
  Color get backgroundColor4;

  // -------------------- 输入框 --------------------

  /// 输入框 - 填充1
  Color get fillColor1;

  // -------------------- 遮罩色 --------------------

  /// 遮罩色 - 全屏（80%透明）
  Color get overlayFull;

  // -------------------- 分割线 --------------------

  /// 分割线 - 1级
  Color get lineColor1;

  /// 分割线 - 2级
  Color get lineColor2;

  /// 分割线 - 3级（30%透明）
  Color get lineColor3;

  // -------------------- 辅助色 --------------------

  /// 辅助色 - 红色
  Color get assistRed;

  /// 辅助色 - 提醒
  Color get assistAlert;

  /// 辅助色 - 绿色
  Color get assistGreen;

  // -------------------- 其他FIG未标注颜色 --------------------
  Color get color15;
  Color get color24;
  Color get color31;
  Color get color5E;
  Color get goldGradientColor;
  Color get goldColor3;
}
