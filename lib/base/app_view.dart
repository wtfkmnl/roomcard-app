import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppView<T> extends GetView<T> {
  T get logic => controller;

  AppView({super.key}) {
    debugPrint('Instance view "${runtimeType.toString()}"');
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
