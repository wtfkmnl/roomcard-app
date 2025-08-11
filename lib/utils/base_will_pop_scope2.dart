import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseWillPopScope2 extends StatelessWidget {
  // 方法返回true 执行返回， fasle不返回
  late Function func;

  // ui
  late Widget child;

  BaseWillPopScope2({super.key, required this.func, required this.child});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? child
    // GestureDetector(
    //         onPanUpdate: (details) async {
    //           if (details.delta.dx > 10) {
    //             if (await func()){
    //               Get.back();
    //             }
    //           }
    //         },
    //         child: WillPopScope(
    //           onWillPop: () async {
    //             return false;
    //           },
    //           child: child,
    //         ))
        : WillPopScope(
            child: child,
            onWillPop: () async {
              return await func();
            });
  }
}
