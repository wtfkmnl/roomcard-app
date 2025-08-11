import 'dart:io';
import 'dart:ui';
import 'package:roomcard/utils/logger.dart';
import 'package:flutter/rendering.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';

/// 文件存储，使用示例
/// ``` dart
/// final cachePath = await FileUtil.getCachePath();
/// final file = await FileUtil.writeFile('$cachePath/log.txt', 'Hello World');
/// ```
class FileUtil {
  ///把widget转换成image图片。
  static Future<Uint8List?> captureWidgetToImage(GlobalKey key) async {
    try {
      RenderRepaintBoundary boundary =
          key.currentContext!.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      logger.e("Error capturing widget: $e");
      return null;
    }
  }

  ///把widget转换成image图片并且保存到相册里
  static Future<bool> saveWidgetToGallery(
    GlobalKey key, {
    String fileName = 'widget_image.png',
  }) async {
    Uint8List? pngBytes = await captureWidgetToImage(key);
    if (pngBytes == null) return false;

    final tempDir = await getTemporaryDirectory();
    final file = await File('${tempDir.path}/$fileName').create();
    await file.writeAsBytes(pngBytes);

    await GallerySaver.saveImage(file.path);
    return true;
  }

  /// 获取应用缓存目录路径
  static Future<String> getCachePath() async {
    final dir = await getTemporaryDirectory();
    return dir.path;
  }

  /// 写入文件（自动创建目录）
  static Future<File> writeFile(String path, String content) async {
    final file = File(path);
    await file.create(recursive: true);
    return file.writeAsString(content);
  }

  /// 读取文件
  static Future<String> readFile(String path) async {
    return await File(path).readAsString();
  }

  /// 删除文件或目录
  static Future<void> delete(String path) async {
    final entity = File(path);
    if (await entity.exists()) await entity.delete(recursive: true);
  }
}
