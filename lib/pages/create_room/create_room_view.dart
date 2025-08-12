import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roomcard/theme/app_theme.dart';
import 'package:roomcard/utils/num_px.dart';
import 'create_room_logic.dart';
import 'create_room_state.dart';

class CreateRoomPage extends StatelessWidget {
  const CreateRoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<CreateRoomLogic>();
    final state = Get.find<CreateRoomLogic>().state;

    return Scaffold(
      backgroundColor: const Color(0xFF0A1C26),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          '创建朋友局',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.pxw),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 游戏模式选择
            _buildGameModeSection(logic, state),
            SizedBox(height: 24.pxh),
            
            // 房间名称/ID
            _buildRoomNameSection(),
            SizedBox(height: 24.pxh),
            
            // 小盲/大盲和带入记分牌
            _buildBlindsAndScoreSection(logic, state),
            SizedBox(height: 24.pxh),
            
            // 人满即开
            _buildPlayersToStartSection(logic, state),
            SizedBox(height: 24.pxh),
            
            // 前注设置
            _buildAnteSection(logic, state),
            SizedBox(height: 24.pxh),
            
            // 牌局时长
            _buildGameDurationSection(logic, state),
            SizedBox(height: 24.pxh),
            
            // 买入设置
            _buildBuyInSection(logic, state),
            SizedBox(height: 32.pxh),
            
            // 创建按钮
            _buildCreateButton(logic),
          ],
        ),
      ),
    );
  }

  Widget _buildGameModeSection(CreateRoomLogic logic, CreateRoomState state) {
    final gameModes = ['经典德州', '奥马哈', '德州短牌', 'AOF'];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '游戏模式',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.pxSp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.pxh),
        Row(
          children: gameModes.asMap().entries.map((entry) {
            final index = entry.key;
            final mode = entry.value;
            return Expanded(
              child: Obx(() => GestureDetector(
                onTap: () => logic.selectGameMode(index),
                child: Container(
                  margin: EdgeInsets.only(right: index < gameModes.length - 1 ? 8.pxw : 0),
                  padding: EdgeInsets.symmetric(vertical: 12.pxh, horizontal: 8.pxw),
                  decoration: BoxDecoration(
                    color: state.selectedGameMode.value == index
                        ? const Color(0xFFFF6B35)
                        : const Color(0xFF1C2C36),
                    borderRadius: BorderRadius.circular(20.pxw),
                  ),
                  child: Text(
                    mode,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.pxSp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              )),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildRoomNameSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.pxw),
      decoration: BoxDecoration(
        color: const Color(0xFF1C2C36),
        borderRadius: BorderRadius.circular(8.pxw),
      ),
      child: Text(
        'DPNO2OAH的经典德州牌局',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.pxSp,
        ),
      ),
    );
  }

  Widget _buildBlindsAndScoreSection(CreateRoomLogic logic, CreateRoomState state) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '小盲/大盲',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.pxSp,
                ),
              ),
              SizedBox(height: 8.pxh),
              Text(
                '1 / 2',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.pxSp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.pxh),
              _buildSlider(
                value: state.blindsIndex.value.toDouble(),
                min: 0,
                max: 4,
                divisions: 4,
                onChanged: (value) => logic.setBlinds(value.toInt()),
              ),
            ],
          ),
        ),
        SizedBox(width: 24.pxw),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '带入记分牌',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.pxSp,
                ),
              ),
              SizedBox(height: 8.pxh),
              Text(
                '100',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.pxSp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.pxh),
              _buildSlider(
                value: state.bringInScoreIndex.value.toDouble(),
                min: 0,
                max: 4,
                divisions: 4,
                onChanged: (value) => logic.setBringInScore(value.toInt()),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPlayersToStartSection(CreateRoomLogic logic, CreateRoomState state) {
    final players = ['2', '3', '4', '5', '6'];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '人满即开',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.pxSp,
          ),
        ),
        SizedBox(height: 12.pxh),
        _buildSlider(
          value: state.playersToStartIndex.value.toDouble(),
          min: 0,
          max: 4,
          divisions: 4,
          onChanged: (value) => logic.setPlayersToStart(value.toInt()),
          labels: players,
        ),
      ],
    );
  }

  Widget _buildAnteSection(CreateRoomLogic logic, CreateRoomState state) {
    final antes = ['0', '1', '2', '3', '4', '6', '8', '10'];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '前注设置',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.pxSp,
          ),
        ),
        SizedBox(height: 12.pxh),
        _buildSlider(
          value: state.anteIndex.value.toDouble(),
          min: 0,
          max: 7,
          divisions: 7,
          onChanged: (value) => logic.setAnte(value.toInt()),
          labels: antes,
        ),
      ],
    );
  }

  Widget _buildGameDurationSection(CreateRoomLogic logic, CreateRoomState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '牌局时长',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.pxSp,
              ),
            ),
            Text(
              '${state.gameDuration.value.toStringAsFixed(1)}小时',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.pxSp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.pxh),
        _buildSlider(
          value: state.gameDuration.value,
          min: 0.5,
          max: 4.0,
          divisions: 7,
          onChanged: logic.setGameDuration,
        ),
      ],
    );
  }

  Widget _buildBuyInSection(CreateRoomLogic logic, CreateRoomState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '最小买入记分牌',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.pxSp,
          ),
        ),
        SizedBox(height: 8.pxh),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.pxw),
          decoration: BoxDecoration(
            color: const Color(0xFF1C2C36),
            borderRadius: BorderRadius.circular(8.pxw),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${state.minBuyIn.value}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.pxSp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
              ),
            ],
          ),
        ),
        SizedBox(height: 16.pxh),
        Text(
          '记分牌买入上限',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.pxSp,
          ),
        ),
        SizedBox(height: 8.pxh),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.pxw),
          decoration: BoxDecoration(
            color: const Color(0xFF1C2C36),
            borderRadius: BorderRadius.circular(8.pxw),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${state.buyInLimit.value}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.pxSp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSlider({
    required double value,
    required double min,
    required double max,
    required int divisions,
    required ValueChanged<double> onChanged,
    List<String>? labels,
  }) {
    return Column(
      children: [
        SliderTheme(
          data: SliderTheme.of(Get.context!).copyWith(
            activeTrackColor: const Color(0xFFFF6B35),
            inactiveTrackColor: const Color(0xFF1C2C36),
            thumbColor: const Color(0xFFFF6B35),
            overlayColor: const Color(0xFFFF6B35).withOpacity(0.2),
            trackHeight: 4.pxh,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
          ),
          child: Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            onChanged: onChanged,
          ),
        ),
        if (labels != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: labels.map((label) => Text(
              label,
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 12.pxSp,
              ),
            )).toList(),
          ),
      ],
    );
  }

  Widget _buildCreateButton(CreateRoomLogic logic) {
    return SizedBox(
      width: double.infinity,
      height: 48.pxh,
      child: ElevatedButton(
        onPressed: logic.createRoom,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF6B35),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.pxw),
          ),
        ),
        child: Text(
          '创建牌局',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.pxSp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
} 