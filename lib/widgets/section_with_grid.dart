import 'package:roomcard/theme/app_theme.dart';
import 'package:roomcard/utils/common_extension/common_extension.dart';
import 'package:roomcard/utils/num_px.dart';
import 'package:roomcard/widgets/svg_util.dart';
import 'package:roomcard/widgets/texts/gradient_text.dart';

import 'package:roomcard/widgets/placeholders/skeleton_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/route_manager.dart';

/// 带分页功能的六宫格区块组件
///
/// 特性：
/// - 自适应高度（1行或2行）
/// - 超过6个item自动分页
/// - 完全可定制样式
class SectionWithGrid extends StatefulWidget {
  /// 区块标题文本
  final String title;

  ///左边的icon
  final String? leftIconPath;

  final void Function()? onMoreTap;

  /// 宫格子项列表
  final List<Widget> children;

  /// 每行显示数量（默认3个，即3x2六宫格）
  final int crossAxisCount;

  /// 子项宽高比（默认1:1正方形）
  final double childAspectRatio;

  /// 子项间距
  final double spacing;

  /// 整个区块的内边距
  final EdgeInsetsGeometry padding;

  /// 自定义标题样式
  final TextStyle? titleStyle;

  ///是否显示骨架屏
  final bool isShowSkeleton;

  ///是否为单行滚动
  final bool isSingleScroll;

  const SectionWithGrid({
    super.key,
    this.title = '',
    this.children = const [],
    this.crossAxisCount = 3,
    this.childAspectRatio = 1.0,
    this.spacing = 8.0,
    this.padding = EdgeInsets.zero,
    this.titleStyle,
    this.leftIconPath,
    this.onMoreTap,
    this.isShowSkeleton = false,
    this.isSingleScroll = false,
  });

  @override
  State<SectionWithGrid> createState() => _SectionWithGridState();
}

class _SectionWithGridState extends State<SectionWithGrid> {
  final PageController _pageController = PageController(
    viewportFraction: 0.95, // 每个页面占据视口的百分比
  );
  PageController? _singlePageController;
  int _currentPage = 0; // 当前页码（从0开始）

  /// 计算总页数（每页显示 crossAxisCount*2 个item）
  int get _totalPages =>
      (widget.children.length / (widget.crossAxisCount * 2)).ceil();

  /// 按页分割子项
  List<List<Widget>> get _pagedItems {
    List<List<Widget>> pages = [];
    final itemsPerPage = widget.crossAxisCount * 2;

    for (var i = 0; i < widget.children.length; i += itemsPerPage) {
      final end = (i + itemsPerPage) > widget.children.length
          ? widget.children.length
          : i + itemsPerPage;
      pages.add(widget.children.sublist(i, end));
    }

    return pages;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题行（包含导航按钮）
          Padding(
            padding: EdgeInsets.only(left: 30.pxw, right: 30.pxw),
            child: _buildHeader(),
          ),
          Gap(24.pxh),
          // 宫格内容区域
          _buildPagedGrid(),
        ],
      ),
    );
  }

  /// 构建带PageView的宫格
  Widget _buildPagedGrid() {
    final pages = _pagedItems;
    if (widget.isSingleScroll && widget.isShowSkeleton == false) {
      //单行
      final width = (Get.width) * 0.95 / 3 / Get.width;
      _singlePageController ??= PageController(
        viewportFraction: width, // 每个页面占据视口的百分比
      );
      return SizedBox(
        height: _calculateGridHeight(1),
        child: PageView.builder(
          controller: _singlePageController,
          padEnds: false,
          onPageChanged: (page) {
            setState(() => _currentPage = page);
          },
          itemCount: widget.children.length,
          itemBuilder: (context, pageIndex) {
            return Container(
              margin: EdgeInsets.only(left: 30.pxw), // 右边露出距离
              child: widget.children[pageIndex],
            );
          },
          physics: widget.isShowSkeleton
              ? const NeverScrollableScrollPhysics()
              : const ClampingScrollPhysics(), // 没有弹性的滚动效果
          pageSnapping: true, // 启用页面吸附
        ),
      );
    }

    ///两行
    return SizedBox(
      height: _calculateGridHeight(() {
        if (widget.isShowSkeleton) {
          return 2; //骨架屏固定2行高度
        }
        return widget.children.length <= 3 ? 1 : 2;
      }()), // 计算几行高度
      child: PageView.builder(
        controller: _pageController,
        padEnds: false,
        onPageChanged: (page) {
          setState(() => _currentPage = page);
        },
        itemCount: widget.isShowSkeleton ? 6 : pages.length, //骨架屏，12个item，撑满2页
        itemBuilder: (context, pageIndex) {
          return Container(
            margin: EdgeInsets.only(left: 30.pxw), // 右边露出距离
            child: _buildGridPage(
              widget.isShowSkeleton
                  ? List.generate(6, (index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: SkeletonWidget(),
                      );
                    })
                  : pages[pageIndex],
            ),
          );
        },
        physics: widget.isShowSkeleton
            ? const NeverScrollableScrollPhysics()
            : const ClampingScrollPhysics(), // 没有弹性的滚动效果
        pageSnapping: true, // 启用页面吸附
      ),
    );
  }

  /// 构建单页宫格
  Widget _buildGridPage(List<Widget> items) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: widget.crossAxisCount,
      childAspectRatio: widget.childAspectRatio,
      mainAxisSpacing: widget.spacing,
      crossAxisSpacing: widget.spacing,
      shrinkWrap: true,
      children: items,
    );
  }

  /// 计算宫格高度
  double _calculateGridHeight(int rowCount) {
    return (((MediaQuery.of(context).size.width) * 0.95 - 60.pxw) /
            widget.crossAxisCount *
            widget.childAspectRatio *
            rowCount) +
        (widget.spacing * (rowCount - 1));
  }

  /// 构建标题行组件
  Widget _buildHeader() {
    return SizedBox(
      height: 90.pxh,
      child: widget.isShowSkeleton
          ? _buildHeaderSkeleton()
          : Row(
              children: [
                SvgUtil.asset(
                  widget.leftIconPath!,
                  width: 54.pxw,
                  height: 54.pxw,
                ).visible(widget.leftIconPath != null),
                Gap(12.pxw),
                // 标题文本（支持自定义样式）
                GradientText(
                  child: Text(
                    widget.title,
                    style:
                        widget.titleStyle ??
                        TextStyle(
                          fontSize: 48.pxSp,
                          fontWeight: FontWeight.w600,
                          height: 1.38,
                        ),
                  ),
                ),
                const Spacer(), // 占位空间
                InkWell(
                  onTap: () {
                    widget.onMoreTap?.call();
                  },
                  child: SizedBox(
                    width: 168.pxw,
                    height: 90.pxh,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: SvgUtil.asset('assets/images/main/更多.svg'),
                        ),
                        Center(
                          child: Text(
                            '更多',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppTheme().current.textColor3 /* 文字-3级 */,
                              fontSize: 33.pxSp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Gap(18.pxw),
                // 只有需要分页时才显示导航按钮
                _buildNavigationButtons(),
              ],
            ),
    );
  }

  Row _buildHeaderSkeleton() {
    return Row(
      children: [
        SizedBox(
          width: 339.pxw,
          child: SkeletonWidget(borderRadius: BorderRadius.circular(21.pxw)),
        ),
        const Spacer(),
        SizedBox(
          width: 408.pxw,
          child: SkeletonWidget(borderRadius: BorderRadius.circular(21.pxw)),
        ),
      ],
    );
  }

  /// 修改导航按钮逻辑以配合PageView
  Widget _buildNavigationButtons() {
    final showLastPage = _currentPage > 0;
    var showNextPage = _currentPage < _totalPages - 1;
    if (widget.isSingleScroll) {
      showNextPage = _currentPage < widget.children.length - 3;
    }
    return SizedBox(
      width: 222.pxw,
      height: 84.pxh,
      child: Stack(
        children: [
          Positioned.fill(child: SvgUtil.asset('assets/images/main/方向背景.svg')),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    if (showLastPage) {
                      PageController? controller;
                      if (widget.isSingleScroll) {
                        controller = _singlePageController;
                      } else {
                        controller = _pageController;
                      }
                      controller?.animateToPage(
                        _currentPage - 1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: SizedBox(
                    width: 102.pxw,
                    height: 72.pxh,
                    child: SvgUtil.asset(
                      showLastPage
                          ? 'assets/images/main/上一页.svg'
                          : 'assets/images/main/上一页不可用.svg',
                    ),
                  ),
                ),
                Gap(6.pxw),
                InkWell(
                  onTap: () {
                    if (showNextPage) {
                      PageController? controller;
                      if (widget.isSingleScroll) {
                        controller = _singlePageController;
                      } else {
                        controller = _pageController;
                      }
                      controller?.animateToPage(
                        _currentPage + 1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: SizedBox(
                    width: 102.pxw,
                    height: 72.pxh,
                    child: SvgUtil.asset(
                      showNextPage
                          ? 'assets/images/main/下一页.svg'
                          : 'assets/images/main/下一页不可用.svg',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
