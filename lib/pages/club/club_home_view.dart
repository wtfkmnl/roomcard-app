import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:roomcard/utils/common_extension/common_extension.dart';
import 'package:roomcard/utils/num_px.dart';
import 'package:roomcard/theme/app_theme.dart';
import 'package:roomcard/widgets/common_app_bar.dart';
import '../../r.dart';
import '../../routes/app_router.dart';
import '../home/widgets/game_card_list_widget.dart';
import 'club_home_logic.dart';
import 'club_home_state.dart';

/// 俱乐部主页
class ClubHomePage extends StatefulWidget {
  const ClubHomePage({super.key});

  @override
  State<ClubHomePage> createState() => _ClubHomePageState();
}

class _ClubHomePageState extends State<ClubHomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ClubHomeLogic logic;
  late ClubHomeState state;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    
    // 初始化逻辑控制器和状态
    logic = Get.put(ClubHomeLogic());
    state = logic.state;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C2C36),
      appBar: CommonAppBar(
        title: '俱乐部主页',

      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Gap(20.pxw),

              // 俱乐部信息卡片
              _buildClubInfoCard().onTap(() {
                // 点击俱乐部信息卡片的处理逻辑
                Get.toNamed(AppRouter.clubDetail.path);
              }),
              Gap(16.pxh),
              // 俱乐部公告
              _buildClubAnnouncement(),
              Gap(16.pxh),
              // 导航标签
              _buildNavigationTabs(),
              Gap(16.pxh),
              // 游戏类型过滤器
              _buildGameTypeFilters(),
              Gap(24.pxh),
              // 游戏列表
              Container(
                height: 400.pxh, // 给一个固定高度或者使用其他方式
                child: GameCardListWidget(games: state.gameList),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 构建应用栏
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFF1C2C36),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Get.back(),
      ),
      title: const Text(
        '阿斯顿',
        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.chat_bubble_outline, color: Colors.white),
          onPressed: () {
            // 处理聊天按钮点击
          },
        ),
        IconButton(
          icon: const Icon(Icons.share, color: Colors.white),
          onPressed: () {
            // 处理分享按钮点击
          },
        ),
      ],
    );
  }

  /// 构建俱乐部信息卡片
  Widget _buildClubInfoCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.pxw),
      padding: EdgeInsets.all(16.pxw),
      decoration: BoxDecoration(
        color: const Color(0xFF283D49),
        borderRadius: BorderRadius.circular(14.pxw),
        border: Border.all(color: const Color(0xFF37505E), width: 1.pxw),
      ),
      child: Row(
        children: [
          // 左侧头像
          Container(
            width: 60.pxw,
            height: 60.pxh,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40.pxw),
              border: Border.all(color: const Color(0xFFF9C678), width: 2.pxw),
              image: const DecorationImage(image: AssetImage('assets/images/club/img_club_head_0.png'), fit: BoxFit.cover),
            ),
          ),
          Gap(16.pxw),
          // 右侧信息
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '阿斯顿',
                  style: TextStyle(color: Colors.white, fontSize: 18.pxSp, fontWeight: FontWeight.w600),
                ),
                Gap(8.pxh),
                Row(
                  children: [
                    Text(
                      '67652510',
                      style: TextStyle(color: AppTheme().current.textColor3, fontSize: 14.pxSp),
                    ),
                    Gap(16.pxw),
                    Icon(Icons.person, color: AppTheme().current.textColor3, size: 16.pxw),
                    Gap(4.pxw),
                    Text(
                      '1/1000',
                      style: TextStyle(color: AppTheme().current.textColor3, fontSize: 14.pxSp),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // 右侧箭头
          Icon(Icons.arrow_forward_ios, color: AppTheme().current.textColor3, size: 16.pxw),
        ],
      ),
    );
  }

  /// 构建俱乐部公告
  Widget _buildClubAnnouncement() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.pxw),
      decoration: BoxDecoration(color: Color(0x26FF9820), borderRadius: BorderRadius.circular(6.pxw)),
      child: Row(
        children: [
          Container(
            width: 32.pxw,
            height: 32.pxh,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              image: const DecorationImage(image: AssetImage('assets/images/club/publish_icon_bg.png'), fit: BoxFit.cover),
            ),

            child: Image.asset('assets/images/club/publish_icon.png', width: 20.pxw, height: 20.pxh),
          ),

          Gap(12.pxw),
          Text(
            '俱乐部公告 111',
            style: TextStyle(color: Colors.white, fontSize: 14.pxSp, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  /// 构建导航标签
  Widget _buildNavigationTabs() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.pxw),
      padding: EdgeInsets.all(5.pxw),
      decoration: BoxDecoration(
        color: const Color(0xFF1E323D),
        borderRadius: BorderRadius.circular(40.pxw),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.pxw), // 圆角裁剪
        child: TabBar(
          controller: _tabController,
          dividerColor: Colors.transparent,
          indicator: BoxDecoration(
            color: const Color(0xFF2F4554),
            borderRadius: BorderRadius.circular(20.pxw),
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white,
          labelStyle: TextStyle(fontSize: 14.pxSp, fontWeight: FontWeight.w600),
          unselectedLabelStyle: TextStyle(fontSize: 14.pxSp, fontWeight: FontWeight.w500),
          tabs: const [
            Tab(text: '牌局 (0)'),
            Tab(text: '战绩'),
            Tab(text: '聊天'),
          ],
        ),
      ),
    );
  }

  /// 构建游戏类型过滤器
  Widget _buildGameTypeFilters() {
    final gameTypes = ['全部游戏', '经典德州', '奥马哈', '德州短牌'];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.pxw),
      child: Row(
        children: gameTypes.asMap().entries.map((entry) {
          final index = entry.key;
          final gameType = entry.value;
          final isSelected = index == state.selectedGameTypeIndex.value;

          return Expanded(
            child: GestureDetector(
              onTap: () {
                logic.selectGameType(index);
              },
              child: Container(
                alignment: Alignment.center,
                width: 78.pxw,
                height: 40.pxw,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/home/btn_bg_1.png'),
                    fit: BoxFit.contain,
                  ),
                ),
                child: Text(
                  gameType,
                  style: TextStyle(color: isSelected ? const Color(0xFFF9C678) : Colors.white, fontSize: 12.pxSp, fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }}