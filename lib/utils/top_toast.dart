import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:roomcard/r.dart';
import 'package:roomcard/utils/image_extension.dart';

class TopToast {
  static final TopToast _instance = TopToast._internal();
  factory TopToast() => _instance;
  TopToast._internal();

  OverlayEntry? _overlayEntry;
  bool _isShowing = false;

  void show({
    required String message,
    String? icon,
    Duration duration = const Duration(seconds: 2),
  }) {
    if (_isShowing) {
      dismiss();
    }

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: MediaQuery.of(context).padding.top - 10.h,
          left: 16,
          right: 16,
          child: Material(
            color: Colors.transparent,
            child: _buildToastContent(message, icon: icon),
          ),
        );
      },
    );

    Overlay.of(Get.context!).insert(_overlayEntry!);
    _isShowing = true;

    Future.delayed(duration, () {
      dismiss();
    });
  }

  void dismiss() {
    if (_isShowing && _overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
      _isShowing = false;
    }
  }

  Widget _buildToastContent(String message, {String? icon}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14.h),
      decoration: BoxDecoration(
        color: const Color(0xFF0C2A38),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          imageView(icon ?? R.assetsImagesToastErrorIcon, width: 16.w),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: 14.w,
            height: 14.w,
            child: CircularProgressIndicator(
              strokeWidth: 2.w,
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF24EE89)),
            ),
          ).marginOnly(top: 2.h),
        ],
      ),
    );
  }
}
