import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'recharge_logic.dart';

class RechargePage extends StatelessWidget {
  const RechargePage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(RechargeLogic());
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('俱乐部'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: const Center(
        child: Text(
          '俱乐部页面',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
} 