
part of 'common_extension.dart';
extension NumWidgetExtension on num {
  /// 垂直间距
  Widget get height => SizedBox(height: toDouble());

  /// 水平间距
  Widget get width => SizedBox(width: toDouble());
}
