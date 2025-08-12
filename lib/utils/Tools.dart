import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:roomcard/services/config.dart';
import 'package:roomcard/utils/storage_util.dart';
import 'package:roomcard/utils/values/constants.dart';
import 'package:roomcard/utils/values/enums.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

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
