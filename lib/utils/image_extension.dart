import 'dart:async';
import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

extension CustomExtension on ui.Image {}

Widget imageView(
  String? url, {
  String? placeholder,
  Widget? placeholderWidget,
  Widget? errorWidget,
  double? width,
  double? height,
  BoxFit? fit,
  Alignment alignment = Alignment.center,
  Color? color,
  bool errorWidgetUsePlaceholder = false,
}) {
  if (url?.isEmpty ?? true) {
    return const SizedBox();
  }
  if (url!.startsWith("http")) {
    return CachedNetworkImage(
      imageUrl: url,
      color: color,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      placeholder: (context, url) {
        return placeholderWidget ?? imageView(placeholder, width: width, height: height, fit: fit, alignment: alignment);
      },
      errorWidget: (context, url, error) {
        if (errorWidget == null && !errorWidgetUsePlaceholder) {
          return kDebugMode
              ? Text(
                  error.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    color: Colors.red,
                  ),
                )
              : const SizedBox();
        }
        return errorWidget ?? imageView(placeholder, width: width, height: height, fit: fit, alignment: alignment);
      },
    );
  }
  return Image.asset(
    url,
    width: width,
    height: height,
    fit: fit,
    alignment: alignment,
    color: color,
  );
}

// void saveNetworkImg(String imgUrl) async {
//   var response = await Dio().get(imgUrl, options: Options(responseType: ResponseType.bytes));
//   PermissionHelper.checkPermission(
//       permissionList: Platform.isAndroid ? [Permission.storage] : [Permission.photos],
//       onSuccess: () async {
//         final result = await ImageGallerySaver.saveImage(Uint8List.fromList(response.data), quality: 100);
//         if (result['isSuccess']) {

//         } else {

//         }
//       },
//       errorMsg: "请求权限失败");
// }

// void saveNetworkVideo(String url) async {
//   var appDocDir = await getTemporaryDirectory();
//   var fileName = url.split("/").last;
//   String savePath = "${appDocDir.path}/$fileName";
//   await Dio().download(url, savePath);
//   var saveResult = await ImageGallerySaver.saveFile(savePath);
//   if (saveResult['isSuccess']) {
//   } else {}
// }

/// 截屏图片
Future<Uint8List?> captureImage({required GlobalKey key}) async {
  RenderRepaintBoundary? boundary = key.currentContext!.findRenderObject() as RenderRepaintBoundary?;
  // View.of(context)
  double dpr = ui.window.devicePixelRatio; // 获取当前设备的像素比
  var image = await boundary?.toImage(pixelRatio: dpr);
  // 将image转化成byte
  ByteData? byteData = await image?.toByteData(format: ui.ImageByteFormat.png);

  Uint8List? pngBytes = byteData?.buffer.asUint8List();

  return pngBytes;
}

Future<ui.Image> invertImage(ui.Image image) async {
  final int width = image.width;
  final int height = image.height;

  final ui.PictureRecorder recorder = ui.PictureRecorder();
  final ui.Canvas canvas = ui.Canvas(recorder);

  final ui.Paint paint = ui.Paint();
  // final maskFilter = ui.MaskFilter.blur(
  //   ui.BlurStyle.normal,
  //   ui.BlurStyle.normal.convertRadiusToSigma(1.0),
  // );

  final ui.Rect rect = ui.Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble());

  Offset offset = Offset.zero;

  canvas.drawImage(image, offset, paint);
  // canvas.drawImage
  paint.color = const ui.Color.fromRGBO(255, 255, 255, 1);
  paint.blendMode = ui.BlendMode.difference;
  canvas.drawRect(rect, paint);

  final ui.Picture picture = recorder.endRecording();
  final ui.Image newImage = await picture.toImage(width, height);

  return newImage;
}
