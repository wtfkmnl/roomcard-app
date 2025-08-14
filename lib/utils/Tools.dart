import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:roomcard/global.dart';
import 'package:roomcard/services/config.dart';
import 'package:roomcard/utils/commonUtils.dart';
import 'package:roomcard/utils/storage_util.dart';
import 'package:roomcard/utils/values/constants.dart';
import 'package:roomcard/utils/values/enums.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:uuid/uuid.dart';

class Tools {
  static LanguageType getCurLanguage() {
    String langCode = StorageUtil.getString(Constants.storageLanguageCode);
    if (langCode.isEmpty) {
      var apiLangCode =
          "zh"; //Global.instance.dicModel?.baseSiteConfig?.defaultLanguageCode ??
      return LanguageType.values.firstWhere(
        (e) => e.languageCode == apiLangCode,
      );
    } else {
      return LanguageType.values.firstWhere(
        (e) => e.locale().languageCode == langCode,
      );
    }
  }

  static String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  static String getChannelId() {
    return '1';
  }

  static Future<String> getTraceId() async {
    var deviceId = "";
    // if (Platform.isAndroid) {
    //   var build = await ConfigService.to.device.androidInfo;
    //   deviceId = build.fingerprint;
    // } else if (Platform.isIOS) {
    //   var storage = const FlutterSecureStorage();
    //   // Read value
    //   deviceId = "";
    //   try {
    //     deviceId = await storage.read(key: Constants.storageTraceId) ?? "";
    //   } catch (e) {
    //     printSome(e);
    //   }
    //   if (deviceId.isEmpty) {
    //     deviceId = const Uuid().v4();
    //     // Write value
    //     await storage.write(key: Constants.storageTraceId, value: deviceId);
    //   }
    // }

    var storage = const FlutterSecureStorage();
    // Read value
    deviceId = "";
    try {
      deviceId = await storage.read(key: Constants.storageTraceId) ?? "";
    } catch (e) {
      printSome(e);
    }
    if (deviceId.isEmpty) {
      deviceId = const Uuid().v4();
      // Write value
      await storage.write(key: Constants.storageTraceId, value: deviceId);
    }

    printSome("设备唯一标识符 $deviceId");
    Global.instance.traceId = deviceId;
    return deviceId;

    // String traceId = Storage().getString(Constants.storageTraceId);
    // if (traceId.isEmpty) {
    //   traceId = const Uuid().v4();
    //   Storage().setString(Constants.storageTraceId, traceId);
    // }
    // return traceId;
  }

  static String getDevice() {
    var userAgent = "";
    BaseDeviceInfo? deviceInfo = ConfigService.instance.deviceInfo;
    if (GetPlatform.isIOS) {
      userAgent += deviceInfo?.data["systemName"] ?? "";
      userAgent += "/";
      userAgent += deviceInfo?.data["model"] ?? "";
      userAgent += "/";
      userAgent += deviceInfo?.data["systemVersion"] ?? "";
      userAgent += "/";
      userAgent += deviceInfo?.data["utsname"]["machine"] ?? "";
    } else {
      userAgent += deviceInfo?.data["brand"] ?? "";
      userAgent += "/";
      userAgent += deviceInfo?.data["model"] ?? "";
      userAgent += "/";
      userAgent += deviceInfo?.data["version"]["baseOS"] ?? "";
      userAgent += "/";
      userAgent += deviceInfo?.data["device"] ?? "";
    }
    return userAgent;
  }
}
