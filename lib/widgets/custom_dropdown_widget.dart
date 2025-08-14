import 'package:flutter/material.dart';
import 'package:roomcard/utils/num_px.dart';
import 'package:roomcard/r.dart';

class CustomDropdownWidget<T> extends StatefulWidget {
  /// 当前选中的值
  final T value;
  
  /// 可选值列表
  final List<T> items;
  
  /// 值改变时的回调
  final ValueChanged<T>? onChanged;
  
  /// 是否禁用
  final bool disabled;
  
  /// 容器高度
  final double height;
  
  /// 左侧文字样式
  final TextStyle? textStyle;
  
  /// 右侧图标大小
  final double iconSize;
  
  /// 下拉框最大高度
  final double maxDropdownHeight;
  
  /// 自定义显示文本转换器
  final String Function(T)? itemToString;

  const CustomDropdownWidget({
    Key? key,
    required this.value,
    required this.items,
    this.onChanged,
    this.disabled = false,
    this.height = 48,
    this.textStyle,
    this.iconSize = 20,
    this.maxDropdownHeight = 200,
    this.itemToString,
  }) : super(key: key);

  @override
  State<CustomDropdownWidget<T>> createState() => _CustomDropdownWidgetState<T>();
}

class _CustomDropdownWidgetState<T> extends State<CustomDropdownWidget<T>> {
  bool _isOpen = false;
  bool _showAbove = false;
  late OverlayEntry _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  void _removeOverlay() {
    if (_isOpen) {
      _overlayEntry.remove();
      _isOpen = false;
    }
  }

  void _toggleDropdown() {
    if (widget.disabled) return;
    
    if (_isOpen) {
      _removeOverlay();
    } else {
      _showDropdown();
    }
  }

  void _showDropdown() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry);
    _isOpen = true;
  }

  OverlayEntry _createOverlayEntry() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final position = renderBox.localToGlobal(Offset.zero);
    
    // 获取屏幕尺寸
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    // 计算下拉框的预估高度
    final estimatedDropdownHeight = (widget.items.length * 44.0).clamp(0.0, widget.maxDropdownHeight);
    
    // 判断是否有足够的底部空间
    final hasBottomSpace = position.dy + size.height + estimatedDropdownHeight + 4 < screenHeight;
    
    // 判断是否有足够的顶部空间
    final hasTopSpace = position.dy > estimatedDropdownHeight + 4;
    
    // 决定显示位置：优先显示在下方，如果下方空间不够且上方有空间则显示在上方
    final showAbove = !hasBottomSpace && hasTopSpace;
    
    // 更新状态
    _showAbove = showAbove;
    
    // 计算偏移量
    final offset = showAbove 
      ? Offset(0, -estimatedDropdownHeight - 4)  // 显示在上方
      : Offset(0, size.height + 4);              // 显示在下方

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: offset,
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(8.pxw),
            child: Container(
              constraints: BoxConstraints(
                maxHeight: widget.maxDropdownHeight,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF1C2D37),
                borderRadius: BorderRadius.circular(8.pxw),
                border: Border.all(
                  color: const Color(0xFF37505E),
                  width: 1.pxw,
                ),
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: widget.items.length,
                itemBuilder: (context, index) {
                  final item = widget.items[index];
                  final isSelected = item == widget.value;
                  
                  return InkWell(
                    onTap: () {
                      print('Dropdown item tapped: $item, current value: ${widget.value}');
                      widget.onChanged?.call(item);
                      _removeOverlay();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.pxw,
                        vertical: 12.pxh,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected 
                          ? const Color(0xFF2F4553).withOpacity(0.3)
                          : Colors.transparent,
                        borderRadius: BorderRadius.circular(8.pxw),
                      ),
                      child: Text(
                        widget.itemToString?.call(item) ?? item.toString(),
                        style: TextStyle(
                          color: isSelected 
                            ? Colors.white 
                            : const Color(0xFF57646D),
                          fontSize: 14.pxSp,
                          fontWeight: isSelected 
                            ? FontWeight.w600 
                            : FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Container(
        width: double.infinity,
        height: widget.height,
        padding: EdgeInsets.symmetric(horizontal: 8.pxw),
        decoration: BoxDecoration(
          color: const Color(0xFF1C2D37),
          borderRadius: BorderRadius.circular(8.pxw),
          border: Border.all(
            color: const Color(0xFF37505E),
            width: 1.pxw,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                widget.itemToString?.call(widget.value) ?? widget.value.toString(),
                style: widget.textStyle ?? TextStyle(
                  color: Colors.white,
                  fontSize: 16.pxSp,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            GestureDetector(
              onTap: _toggleDropdown,
              child: Container(
                padding: EdgeInsets.all(4.pxw),
                child: Transform.rotate(
                  angle: _isOpen 
                    ? (_showAbove ? 1.5 * 3.14159 : 0)  // 打开时：上方显示则向上指，下方显示则向下指
                    : 1.5 * 3.14159,                      // 关闭时：270度
                  child: Image.asset(
                    R.assetsImagesIconTitleBack,
                    width: widget.iconSize,
                    height: widget.iconSize,
                    color: widget.disabled 
                      ? const Color(0xFF57646D)
                      : Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 