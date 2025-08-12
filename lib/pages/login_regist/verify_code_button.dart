import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:roomcard/utils/commonUtils.dart';
import 'package:roomcard/utils/common_extension/common_extension.dart';
import 'package:roomcard/utils/my_font_family.dart';

class VerifyCodeButton extends StatefulWidget {
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final String? title;
  final bool? isEmailSms;
  final bool? enterBegin;
  final Color? startBackgroundColor;
  final Color? startTitleColor;
  final int? initSecond;
  final Function? countdownCallback;

  /// 获取短信验证码参数
  final Function? getSmsData;
  final Color? titleColor;
  const VerifyCodeButton({
    super.key,
    this.width,
    this.height,
    this.backgroundColor,
    this.title,
    this.titleColor,
    this.getSmsData,
    this.isEmailSms = false,
    this.enterBegin = false,
    this.startBackgroundColor,
    this.startTitleColor,
    this.initSecond,
    this.countdownCallback,
  });

  @override
  State<VerifyCodeButton> createState() => _VerifyCodeButtonState();
}

class _VerifyCodeButtonState extends State<VerifyCodeButton> {
  int _verifyCountDown = 60;
  Timer _timer = Timer(const Duration(days: 1), () {});

  bool isStart = false;
  bool isRepeat = false; //是否是重复获取

  @override
  void initState() {
    super.initState();
    setState(() {
      _verifyCountDown = widget.initSecond ?? 60;
    });
    if (widget.enterBegin == true) {
      onSySms(); // 组件加载时直接启动倒计时
      isStart = true;
    } else if (widget.initSecond != null && widget.initSecond! < 60) {
      isStart = true;
      startCountdownTimer();
    }
  }

  void dispose() {
    super.dispose();
    _timer.cancel();
    _verifyCountDown = 60;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: widget.height ?? 99.h,
      // width: widget.width ?? 350.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.w),
        color:
            isStart == true
                ? (widget.startBackgroundColor != null
                    ? widget.startBackgroundColor!
                    : widget.backgroundColor ?? Color(0xFF43BC9B).withAlpha(16))
                : widget.backgroundColor ?? Color(0xFF43BC9B).withAlpha(16),
      ),
      child: Text(
        textAlign: TextAlign.center,
        isStart
            ? "${_verifyCountDown}秒后可重发"
            : (isRepeat ? "重新获取" : widget.title ?? "获取验证码"),
        style: TextStyle(
          fontSize: 42.sp,
          color:
              widget.enterBegin == true
                  ? (isStart
                      ? widget.titleColor ?? Color(0xFF43BC9B)
                      : Color(0xFF43BC9B))
                  : ((isStart == true
                      ? (widget.startTitleColor != null
                          ? widget.startTitleColor!
                          : (widget.titleColor ?? Color(0xFF43BC9B)))
                      : isRepeat
                      ? (widget.titleColor ?? Color(0xFF43BC9B))
                      : (widget.titleColor ?? Color(0xFF43BC9B)))),
          fontFamily: MyFontFamily.miSans,
          fontWeight: FontWeight.w400,
        ),
      ).alignCenter().paddingOnly(right: isRepeat ? 45.w : 45.w, left: 45.w),
    ).gestureTap(
      onTap: () {
        printSome("-----isStart----------$isStart");

        if (isStart == true) return;
        onSySms();
      },
    );
  }

  Future onSySms() async {
    isRepeat = false;
    isStart = false;
    if (widget.getSmsData != null && !isStart) {
      var data = widget.getSmsData!();
      if (data == null) {
        setState(() {
          isStart = false;
          isRepeat = false;
        });
        return;
      }

      // ToastUtils.showLoading();
      if (widget.isEmailSms == false) {
        // var res = await UserApi.sySms(data: data);
        // ToastUtils.hideLoading();
        // if (res != null && res.code == BaseResCode.success.value) {
        //   //开始倒计时
        //   ToastUtils.showToast(msg: "验证码已发送");
        startCountdownTimer();
        // } else {
        //   isStart = false;
        //   isRepeat = false;
        // }
      } else {
        // var res = await UserApi.syEmailSms(data: data);
        // ToastUtils.hideLoading();
        // if (res != null && res.code == BaseResCode.success.value) {
        //   //开始倒计时
        //   ToastUtils.showToast(msg: "验证码已发送");
        startCountdownTimer();
        // } else {
        //   isStart = false;
        //   isRepeat = false;
        // }
      }

      // ToastUtils.hideLoading();
    }
  }

  void startCountdownTimer() {
    _timer.cancel();
    //一启动倒计时先刷新一下，倒计时要1秒后执行的
    setState(() {
      isStart = true;
      _verifyCountDown = widget.initSecond ?? 60;
      isRepeat = false;
    });
    const oneSec = Duration(seconds: 1);
    callback(timer) {
      if (mounted) {
        setState(() {
          printSome(_verifyCountDown);
          if (_verifyCountDown < 1) {
            isStart = false;
            _verifyCountDown = 60;
            _timer.cancel();
            isRepeat = true;
          } else {
            isStart = true;
            isRepeat = true;
            _verifyCountDown = _verifyCountDown - 1;
            widget.countdownCallback?.call(_verifyCountDown);
          }
        });
      }
    }

    _timer = Timer.periodic(oneSec, callback);
  }
}
