import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'my_logic.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(MyLogic());
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        child: const Center(
          child: Text(
            '我的页面内容',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
