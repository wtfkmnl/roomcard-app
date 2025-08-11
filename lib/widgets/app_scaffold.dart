import 'package:roomcard/routes/app_router.dart';
import 'package:roomcard/theme/app_theme.dart';
import 'package:roomcard/utils/keyboard_manager.dart';
import 'package:roomcard/utils/logger.dart';
import 'package:roomcard/utils/num_px.dart';
import 'package:roomcard/utils/svg_util.dart';
import 'package:flutter/material.dart';

import '../manager/app_manager.dart';
import '../utils/gestureDetector_utils.dart';

class AppScaffold extends StatelessWidget {
  final Widget? title;
  final Widget? body;
  /// 右边控件  图片按钮/文字
  final Widget? rightNavWidget;
  final bool showRightNavWidget;

  // 左边控件，，
  final bool showLeftNavWidget;

  ///默认是背景色一级
  final Color? backgroundColor;
  final PreferredSizeWidget? customAppBar;
  final bool showAppBar;

  ///自定义返回事件
  final VoidCallback? onBack;
  const AppScaffold({
    super.key,
    this.title,
    this.body,
    this.backgroundColor,
    this.customAppBar,
    this.showAppBar = true,
    this.onBack,
    this.rightNavWidget,
    this.showRightNavWidget = false,
    this.showLeftNavWidget = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar
          ? customAppBar ??
                AppBar(
                  backgroundColor: AppTheme().current.backgroundColor2,
                  leading: showLeftNavWidget ?  AppScaffoldBackButton(onBack: onBack):null,
                  leadingWidth: 30.pxSp /*左间距 */ + 72.pxSp + 30.pxSp /*左间距 */,
                  centerTitle: true,
                  titleSpacing: 0,
                  surfaceTintColor: Colors.transparent,
                  title: DefaultTextStyle(
                    style: TextStyle(
                      color: AppTheme().current.textColor1 /* 文字-1级 */,
                      fontSize: 48.pxSp,
                      fontWeight: FontWeight.w600,
                      height: 1.38,
                    ),
                    child: title ?? Container(),
                  ),
                  actions: [
                    // showRightNavWidget  rightNavWidget 不能同时设置2个， rightNavWidget是自己自定义的控件
                    if(showRightNavWidget)
                      Padding(
                        padding:  EdgeInsets.only(right: 30.pxSp),
                        child: _kefuWidget(),
                      ),
                    if (rightNavWidget != null)
                      Padding(
                        padding:  EdgeInsets.only(right: 30.pxSp),
                        child: rightNavWidget!,
                      ),
                  ],
                )
          : null,
      backgroundColor: backgroundColor ?? AppTheme().current.backgroundColor1,
      body: body,
    );
  }

  Widget  _kefuWidget(){
    return GestureDetectorUtils.directGestureDetector(
          () {
      },
      Padding(
        padding: EdgeInsetsGeometry.all(4.pxw),
        child: Image.asset(
          "assets/images/setup/onlinekefu.png",
          height: 54.pxw,
          width: 56.pxw,
        ),
      ),
    );
  }



}

class AppScaffoldBackButton extends StatelessWidget {
  final void Function()? onBack;
  const AppScaffoldBackButton({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed:
          onBack ??
          () {
            // 判断当前页面是否有弹出键盘
            if (KeyboardManager.hasKeyboard()) {
              KeyboardManager.hidden(); // 收起键盘
            } else {
              AppRouter.back();
            }
          },
      icon: SvgUtil.asset(
        'assets/images/public/返回.svg',
        width: 72.pxw,
        height: 72.pxh,
      ),
    );
  }
}
