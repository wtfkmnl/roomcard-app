import 'package:flutter/cupertino.dart';

class GestureDetectorUtils {

  static GestureDetector directGestureDetector(GestureTapCallback? onTap,Widget? child){
    return GestureDetector(onTap: onTap,behavior: HitTestBehavior.opaque, child: child);
  }

}