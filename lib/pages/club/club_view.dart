import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'club_logic.dart';

class ClubPage extends StatelessWidget {
  const ClubPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(ClubLogic());
    
    return Scaffold(

      body: const Center(
        child: Text(
          '俱乐部页面',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
} 