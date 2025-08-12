import 'package:flutter/material.dart';

/// 详情文字的配置看main里的getx theme里的字体配置默认值
/// 目前暂时全局默认 行高1.36，权重w400。
class AppFontStyle {
  ///默认字体 - PingFangSC
  static const defaultFont = 'PingFangSC';
  
  ///常规字体
  static const regular = 'regular';

  ///适用于金额
  static const webfont = 'webfont';
  
  ///数字字体
  static const numberfont = 'numberfont';
  
  /// 获取默认文本样式
  static TextStyle get defaultStyle => TextStyle(
    fontFamily: defaultFont,
    fontWeight: FontWeight.w400,
    height: 1.36,
  );
  
  /// 获取常规文本样式
  static TextStyle get regularStyle => TextStyle(
    fontFamily: regular,
    fontWeight: FontWeight.w400,
    height: 1.36,
  );
  
  /// 获取数字字体样式
  static TextStyle get numberStyle => TextStyle(
    fontFamily: numberfont,
    fontWeight: FontWeight.w400,
    height: 1.36,
  );
  
  /// 获取网页字体样式
  static TextStyle get webStyle => TextStyle(
    fontFamily: webfont,
    fontWeight: FontWeight.w400,
    height: 1.36,
  );
}
