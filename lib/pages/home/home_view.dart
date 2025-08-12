import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:roomcard/utils/num_px.dart';
import 'home_logic.dart';
import 'widgets/widgets.dart';
import '../../widgets/app_drawer.dart';

/// 首页主页面
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// 首页主页面State
class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
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
      drawer: Obx(() => AppDrawer(
        selectedGameType: state.selectedGameType.value,
        onGameTypeSelected: logic.selectGameType,
      )),
      body: SafeArea(
        child: Column(
          children: [
            // 顶部导航栏
            HomeTopBar(logic: logic),

            // 创建/加入牌局区域
            GameActionSection(
              leftTitle: '创建牌局',
              rightTitle: '加入牌局',
              leftOnTap: () => logic.selectGameAction(0),
              rightOnTap: () => logic.selectGameAction(1),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16.pxh, horizontal: 18.pxw),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/home/Home_content_bg.png'),
                    fit: BoxFit.contain,
                    alignment: Alignment.topCenter,
                  ),
                ),
                child: Column(
                  children: [
                    // 我的牌局区域
                    MyGamesSection(logic: logic),
                    Gap(16.pxh),
                    // 游戏模式选择
                    GameModeSection(logic: logic),
                    Gap(16.pxh),
                    // 游戏大小选择
                    GameSizeSection(logic: logic),
                    Gap(16.pxh),
                    // 主要内容区域（游戏卡片列表）
                    Expanded(
                      child: GameCardListWidget(games: state.gameList),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 