import 'package:roomcard/utils/common_extension/common_extension.dart';
import 'package:flutter/material.dart';

class ImageProgressBar extends StatelessWidget {
  final double value; // 0.0 - 1.0
  final double height;
  final String backgroundImage;

  const ImageProgressBar({
    super.key,
    required this.value,
    required this.backgroundImage,
    this.height = 10,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        return SizedBox(
          height: height,
          width: double.infinity,
          child: Stack(
            children: [
              // 背景图
              Positioned.fill(
                child: Image.asset(
                  backgroundImage,
                  fit: BoxFit.fill,
                ),
              ),
              // 进度图
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(height / 2),
                  gradient: LinearGradient(
                    colors: [
                      '#a46331'.hexToColor,
                      '#fdddb5'.hexToColor,
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                width: width * value,
                height: height - 2,
              ),
            ],
          ),
        );
      },
    );
  }
}
