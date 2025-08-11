import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show debugPrint, kIsWeb;

class ClipboardUtil {
  /// 复制文本到剪贴板
  static Future<void> copyText(String text) async {
    try {
      if (kIsWeb) {
        // Web 平台需要短暂延迟确保复制完成
        await Future.delayed(const Duration(milliseconds: 50));
      }
      await Clipboard.setData(ClipboardData(text: text));
    } catch (e) {
      debugPrint('复制失败: ${e.toString()}');
    }
  }

  /// 从剪贴板粘贴文本
  static Future<String?> pasteText() async {
    try {
      if (kIsWeb) {
        await Future.delayed(Duration(milliseconds: 50));
        final data = await Clipboard.getData(Clipboard.kTextPlain);
        return data?.text;
      } else {
        final data = await Clipboard.getData(Clipboard.kTextPlain);
        return data?.text;
      }
    } catch (e) {
      return null;
    }
  }
}
