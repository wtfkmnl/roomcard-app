import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

class DropHeaderCompleteWidget extends StatelessWidget {
  const DropHeaderCompleteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.check,
          size: 20,
          color: Colors.grey.shade500,
        ),
        Text(
          '刷新完成'.tr,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade500,
          ),
        ),
      ],
    );
  }
}
