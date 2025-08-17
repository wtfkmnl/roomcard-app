import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:roomcard/utils/num_px.dart';
import 'package:roomcard/theme/app_theme.dart';
import 'empty_state_widget.dart';

/// 游戏卡片数据模型
class GameCardData {
  final String title;
  final String subtitle;
  final String gameType;
  final double prizeMoney;
  final double entryFee;
  final int participants;
  final String gameMode;
  final String timeInfo;
  final int status; // 1: 正常状态, 2: 状态2
  final int currentPlayers;
  final int maxPlayers;

  GameCardData({required this.title, required this.subtitle, required this.gameType, required this.prizeMoney, required this.entryFee, required this.participants, required this.gameMode, required this.timeInfo, required this.status, required this.currentPlayers, required this.maxPlayers});
}

/// 游戏卡片列表组件
class GameCardListWidget extends StatelessWidget {
  final List<GameCardData> games;

  const GameCardListWidget({super.key, required this.games});

  @override
  Widget build(BuildContext context) {
    if (games.isEmpty) {
      return const EmptyStateWidget();
    }

    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: games.length,
        itemBuilder: (context, index) {
          return _buildGameCard(games[index]);
        },
      ),
    );
  }

  /// 构建游戏卡片
  Widget _buildGameCard(GameCardData game) {
    final cardHeight = game.status == 2 ? 108.pxh : 168.pxh;
    return Container(
      width: 343.pxw,
      height: cardHeight,
      margin: EdgeInsets.only(bottom: 12.pxh),
      child: _buildCardContent(game),
    );
  }

  /// 构建卡片内容
  Widget _buildCardContent(GameCardData game) {
    if (game.status == 2) {
      return _buildStatus2Content(game);
    } else {
      return _buildNormalContent(game);
    }
  }

  /// 构建正常状态内容
  Widget _buildNormalContent(GameCardData game) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/home/Home_content_list_bg.png'), fit: BoxFit.contain),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 6.pxh),
          // 顶部标题行
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 22.pxw),
              Text(
                game.gameType,
                style: TextStyle(color: AppTheme().current.textColor4, fontSize: 14.pxSp, fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              // 主标题
              Text(
                game.title,
                style: TextStyle(color: Colors.white, fontSize: 16.pxSp, fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              Container(
                width: 50.pxw,
                height: 16.pxh,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: Color(0xFFDFA75B), borderRadius: BorderRadius.all(Radius.circular(20.pxh))),
                child: Text(
                  '实物赛',
                  style: TextStyle(color: Colors.white, fontSize: 10.pxSp, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(width: 10.pxw),
            ],
          ),

          SizedBox(height: 8.pxh),

          Container(
            padding: EdgeInsets.only(top: 20.pxh, left: 11.pxw, right: 11.pxw),
            width: 335.pxw,
            height: 130.pxh,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/images/home/Home_content_list_bg1.png'), fit: BoxFit.cover),
            ),
            child: Column(
              children: [
                // 游戏信息行
                Row(
                  children: [
                    // 左侧游戏图标
                    Container(width: 74.pxw, height: 56.pxh, child: Image.asset('assets/images/game/game1.png')),

                    SizedBox(width: 12.pxw),

                    // 中间游戏信息
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoRow('奖金', '${game.prizeMoney}'),
                          SizedBox(width: 20.pxh),
                          _buildInfoRow('报名费', '${game.entryFee}'),
                          SizedBox(width: 20.pxh),
                          _buildInfoRow('报名人数', '${game.participants}'),
                        ],
                      ),
                    ),
                  ],
                ),
                Gap(2.pxh),
                // 底部信息行
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Row(
                      children: [
                        Container(width: 14.pxw, height: 14.pxh, child: Image.asset('assets/images/home/icon_card_logo.png')),
                        SizedBox(width: 4.pxw),
                        Text(
                          game.gameMode,
                          style: TextStyle(color: AppTheme().current.textColor4, fontSize: 12.pxSp, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '即将开赛',
                          style: TextStyle(color: AppTheme().current.textColor4, fontSize: 12.pxSp, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 2.pxh),
                        Text(
                          '48分钟',
                          style: TextStyle(color: Color(0xFFF9C678), fontSize: 12.pxSp, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ).paddingOnly(top: 18.pxh),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 构建状态2内容
  Widget _buildStatus2Content(GameCardData game) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/home/game_card_bg.png'), fit: BoxFit.contain),
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 77.pxh,
            child: Row(
              children: [
                SizedBox(width: 10.pxw),
                // 左侧游戏图标
                Container(width: 74.pxw, height: 56.pxh, child: Image.asset('assets/images/game/game1.png')),

                SizedBox(width: 12.pxw),

                // 中间游戏信息
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        game.subtitle,
                        style: TextStyle(color: Colors.white, fontSize: 14.pxSp, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 4.pxh),
                      Text(
                        '15min/30min',
                        style: TextStyle(color: AppTheme().current.textColor4, fontSize: 12.pxSp, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),

                // 右侧玩家信息
                Container(
                  width: 75.pxh,
                  height: 35.pxw,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 30.pxw),
                  decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/home/room_number.png"))),
                  child: Text(
                    '${game.currentPlayers}/${game.maxPlayers}',
                    style: TextStyle(color: AppTheme().current.textColor1, fontSize: 14.pxSp, fontWeight: FontWeight.w600),
                  ),
                ),

                SizedBox(width: 10.pxw),
              ],
            ),
          ), // 底部信息
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 10.pxw),
                Container(width: 14.pxw, height: 14.pxh, child: Image.asset('assets/images/home/icon_card_logo.png')),
                SizedBox(width: 4.pxw),
                Text(
                  game.gameMode,
                  style: TextStyle(color: AppTheme().current.textColor4, fontSize: 12.pxSp, fontWeight: FontWeight.w500),
                ),
                Spacer(),
                Text(
                  game.timeInfo,
                  style: TextStyle(color: AppTheme().current.textColor4, fontSize: 12.pxSp, fontWeight: FontWeight.w500),
                ),
                SizedBox(width: 10.pxw),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 构建信息行
  Widget _buildInfoRow(String label, String value) {
    return Column(
      children: [
        Text(
          '$label',
          style: TextStyle(color: AppTheme().current.textColor4, fontSize: 10.pxSp, fontWeight: FontWeight.w400),
        ),
        Row(
          children: [
            Image.asset('assets/images/game/money_icon.png', width: 15.pxw, height: 13.pxh),
            Gap(4.pxh),
            Text(
              '$value',
              style: TextStyle(color: AppTheme().current.textColor1, fontSize: 14.pxSp, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ],
    );
  }
}
