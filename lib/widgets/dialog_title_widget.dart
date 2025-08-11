import 'package:roomcard/utils/num_px.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogTitle extends StatelessWidget {
  final String title;
  final double width;
  final bool hasCustomerService;

  const DialogTitle({
    super.key,
    required this.title,
    required this.width,
    this.hasCustomerService = false,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: width,
      height: 120.pxh,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/login/弹窗顶部背景.png'),
          fit: BoxFit.fill,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(36.pxw),
          topRight: Radius.circular(36.pxw),
        ),
      ),
      child: SizedBox(
        height: 75.pxh,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 48.pxh,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            Positioned(
              right: 30.pxh,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Image.asset(
                  'assets/images/withdraw/关闭.png',
                  width: 75.pxw,
                  height: 75.pxh,
                ),
              ),
            ),
            if (hasCustomerService)
              Positioned(
                left: 30.pxw,
                child: GestureDetector(
                  onTap: () {
                    ///跳转客服
                  },
                  child: Image.asset(
                    'assets/images/withdraw/在线客服.png',
                    width: 56.pxw,
                    height: 53.5.pxh,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
