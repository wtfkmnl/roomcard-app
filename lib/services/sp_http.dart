import 'package:flutter/foundation.dart';
import 'package:dio/io.dart';

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:roomcard/global.dart';
import 'package:roomcard/services/am_http.dart';
import 'package:roomcard/services/config.dart';
import 'package:roomcard/services/global_data_service.dart';
import 'package:roomcard/utils/Tools.dart';
import 'package:roomcard/utils/commonUtils.dart';
import 'package:roomcard/utils/storage_util.dart';
import 'package:roomcard/utils/values/constants.dart';

import 'am_interceptor.dart';

List<String> nextCodes = BaseResCode.values.map((e) => e.value).toList();

class SPHttpService extends GetxService {
  static SPHttpService get to => Get.find();

  late final Dio _dio;

  @override
  void onInit() {
    super.onInit();

    // 初始 dio
    var options = BaseOptions(
      baseUrl: AMHttpService.amApiBaseUrl,
      connectTimeout: const Duration(seconds: 10), // 10秒
      receiveTimeout: const Duration(seconds: 5), // 5秒
      headers: {
        // 'site': Constants.site, //'ZgQkMM7J',
        // 'channelid': '4',
        // 'traceId': Global.instance.traceId,
        // 'content-type': 'application/json;charset=UTF-8',
        // 'user-agent': Tools.getDevice(),
        // 'Uuid': const Uuid().v4(),
        'Bundleid': ConfigService.instance.platform?.packageName ?? "",
        'site': Global.instance.archiveModel.sIte,
        'channelid': Tools.getChannelId(),
        'traceId': Global.instance.traceId,
        'contentType': ContentType.json,
        'user-agent': Tools.getDevice(),
        'LanguageCode': CommonUtils.currentLanguage().languageCode,
      },
    );
    _dio = Dio(options);

    // 拦截器
    _dio.interceptors.add(RequestInterceptors());

    ///测试用代码 对特定设备有效，不影响其它设备和打包
    if (kDebugMode) {
      _configProxy();
    }
  }

  Future<dynamic> get(
    String url, {
    String? baseUrl,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
    bool handleResponse = true,
  }) async {
    Options requestOptions = options ?? Options();
    try {
      _dio.options.baseUrl = baseUrl ?? AMHttpService.amApiBaseUrl;
      Response response = await _dio.get(
        url,
        queryParameters: params,
        options: requestOptions,
        cancelToken: cancelToken,
      );

      response = await CommonUtils.decryptResponse(
        response: response,
        url: url,
      );

      return handleResponse ? dealResData(response) : response;
    } catch (e) {
      // printSome("$e 网络错误 $url");
    }
  }

  Future<dynamic> post(
    String url, {
    String? baseUrl,
    dynamic data,
    Options? options,
    CancelToken? cancelToken,
    bool handleResponse = true,
  }) async {
    var requestOptions = options ?? Options();
    var encrypt = CommonUtils.encryptRequest(
      url: url,
      baseUrl: _dio.options.baseUrl,
      data: data,
      requestOptions: requestOptions,
      forceEncrypt: true,
    );

    try {
      _dio.options.baseUrl = baseUrl ?? AMHttpService.amApiBaseUrl;
      Response<dynamic> response = await _dio.post(
        url,
        data: encrypt.first ?? {},
        options: encrypt.last,
        cancelToken: cancelToken,
      );

      var text = utf8.decode(response.data ?? []);
      var js = json.decode(text);
      response.data = js;
      response = await CommonUtils.decryptResponse(
        response: response,
        url: url,
      );

      return handleResponse ? dealResData(response) : response;
    } catch (e) {
      if (baseUrl != null) {
        return;
      }
      //printSome("网络错误 $url");
      //ToastUtils.showToast(msg: "networkError".tr);
    }
  }

  void _configProxy() {
    if (!kDebugMode) {
      return;
    }

    ///特定设备信息
    if (!proxyDevices().contains(Global.instance.traceId)) {
      return;
    }
    printSome("已设置代理");

    var adapter = _dio.httpClientAdapter as IOHttpClientAdapter;
    adapter.createHttpClient = () {
      var client = HttpClient();
      client.findProxy = (uri) {
        return "PROXY ${proxyIp()}";
      };
      client.badCertificateCallback = (cert, host, port) {
        return true;
      };
      return client;
    };
  }
}

dealLoginAndRegisterSetting(Response response) async {
  String path = response.requestOptions.path;
  if (path.contains('getLoginAndRegisterSetting')) {
    String? contentLen = response.headers['content-lengths']?[0];
    await StorageUtil.setString(Constants.storageContentLen, contentLen ?? "");

    Global.instance.registerVerifyType = contentLen?[1];
    Global.instance.loginVerifyType = contentLen?[2];

    String? xAuthToken = response.headers['x-auth-token']?[0];

    if (xAuthToken != null) {
      String last = contentLen!.substring(contentLen.length - 1);
      String auth = xAuthToken.replaceAll(last, '');
      String authorization = Tools.generateMd5(auth);

      Global.instance.contentLen = contentLen;
      Global.instance.xAuthToken = xAuthToken;
      Global.instance.authorization = authorization;

      await StorageUtil.setString(Constants.storageXAuthToken, xAuthToken);
      await StorageUtil.setString(
        Constants.storageAuthorization,
        authorization,
      );
    }
  }
}

dealLoginAndRegisterSettingForAgent(Response response) async {
  String path = response.requestOptions.path;
  if (path.contains('getLoginAndRegisterSetting')) {
    String? contentLen = response.headers['content-lengths']?[0];
    String? xAuthToken = response.headers['x-auth-token']?[0];

    if (xAuthToken != null) {
      String last = contentLen!.substring(contentLen.length - 1);
      String auth = xAuthToken.replaceAll(last, '');
      String authorization = Tools.generateMd5(auth);

      await StorageUtil.setString(Constants.storageXAuthTokenAgent, xAuthToken);
      await StorageUtil.setString(
        Constants.storageAuthorizationAgent,
        authorization,
      );
    }
  }
}

dynamic dealResData(Response response) {
  // Map<String, dynamic> resData = json.decode(utf8.decode(response.data ?? []));
  Map<String, dynamic> resData = response.data;
  var responseData = resData;
  print("=====11111===33333");
  if (response.statusCode == 200) {
    if (response.requestOptions.path.contains('imsbBet/getPopularity') ||
        response.requestOptions.path.contains('imsbBet/updatePopularity')) {
      return responseData;
    }
  }
  if (responseData["StatusCode"].toString() == "700") {
    Global.instance.imTyService = true;
    return responseData;
  }

  String path = response.requestOptions.path;
  Global.instance.imTyService = false;

  if (responseData['code'] == BaseResCode.success.value) {
    if (path.contains('getLoginAndRegisterSetting')) {
      bool isAgent =
          response.requestOptions.extra.containsKey("from") &&
          response.requestOptions.extra["from"] == "agent";
      if (isAgent) {
        //代理的特殊处理
        dealLoginAndRegisterSettingForAgent(response);
      } else {
        dealLoginAndRegisterSetting(response);
      }
    }
    if (responseData['result'] != null) {
      return responseData['result'];
    } else {
      return responseData;
    }
  } else if (responseData['code'] == BaseResCode.tokenExpired.value) {
    if (path.contains('queryAcctInfo')) {
      // showLoginRegisterPop();
    } else {
      // String msg = Tools.getErrorMsg(
      //   responseData['code'],
      //   responseData['message'],
      // );
      // showErrorModal(
      //   response.requestOptions.headers['uuid'],
      //   msg,
      //   responseData['code'],
      //   path,
      // );
      // ToastUtils.showToast(msg: msg);
    }

    Global.instance.clearData();
    GlobalDataService.instance.clearData();
    // Global.instance.initData(false);
    // MainController mainController = Get.find<MainController>();
    // if (mainController.currentIndex == 2 || mainController.currentIndex == 1) {
    //   mainController.onJumpToPage(0);
    // }
    return null;
  } else {
    return responseData;
  }
}
