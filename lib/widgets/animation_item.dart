import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

///列表动画
///```
///AnimationLimiter -> listView -> AnimationItem.list(child:your child)
///```
class AnimationItem {
  ///list默认动画
  static Widget list({
    required int position,
    Duration? duration,
    required Widget child,
  }) {
    return AnimationConfiguration.staggeredList(
      position: position,
      duration: duration ?? const Duration(milliseconds: 175),
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: FadeInAnimation(child: child),
      ),
    );
  }

  ///grid默认动画
  /// - [columnCount] 必须与crossAxisCount一致
  static Widget grid({
    required int position,
    required int columnCount,
    Duration? duration,
    required Widget child,
  }) {
    return AnimationConfiguration.staggeredGrid(
      position: position,
      duration: duration ?? const Duration(milliseconds: 175),
      columnCount: columnCount,
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: FadeInAnimation(child: child),
      ),
    );
  }
}
