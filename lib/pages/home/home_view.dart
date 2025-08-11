import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_logic.dart';

/// 首页主页面
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// 首页主页面State
class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  // 业务逻辑控制器
  final logic = Get.put(HomeLogic());
  // 页面状态
  final state = Get.find<HomeLogic>().state;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Container(
        child: const Center(
          child: Text(
            '首页内容',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
