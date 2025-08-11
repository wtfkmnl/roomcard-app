import 'package:intl/intl.dart';

class AmountFormatter {
  /// - 格式化金额
  /// - [amount]：金额（num/String）
  /// - [decimal]：小数点保留位数，默认 2 位
  static String format(dynamic amount, {int decimal = 2}) {
    if (amount == null) return '--';

    try {
      final num value = num.parse(amount.toString());

      final formatter = NumberFormat.currency(
        locale: 'en_US',
        symbol: '', // 不带货币符号
        decimalDigits: decimal,
      );

      return formatter.format(value).trim();
    } catch (e) {
      return '--'; // 格式化失败返回占位
    }
  }
}
