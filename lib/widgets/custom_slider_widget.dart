import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roomcard/utils/num_px.dart';

import '../r.dart';

class CustomSliderWidget extends StatefulWidget {
  /// 当前选中的索引 (0 到 pointsCount-1)
  final int currentIndex;

  /// 值改变时的回调
  final ValueChanged<int>? onChanged;

  /// 点的数量
  final int pointsCount;
  /// 是否显示步骤
  final bool needStepIndex;

  /// 是否禁用
  final bool disabled;

  const CustomSliderWidget({Key? key, this.currentIndex = 0, this.onChanged, this.pointsCount = 8, this.disabled = false, this.needStepIndex = false}) : super(key: key);

  @override
  State<CustomSliderWidget> createState() => _CustomSliderWidgetState();
}

class _CustomSliderWidgetState extends State<CustomSliderWidget> {
  late int _currentIndex;
  late double _indicatorPosition;

  /// 滑块宽度
  final double width = 310.pxw;
  final double height = 22.pxw;

  /// 指示器大小
  final double indicatorSize = 22.pxw;
  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex.clamp(0, widget.pointsCount - 1);
    _updateIndicatorPosition();
  }

  @override
  void didUpdateWidget(CustomSliderWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _currentIndex = widget.currentIndex.clamp(0, widget.pointsCount - 1);
      _updateIndicatorPosition();
    }
  }

  void _updateIndicatorPosition() {
    final double stepWidth = (width - indicatorSize) / (widget.pointsCount - 1);
    _indicatorPosition = _currentIndex * stepWidth;
  }

  void _onTapDown(TapDownDetails details) {
    if (widget.disabled) return;

    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final localPosition = renderBox.globalToLocal(details.globalPosition);

    final double stepWidth = (width - indicatorSize) / (widget.pointsCount - 1);
    final int newIndex = ((localPosition.dx  - indicatorSize / 2) / stepWidth).round().clamp(0, widget.pointsCount - 1);

    if (newIndex != _currentIndex) {
      setState(() {
        _currentIndex = newIndex;
        _updateIndicatorPosition();
      });
      widget.onChanged?.call(_currentIndex);
    }
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (widget.disabled) return;

    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final localPosition = renderBox.globalToLocal(details.globalPosition);

    final double stepWidth = (width - indicatorSize) / (widget.pointsCount - 1);
    final int newIndex = ((localPosition.dx- indicatorSize / 2) / stepWidth).round().clamp(0, widget.pointsCount - 1);

    if (newIndex != _currentIndex) {
      setState(() {
        _currentIndex = newIndex;
        _updateIndicatorPosition();
      });
      widget.onChanged?.call(_currentIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onPanUpdate: _onPanUpdate,
      child: Container(
        width: 343.pxw,
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              height: 41.pxh,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80.pxw),
                color: const Color(0xFF283D49), // 内层轨道
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.pxw),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // 动态生成圆点
                  ...List.generate(widget.pointsCount, (index) {
                    final double stepWidth = (width - indicatorSize) / (widget.pointsCount - 1);
                    final double dotPosition = index * stepWidth;

                    return Positioned(
                      left: dotPosition,
                      top: 41.pxh / 2 - 18.pxw / 2,
                      child: Row(
                        children: [
                          Container(
                            width: 18.pxw,
                            height: 18.pxh,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFF0F212E), // 深色圆点
                              boxShadow: [BoxShadow(color: Color(0x91000000), offset: Offset(0, 1), blurRadius: 1, spreadRadius: 0)],
                            ),
                          ),
                          if (index < widget.pointsCount - 1)
                            Container(
                              width: stepWidth - 18.pxw, // 动态计算宽度：步长减去圆点宽度
                              height: 9.pxh,
                              decoration: BoxDecoration(
                                color: const Color(0xFF0F212E),
                                boxShadow: [BoxShadow(color: Color(0x91000000), offset: Offset(0, 1), blurRadius: 1, spreadRadius: 0)],
                              ),
                            ),
                        ],
                      ),
                    );
                  }),

                  // 金色指示器
                  Positioned(
                    left: _indicatorPosition,
                    top: 41.pxh / 2 - indicatorSize / 2,
                    child: Image.asset(
                      'assets/images/game/slider_btn.png', // 替换为你的指示器图片
                      width: indicatorSize.pxw,
                      height: indicatorSize.pxh,
                    ),
                  ),
                ],
              ),
            ),
      if(widget.needStepIndex)...[
        //步骤数字
        SizedBox(height: 8.pxh),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(widget.pointsCount, (index) {
            return Text(
              '${index + 1}',
              style: TextStyle(color: index == _currentIndex ? Colors.white : Color(0xFF57646D), fontSize: 12.pxSp, fontWeight: FontWeight.w500),
            );
          }),
        ).paddingSymmetric(horizontal: 24.pxw),
      ]
          ],
        ),
      ),
    );
  }
}
