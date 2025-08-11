extension StringExtension on String {
  // 邮箱的验证
  bool isEmailValid() {
    return RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(this);
  }

  // 字符串，每隔4个字符 添加一个空格  . 匹配任意字符    \d: 匹配数字字符  \w: 匹配单词字符（字母、数字、下划线） \s: 匹配空白字符（空格、制表符、换行符等）
  //todo：如果是最后一个是刚好4位，也会加一个空格
  String addSpacesToString() {
    final pattern = RegExp(r'(.{4})');
    return replaceAllMapped(pattern, (match) => '${match[0]} ').trim();
  }

  String HidePhone() {
    if (isNotEmpty && length == 11) {
      return replaceRange(5, 9, "****");
    } else {
      return this;
    }
  }

  String addHideWords() {
    if (isNotEmpty) {
      if (length < 8) {
        //123
        return "${substring(0, 1)}**************${substring(length - 1)}";
      } else {
        return "${substring(0, 4)}********${substring(length - 4, length - 1)}";
      }
    } else {
      return "";
    }
  }

  String addHideName() {
    if (isNotEmpty) {
      if (length > 3) {
        //123
        return "${substring(0, 1)}**${substring(length - 1)}";
      } else if (length < 3) {
        return "${substring(0, 1)}*";
      } else {
        return "${substring(0, 1)}*${substring(length - 1)}";
      }
    } else {
      return "";
    }
  }

  String addHideWallet() {
    if (isNotEmpty) {
      if (length < 8) {
        //123
        return "${substring(0, 1)}****${substring(length - 1)}";
      } else {
        return "${substring(0, 4)}****${substring(length - 5, length - 1)}";
      }
    } else {
      return "";
    }
  }
}
