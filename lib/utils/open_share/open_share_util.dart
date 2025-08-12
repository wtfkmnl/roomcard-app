import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:roomcard/utils/commonUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:dio/dio.dart';

class OpenShare {
  //私有构造函数
  OpenShare._internal();
  //保存单例
  static final OpenShare _singleton = OpenShare._internal();
  //工厂构造函数
  factory OpenShare() => _singleton;

  BaseDeviceInfo? deviceInfo;
  PackageInfo? packageInfo;
  static late final SharedPreferences sharedPrefs;
  var _sharedPrefsInitFlag = false;
  String? _openShareKey;

  ///初始化mqtt链接配置
  Future<void> init(String openShareKey) async {
    _openShareKey = openShareKey;
    DeviceInfoPlugin device = DeviceInfoPlugin();
    deviceInfo = await device.deviceInfo;
    packageInfo = await PackageInfo.fromPlatform();
    if (!_sharedPrefsInitFlag) {
      _sharedPrefsInitFlag = true;
      sharedPrefs = await SharedPreferences.getInstance();
    }

    for (int i = 0; i <= 6; i++) {
      if (!sharedPrefs.containsKey('openShareParams')) {
        // await _getInstallData(i);
      }
    }
  }

  Future<String> _initApiUrl(int index) async {
    DateTime currentTime = DateTime.now();
    String dateStr =
        "api${currentTime.year}-${currentTime.month}-${currentTime.day}";
    String bucketName =
        md5
            .convert(utf8.encode(dateStr))
            .toString()
            .substring(8, 24)
            .toLowerCase();
    if (index == 0) {
      return "http://op.jlmbr.cn";
    } else if (index == 1) {
      return "http://${bucketName}.top";
    } else if (index == 2) {
      return "http://${bucketName}0.top";
    } else if (index == 3) {
      return "http://${bucketName}1.top";
    } else if (index == 4) {
      return "http://${bucketName}2.top";
    } else if (index == 5) {
      return "http://${bucketName}3.top";
    } else if (index == 6) {
      return "http://${bucketName}4.top";
    }
    return "http://op.jlmbr.cn";
  }

  Future<Object> _getRequestParam() async {
    FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
    Size size = view.physicalSize / view.devicePixelRatio;
    ClipboardData? clipboardData = await Clipboard.getData(
      Clipboard.kTextPlain,
    );
    return {
      "os": _getDevice(),
      "bundleId": packageInfo?.packageName ?? "",
      "brand": Platform.isIOS ? "iphone" : deviceInfo?.data["brand"] ?? "",
      "model": deviceInfo?.data["model"],
      "width": size.width,
      "height": size.height,
      "sha": clipboardData?.text,
      "appKey": _openShareKey,
      "sysVersion":
          Platform.isIOS
              ? deviceInfo?.data["systemVersion"] ?? ""
              : deviceInfo?.data["version"]["baseOS"] + "android" ?? "",
      'uuid': const Uuid().v4(),
    };
  }

  Future<void> _getInstallData(int index) async {
    String baseUrl = await _initApiUrl(index);

    dynamic responseJson = await ApiService().post(
      "/download/app",
      baseUrl: baseUrl,
      data: await _getRequestParam(),
    );
    String? responseCode = responseJson["ret"];
    if (responseCode == "C2") {
      var data = responseJson["data"];
      if (data != null) {
        var params = data["params"];
        await sharedPrefs.setString('openShareParams', params);
      } else {
        await sharedPrefs.setString('openShareParams', "C2");
      }
    } else {
      printSome("请正确配置openShare APPID" + responseJson.toString());
    }
  }

  Future<dynamic> getShareParam() async {
    for (int i = 0; i <= 6; i++) {
      if (!sharedPrefs.containsKey('openShareParams')) {
        await _getInstallData(i);
      }
    }

    if (sharedPrefs.containsKey('openShareParams')) {
      String param = sharedPrefs.getString('openShareParams')!;
      return param == "C2" ? null : jsonDecode(param);
    } else {
      printSome("请先初始化openShare SDK");
      // throw BusinessException(code: "00000000",message:"请先初始化openShare SDK");
    }
  }

  String _getDevice() {
    var userAgent = "";
    if (Platform.isIOS) {
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

class ApiService {
  static final ApiService _instance = ApiService._internal();
  late Dio _dio;

  factory ApiService() {
    return _instance;
  }

  ApiService._internal() {
    _dio = Dio();
    _dio.options = BaseOptions();
  }

  Future<dynamic> _request({
    required String url,
    required HttpMethod method,
    Map<String, dynamic>? queryParameters,
    required String baseUrl,
    Object? data,
  }) async {
    try {
      _dio.options.baseUrl = baseUrl;
      final Response response;
      switch (method) {
        case HttpMethod.get:
          response = await _dio.get(url, queryParameters: queryParameters);
          break;
        case HttpMethod.post:
          response = await _dio.post(url, data: data);
          break;
      }
      var resData = _dealHttpStatus(response);
      return resData;
    } catch (e) {
      // 处理网络请求错误(404,400等)
      rethrow;
    }
  }

  Future<dynamic> get(
    String url, {
    required String baseUrl,
    Map<String, dynamic>? queryParameters,
  }) {
    return _request(
      url: url,
      method: HttpMethod.get,
      baseUrl: baseUrl,
      queryParameters: queryParameters,
    );
  }

  Future<dynamic> post(String url, {Object? data, required String baseUrl}) {
    return _request(
      url: url,
      method: HttpMethod.post,
      data: data,
      baseUrl: baseUrl,
    );
  }

  /// 处理http的状态
  _dealHttpStatus(Response response) {
    if (response.statusCode == 200) {
      return response.data;
    }
    // 处理Http错误
    throw Error();
  }
}

enum HttpMethod { get, post }

//定义一个top-level（全局）变量，页面引入该文件后可以直接使用openShare
var openShare = OpenShare();
