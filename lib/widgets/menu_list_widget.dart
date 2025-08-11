import 'package:roomcard/theme/app_theme.dart';
import 'package:roomcard/utils/common_extension/common_extension.dart';
import 'package:roomcard/utils/num_px.dart';
import 'package:roomcard/widgets/animation_item.dart';
import 'package:roomcard/widgets/smart_network_image.dart';
import 'package:roomcard/widgets/svg_util.dart';
import 'package:roomcard/widgets/texts/text_shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class MenuListModel {
  final String text;
  final String? selectedIconPath;
  final String? unselecedIconPath;
  final String? iconUrl;

  const MenuListModel({
    required this.text,
    this.unselecedIconPath,
    this.selectedIconPath,
    this.iconUrl,
  });
}

class MenuListWidget extends StatelessWidget {
  const MenuListWidget({
    super.key,
    required this.data,
    required this.selectedIndex,
    required this.onTap,
  });
  final List<MenuListModel> data;
  final int selectedIndex;
  final void Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:
          30.pxh
          /**左间距 */
          +
          24.pxh
          /**右间距 */
          +
          204.pxh,
      /**UI图的宽度 */
      child: AnimationLimiter(
        child: ListView.separated(
          itemCount: data.length,
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom + 20,
          ),
          itemBuilder: (context, index) {
            final model = data[index];
            final isSelected = index == selectedIndex;
            return AnimationItem.list(
              position: index,
              duration: data.length >= 3 ? 275.milliseconds : 0.milliseconds,
              child: _buildItem(index, isSelected, model),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Container(height: 24.pxh);
          },
        ),
      ),
    );
  }

  GestureDetector _buildItem(int index, bool isSelected, MenuListModel model) {
    return GestureDetector(
      onTap: () {
        onTap(index);
      },
      child: Container(
        margin: EdgeInsets.only(left: 30.pxw, right: 24.pxw),
        height: 192.pxh,
        child: Stack(
          children: [
            Positioned.fill(
              child: AnimatedSwitcher(
                duration: 275.milliseconds,
                child: SvgUtil.asset(
                  isSelected
                      ? 'assets/images/game_lobby/侧边栏底框.svg'
                      : 'assets/images/game_lobby/侧边栏底框未选中.svg',
                  key: ValueKey(isSelected),
                ),
              ),
            ),
            Positioned.fill(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Builder(
                    builder: (BuildContext context) {
                      if (model.unselecedIconPath?.endsWith('.png') == true) {
                        return Image.asset(
                          isSelected
                              ? model.selectedIconPath ?? ''
                              : model.unselecedIconPath ?? '',
                          width: 72.pxw,
                          height: 72.pxh,
                        );
                      }
                      if (model.iconUrl?.isNotEmpty == true) {
                        return SmartNetworkImage(
                          imageUrl: model.iconUrl!,
                          width: 72.pxw,
                          height: 72.pxh,
                        );
                      }
                      return SvgUtil.asset(
                        isSelected
                            ? model.selectedIconPath ?? ''
                            : model.unselecedIconPath ?? '',
                        width: 72.pxw,
                        height: 72.pxh,
                      );
                    },
                  ),
                  SizedBox(
                    height: 57.pxh,
                    child: Text(
                      model.text,
                      textAlign: TextAlign.center,
                      style: isSelected
                          ? TextStyle(
                              color: AppTheme().current.color15 /* 文字-按钮内 */,
                              fontSize: 42.pxSp,
                              fontWeight: FontWeight.w600,
                              height: 1.36,
                              shadows: textShadow(),
                            )
                          : TextStyle(
                              color:
                                  AppTheme().current.themeColor1 /* 主题色-1级 */,
                              fontSize: 42.pxSp,
                              fontWeight: FontWeight.w400,
                              height: 1.36,
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
