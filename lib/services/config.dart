import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:roomcard/utils/storage_util.dart';
import 'package:roomcard/utils/values/constants.dart';

/// 配置服务
class ConfigService extends GetxService {
  // 这是一个单例写法
  static ConfigService get instance => Get.find();

  // Locale locale = PlatformDispatcher.instance.locale;
  Locale locale = const Locale('pt', "BR");

  PackageInfo? _platform;
  String get version => _platform?.version ?? '-';
  PackageInfo? get platform => _platform;

  DeviceInfoPlugin device = DeviceInfoPlugin();

  BaseDeviceInfo? _deviceInfo;
  BaseDeviceInfo? get deviceInfo => _deviceInfo;

  // 主题
  final RxString _themeName =
      StorageUtil.getString(Constants.storageThemeName).obs;
  String get themeName => _themeName.value;
  set themeName(String value) => _themeName.value = value;

  // 初始化
  Future<ConfigService> init() async {
    await getPlatform();
    _deviceInfo = await device.deviceInfo;
    return this;
  }

  Future<void> getPlatform() async {
    _platform = await PackageInfo.fromPlatform();
  }

  @override
  void onReady() {
    super.onReady();
    getPlatform();
  }
}
