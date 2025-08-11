import 'package:roomcard/manager/app_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (AppManager().isLogin == false) {
      //是否登录的判断条件
      // showLoginRegisterView(index: 0); // 未登录时重定向到登录页 GetX只支持路由
    }
    return null; // 继续正常跳转
  }
}
