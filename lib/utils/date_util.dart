import 'package:intl/intl.dart';

///日期相关
class DateUtil {
  /// 时间戳转格式化字符串（默认格式：yyyy-MM-dd HH:mm:ss）
  static String formatTimestamp(int timestamp, {String pattern = 'yyyy-MM-dd HH:mm:ss'}) {
    return DateFormat(pattern).format(DateTime.fromMillisecondsSinceEpoch(timestamp));
  }

  /// 获取当前时间戳（毫秒）
  static int get currentMillis => DateTime.now().millisecondsSinceEpoch;

  /// 计算两个日期的天数差
  static int daysBetween(DateTime start, DateTime end) {
    return end.difference(start).inDays;
  }

  /// 判断是否为今天
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }
}