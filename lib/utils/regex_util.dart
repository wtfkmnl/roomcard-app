///校验工具类
///```dart
///final isValid = RegexUtil.isChinesePhone('13800138000'); // true
///```
class RegexUtil {
  /// 校验手机号（中国大陆）
  static bool isChinesePhone(String phone) {
    return RegExp(r'^1[3-9]\d{9}$').hasMatch(phone);
  }

  /// 校验邮箱
  static bool isEmail(String email) {
    return RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(email);
  }

  /// 校验身份证号（简单版）
  static bool isIDCard(String id) {
    return RegExp(r'^\d{17}[\dXx]$').hasMatch(id);
  }

  /// 提取字符串中的数字
  static String extractNumbers(String input) {
    return input.replaceAll(RegExp(r'[^0-9]'), '');
  }


  //检查注册的密码的正则
  static  bool checkPwRegex(String regex,String input) {
    if (input.isEmpty) {
      return false;
    }
    return RegExp(regex).hasMatch(input);
  }






}
