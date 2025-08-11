import 'package:roomcard/theme/app_theme.dart';
import 'package:roomcard/utils/num_px.dart';
import 'package:roomcard/utils/svg_util.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EmptyWidget extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  const EmptyWidget({super.key, this.text = '暂无数据', this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        SvgUtil.asset(
          'assets/images/public/暂无数据.svg',
          width: 300.pxw,
          height: 300.pxh,
        ),
        Gap(30.pxh),
        Text(
          text,
          style:
              textStyle ??
              TextStyle(
                color: AppTheme().current.textColor4,
                fontSize: 36.pxSp,
                height: 1.42,
              ),
        ),
      ],
    );
  }
}
