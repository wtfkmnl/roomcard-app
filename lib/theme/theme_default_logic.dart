
import 'package:flutter/material.dart';

import 'base_theme.dart';

mixin ThemeDefaultLogic<T extends ThemeExtension<T>> on BaseTheme<T> {
  @override
  ThemeExtension<T> copyWith() {
    return this;
  }

  @override
  ThemeExtension<T> lerp(covariant ThemeExtension<T>? other, double t) {
    return this;
  }
}