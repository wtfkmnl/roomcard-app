import 'package:flutter/material.dart';

/// 字体主题扩展
class FontThemeExtension extends ThemeExtension<FontThemeExtension> {
  final String defaultFontFamily;
  final String regularFontFamily;
  final String numberFontFamily;
  final String webFontFamily;

  const FontThemeExtension({
    required this.defaultFontFamily,
    required this.regularFontFamily,
    required this.numberFontFamily,
    required this.webFontFamily,
  });

  /// 创建默认字体主题
  factory FontThemeExtension.defaultTheme() {
    return const FontThemeExtension(
      defaultFontFamily: 'PingFangSC',
      regularFontFamily: 'regular',
      numberFontFamily: 'numberfont',
      webFontFamily: 'webfont',
    );
  }

  /// 获取默认文本样式
  TextStyle get defaultTextStyle => TextStyle(
    fontFamily: defaultFontFamily,
    fontWeight: FontWeight.w400,
    height: 1.36,
  );

  /// 获取常规文本样式
  TextStyle get regularTextStyle => TextStyle(
    fontFamily: regularFontFamily,
    fontWeight: FontWeight.w400,
    height: 1.36,
  );

  /// 获取数字字体样式
  TextStyle get numberTextStyle => TextStyle(
    fontFamily: numberFontFamily,
    fontWeight: FontWeight.w400,
    height: 1.36,
  );

  /// 获取网页字体样式
  TextStyle get webTextStyle => TextStyle(
    fontFamily: webFontFamily,
    fontWeight: FontWeight.w400,
    height: 1.36,
  );

  @override
  FontThemeExtension copyWith({
    String? defaultFontFamily,
    String? regularFontFamily,
    String? numberFontFamily,
    String? webFontFamily,
  }) {
    return FontThemeExtension(
      defaultFontFamily: defaultFontFamily ?? this.defaultFontFamily,
      regularFontFamily: regularFontFamily ?? this.regularFontFamily,
      numberFontFamily: numberFontFamily ?? this.numberFontFamily,
      webFontFamily: webFontFamily ?? this.webFontFamily,
    );
  }

  @override
  FontThemeExtension lerp(ThemeExtension<FontThemeExtension>? other, double t) {
    if (other is! FontThemeExtension) {
      return this;
    }
    return FontThemeExtension(
      defaultFontFamily: defaultFontFamily,
      regularFontFamily: regularFontFamily,
      numberFontFamily: numberFontFamily,
      webFontFamily: webFontFamily,
    );
  }
} 