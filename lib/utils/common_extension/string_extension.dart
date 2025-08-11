part of 'common_extension.dart';

extension StringExtension on String {
  // 将十六进制颜色代码转换为 [Color] 对象
  /// 例如: `#E0E0E0` 或 `E0E0E0`
  Color get hexToColor {
    var hexString = this;
    String subStr;
    if (hexString.contains("#")) {
      subStr = hexString.substring(1, 7);
    } else {
      subStr = hexString;
    }
    var parse = int.parse(subStr, radix: 16);
    var hexColor = Color(parse + 0xFF000000);
    return hexColor;
  }

  double toDouble() => double.parse(this);

  ///拆分字符(只保留数字)
  List<int> splitDigits() {
    return split('') // 拆分成单个字符
        .where((e) => RegExp(r'\d').hasMatch(e)) // 只保留数字字符
        .map(int.parse) // 转成整数
        .toList();
  }

  /// 159******25  这样的样式
  String HidePhone() {
    if (isNotEmpty && length == 11) {
      return replaceRange(3, 9, "******");
    } else {
      return this;
    }
  }





}
