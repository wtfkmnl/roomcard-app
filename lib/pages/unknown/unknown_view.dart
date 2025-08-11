import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'unknown_logic.dart';

class UnknownPage extends StatefulWidget {
  const UnknownPage({super.key});

  @override
  State<UnknownPage> createState() => _UnknownPageState();
}

class _UnknownPageState extends State<UnknownPage> {
  final logic = Get.find<UnknownLogic>();
  final state = Get.find<UnknownLogic>().state;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '404,未知页面!',
        style: TextStyle(color: Colors.red.shade500, fontSize: 20),
      ),
    );
  }

  @override
  void dispose() {
    if (Get.isRegistered<UnknownLogic>()) {
      // 安全检查
      Get.delete<UnknownLogic>();
    }
    super.dispose();
  }
}
