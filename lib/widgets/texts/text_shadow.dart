import 'package:roomcard/utils/common_extension/common_extension.dart';
import 'package:flutter/material.dart';

///默认的text阴影效果`FEE797` 色值
List<Shadow> textShadow() {
  return [
    Shadow(offset: Offset(1, 1.5), blurRadius: 0, color: '#FEE797'.hexToColor),
  ];
}
