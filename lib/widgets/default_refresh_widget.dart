import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'drop_header_complete_widget.dart';

///默认刷新控件
///```
///DefaultRefreshWidget -> your widget
///```
class DefaultRefreshWidget extends StatelessWidget {
  final RefreshController controller;
  final Function? onRefresh;
  final Function? onLoading;
  final Widget? child;
  const DefaultRefreshWidget({
    super.key,
    required this.controller,
    this.onRefresh,
    this.onLoading,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: onRefresh != null,
      enablePullUp: onLoading != null,
      header: WaterDropHeader(complete: DropHeaderCompleteWidget()),
      footer: ClassicFooter(),
      onRefresh: () {
        onRefresh?.call();
      },
      onLoading: () {
        onLoading?.call();
      },
      controller: controller,
      child: child,
    );
  }
}
