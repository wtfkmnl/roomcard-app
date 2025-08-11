import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'welcome_logic.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final logic = Get.find<WelcomeLogic>();
  final state = Get.find<WelcomeLogic>().state;
  @override
  Widget build(BuildContext context) {
    Widget bgView = Container(
      color: Colors.white,
      child: Image.asset('assets/images/launch/startBg.png', fit: BoxFit.fill),
    );
    if (state.launchBgFile != null) {
      bgView = Image.file(state.launchBgFile!, fit: BoxFit.fill);
    }
    return Obx(() {
      return Stack(
        children: [
          Positioned.fill(child: bgView),
          Positioned(
            width: Get.width,
            bottom: 20,
            child: Center(
              child: Text(
                state.errorStr.value,
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
            ),
          ),
          if (state.errorStr.isEmpty)
            Positioned(
              width: 60,
              height: 26,
              top: MediaQuery.of(context).padding.top,
              right: 20,
              child: Obx(() {
                if (state.downCount.value <= 0 || state.downCount > 3) {
                  return Container();
                }
                return GestureDetector(
                  onTap: () {
                    logic.goToMainPage();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '跳过:${state.downCount.value}s',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ),
                );
              }),
            ),
        ],
      );
    });
  }

  @override
  void dispose() {
    if (Get.isRegistered<WelcomeLogic>()) {
      // 安全检查
      Get.delete<WelcomeLogic>();
    }
    super.dispose();
  }
}
