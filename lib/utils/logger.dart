import 'package:logger/logger.dart';

/// 打印日志封装的
Logger logger = Logger(
  printer: PrettyPrinter(
    colors: true,
    methodCount: 1,
  ),
);