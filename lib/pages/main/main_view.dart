import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'main_logic.dart';
import 'widgets/custom_bottom_nav_bar.dart';
import 'widgets/app_drawer.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final logic = Get.find<MainLogic>();
  final state = Get.find<MainLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      drawerScrimColor: Colors.transparent,
      drawer: AppDrawer(
        onSelectTab: logic.onTapBottom,
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: state.tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [...state.navItems.map((e) => e.page)],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Obx(() {
        return CustomBottomNavBar(
          currentIndex: state.navIndex.value,
          items: state.navItems,
          onTap: logic.onTapBottom,
        );
      }),
    );
  }

  @override
  void dispose() {
    if (Get.isRegistered<MainLogic>()) {
      Get.delete<MainLogic>();
    }
    super.dispose();
  }
}
