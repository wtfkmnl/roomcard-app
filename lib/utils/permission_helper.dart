import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  /// 检测是否有权限
  /// [permissionList] 权限申请列表
  /// [onSuccess] 全部成功
  /// [onFailed] 有一个失败
  /// [goSetting] 前往设置 插件虽然提供了一个跳转设置的方法不过也可以自定义
  static checkPermission({
    required List<Permission> permissionList,
    required VoidCallback onSuccess,
    VoidCallback? onOtherCase,
    required String errorMsg,
  }) async {
    ///一个新待申请权限列表
    List<Permission> newPermissionList = [];

    ///遍历当前权限申请列表
    for (Permission permission in permissionList) {
      PermissionStatus status = await permission.status;

      ///如果不是允许状态就添加到新的申请列表中
      if (!status.isGranted) {
        newPermissionList.add(permission);
      }
    }

    ///如果需要重新申请的列表不是空的
    if (newPermissionList.isNotEmpty) {
      PermissionStatus permissionStatus = await requestPermission(
        newPermissionList,
      );

      switch (permissionStatus) {
        ///拒绝状态
        case PermissionStatus.denied:
          // permissionTips(errorMsg) ;
          onOtherCase?.call();
          break;

        ///允许状态
        case PermissionStatus.granted:
          onSuccess();
          break;

        /// 永久拒绝  活动限制
        case PermissionStatus.restricted:
        case PermissionStatus.limited:
        case PermissionStatus.permanentlyDenied:
        case PermissionStatus.provisional:
          // permissionTips(errorMsg);
          onOtherCase?.call();
          break;
      }
    } else {
      onSuccess();
    }
  }

  /// 获取新列表中的权限 如果有一项不合格就返回false
  static requestPermission(List<Permission> permissionList) async {
    Map<Permission, PermissionStatus> statuses = await permissionList.request();
    PermissionStatus currentPermissionStatus = PermissionStatus.granted;
    statuses.forEach((key, value) {
      if (!value.isGranted) {
        currentPermissionStatus = value;
        return;
      }
    });
    return currentPermissionStatus;
  }

  static permissionTips(String errorMsg, BuildContext context) {
    Widget contentWidget = SizedBox(
      width: 860.w,
      height: 500.h,
      child: Column(
        children: [
          SizedBox(height: 83.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset(
              //   "assets/img/sale21.png",
              //   width: 54.w,
              //   height: 54.h,
              // ),
              SizedBox(width: 23.w),
              Text(
                "missingPermissions".tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 54.sp,
                  color: Color(0xFF000000),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            errorMsg,
            style: TextStyle(fontSize: 42.sp, color: Color(0xFF999999)),
          ),
          const Spacer(),
          SizedBox(
            height: 120.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(420.w, 120.h)),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "cancel".tr,
                    style: TextStyle(
                      fontSize: 45.sp,
                      color: Color(0xFF676767),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(420.w, 120.h)),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    openAppSettings();
                  },
                  child: Text(
                    "setting".tr,
                    style: TextStyle(
                      fontSize: 45.sp,
                      color: Color(0xFF676767),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    showCupertinoDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          buttonPadding: EdgeInsets.zero,
          alignment: Alignment.center,
          titlePadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          elevation: 0.0,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.w)),
          ),
          content: contentWidget,
        );
      },
    );
  }
}
