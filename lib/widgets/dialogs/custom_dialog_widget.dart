import 'package:roomcard/routes/app_router.dart';
import 'package:roomcard/theme/app_theme.dart';
import 'package:roomcard/utils/num_px.dart';
import 'package:roomcard/widgets/texts/text_shadow.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomDialogWidget extends StatelessWidget {
  final String title;
  final Widget? content;

  ///显示关闭按钮
  final bool showCloseButton;
  const CustomDialogWidget({
    super.key,
    this.title = '',
    this.content,
    this.showCloseButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: SizedBox(
        width: 900.pxw,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildHeader(),
            Image.asset(
              'assets/images/login/分割线.png',
              height: 6.pxh,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
            _buildContent(),
          ],
        ),
      ),
    );
  }

  Container _buildContent() {
    return Container(
      padding: EdgeInsets.all(60.pxw),
      decoration: ShapeDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF2C2C2C),
            const Color(0xFF1F1F1F),
            const Color(0xFF212121),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(36.pxw),
            bottomRight: Radius.circular(36.pxw),
          ),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 24.pxw,
            offset: Offset(0, 15.pxw),
            spreadRadius: 0,
          ),
        ],
      ),
      child: content,
    );
  }

  Container _buildHeader() {
    return Container(
      height: 120.pxh,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/login/弹窗顶部背景.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Row(
        children: [
          Gap(30.pxw),
          Gap(75.pxw),
          Expanded(
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white /* 文字-1级 */,
                  fontSize: 48.pxSp,
                  fontWeight: FontWeight.w600,
                  height: 1.38,
                ),
              ),
            ),
          ),
          if (showCloseButton)
            InkWell(
              onTap: () {
                AppRouter.back();
              },
              child: Image.asset(
                'assets/images/dialog/关闭.png',
                width: 75.pxw,
                height: 75.pxh,
              ),
            )
          else
            Gap(75.pxw),
          Gap(30.pxw),
        ],
      ),
    );
  }
}
