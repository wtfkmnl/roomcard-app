import 'package:flutter/foundation.dart';
import 'package:dio/io.dart';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:roomcard/global.dart';
import 'package:roomcard/services/global_data_service.dart';
import 'package:roomcard/utils/Tools.dart';
import 'package:roomcard/utils/commonUtils.dart';
import 'package:roomcard/utils/storage_util.dart';
import 'package:roomcard/utils/values/constants.dart';
import 'am_interceptor.dart';

enum BaseResCode {
  success('C2'),
  tokenExpired('C10'),
  E153('E153'),
  E154('E154'),
  E155('E155'),
  E157('E157'),
  E207('E207'),
  E252('E252'),
  E158('E158');
  // E119("pre119");

  const BaseResCode(this.value);
  final String value;
}

List<String> nextCodes = BaseResCode.values.map((e) => e.value).toList();

class AMHttpService extends GetxService {
  static AMHttpService get to => Get.find();

  late final Dio _dio;

  static String amApiBaseUrl = "";

  @override
  void onInit() {
    super.onInit();

    var headerData = {
      'site': Global.instance.archiveModel.sIte,
      'channelid': Tools.getChannelId(),
      'traceId': Global.instance.traceId,
      'contentType': ContentType.json,
      'user-agent': Tools.getDevice(),
      'game-code': 10000,
    };

    // 初始 dio
    var options = BaseOptions(
      baseUrl: amApiBaseUrl,
      sendTimeout: const Duration(seconds: 20),
      connectTimeout: const Duration(seconds: 20), // 10秒
      receiveTimeout: const Duration(seconds: 20), // 5秒
      headers: headerData,
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

    ///统一处理之前可能需要的操作回调
    Future Function(Response)? originalResponse,
    bool handleResponse = true,
  }) async {
    _dio.options.baseUrl = baseUrl ?? amApiBaseUrl;
    Options requestOptions = options ?? Options();

    requestOptions.extra ??= {};
    requestOptions.extra!["requestParam"] = params;

    // try {
    //   _dio.options.baseUrl = baseUrl ?? amApiBaseUrl;
    //   Response response = await _dio.get(
    //     url,
    //     queryParameters: params,
    //     options: requestOptions,
    //     cancelToken: cancelToken,
    //   );

    //   response =
    //       await CommonUtils.decryptResponse(response: response, url: url);

    //   await originalResponse?.call(response);

    //   return handleResponse ? dealResData(response) : response;
    // } catch (e) {
    //   printSome("$e 网络错误 $url");
    // }

    var encrypt = CommonUtils.encryptRequest(
      url: url,
      baseUrl: _dio.options.baseUrl,
      data: null,
      requestOptions: requestOptions,
    );

    Response response = await _dio.get(
      url,
      queryParameters: params,
      options: encrypt.last,
      cancelToken: cancelToken,
    );

    response = await CommonUtils.decryptResponse(response: response, url: url);

    await originalResponse?.call(response);

    if (handleResponse == false) {
      var responseData =
          response.data is String ? jsonDecode(response.data) : response.data;
      if (responseData['code'] == BaseResCode.tokenExpired.value) {
        // Tools.toNeedLoginPath(() {});
      }
    }

    return handleResponse ? dealResData(response) : response;
  }

  Future<dynamic> post(
    String url, {
    String? baseUrl,
    dynamic data,
    Options? options,
    CancelToken? cancelToken,

    ///统一处理之前可能需要的操作回调
    Future Function(Response)? originalResponse,
    bool handleResponse = true,
  }) async {
    var requestOptions = options ?? Options();
    requestOptions.extra ??= {};
    requestOptions.extra!["requestParam"] = data;
    var encrypt = CommonUtils.encryptRequest(
      url: url,
      baseUrl: _dio.options.baseUrl,
      data: data,
      requestOptions: requestOptions,
    );
    try {
      _dio.options.baseUrl = baseUrl ?? amApiBaseUrl;
      Response response = await _dio.post(
        url,
        data: encrypt.first ?? {},
        options: encrypt.last,
        cancelToken: cancelToken,
      );

      if (url.contains("queryGameListForApp")) {
        response = await CommonUtils.decryptResponse(
          response: response,
          url: url,
        );
      } else {
        response = await CommonUtils.decryptResponse(
          response: response,
          url: url,
        );
      }
      await originalResponse?.call(response);

      if (handleResponse == false) {
        var responseData =
            response.data is String ? jsonDecode(response.data) : response.data;
        if (responseData['code'] == BaseResCode.tokenExpired.value) {
          // Tools.toNeedLoginPath(() {});
        }
      }

      return handleResponse ? dealResData(response) : response;
    } catch (e) {
      if (baseUrl != null) {
        return;
      }
      if (e is DioException) {
        if (e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.sendTimeout ||
            e.type == DioExceptionType.receiveTimeout) {
          // ToastUtils.showToast(msg: "requestTimeout".tr);
          printSome("请求超时 $url");
          return;
        }
      }
      //printSome("网络错误 $url $e");
      //ToastUtils.showToast(msg: "networkError".tr);
      // ToastUtils.showInterErrorDialog();
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

  Future<void> initApiUrl(int? bucketIndex) async {
    if (bucketIndex == null || bucketIndex < 21) {
      final int index = bucketIndex ?? -1;
      String bucketName = "";
      String source = "";
      if (bucketIndex == null) {
        source = Global.instance.archiveModel.sIte!;
      } else {
        source = Global.instance.archiveModel.sIte! + index.toString();
      }

      bucketName = Tools.generateMd5(source).substring(8, 24).toLowerCase();

      //亚洲使用阿里云去获取api地址
      var urlAsia = "https://$bucketName.oss-accelerate.aliyuncs.com";
      //美洲使用亚马逊云去获取地址
      var urlAmerica = "https://$bucketName.s3.sa-east-1.amazonaws.com";

      try {
        dynamic responseJson = await AMHttpService.to.get(
          '/${Global.instance.archiveModel.sIte}.json?t=${DateTime.now().millisecondsSinceEpoch}',
          baseUrl: () {
            //1阿里云2:亚马逊
            if (Global.instance.archiveModel.bUcket == "1") {
              //bv01
              return urlAsia;
            }
            return urlAmerica;
          }(), //bv01 美洲
          handleResponse: false,
        );
        String? content = responseJson.data["content"][0];
        // String? content = "https://api.v5isodz.top/v1/";
        if (content != null && content.isNotEmpty) {
          amApiBaseUrl = content;
          printSome(content);
        } else {
          await initApiUrl(index + 1);
        }
      } catch (e) {
        // printSome("获取接口地址异常");
        await initApiUrl(index + 1);
      }
    }
  }
}

dynamic dealResData(Response response) {
  var responseData =
      response.data is String ? jsonDecode(response.data) : response.data;

  String path = response.requestOptions.path;
  if (nextCodes.contains(responseData['code'])) {
    if (responseData['code'] == BaseResCode.success.value) {
      if (path.contains('getLoginAndRegisterSetting')) {
        bool isAgent =
            response.requestOptions.extra.containsKey("from") &&
            response.requestOptions.extra["from"] == "agent";

        bool isFeedback =
            response.requestOptions.extra.containsKey("from") &&
            response.requestOptions.extra["from"] == "feedback" &&
            response.requestOptions.path.contains("getLoginAndRegisterSetting");
        if (isAgent) {
          //代理的特殊处理
          dealLoginAndRegisterSettingForAgent(response);
        } else if (isFeedback) {
        } else {
          dealLoginAndRegisterSetting(response);
        }
      }
      if (responseData['result'] != null &&
          !path.contains("tc/submitTransferOrder")) {
        return responseData['result'];
      } else {
        return responseData;
      }
    } else if (responseData['code'] == BaseResCode.tokenExpired.value) {
      var msg = "";
      if (path.contains('queryAcctInfo') ||
          path.contains('memberActivityList')) {
        // showLoginRegisterPop();
      } else {
        // msg = Tools.getErrorMsg(responseData['code'], responseData['message']);

        // ToastUtils.showToast(msg: msg);
      }

      if (msg.isNotEmpty) {
        // showErrorModal(
        //   response.requestOptions.headers['uuid'],
        //   msg,
        //   responseData['code'],
        //   path,
        // );
      }

      // Tools.toNeedLoginPath(() {});

      Global.instance.clearData();
      GlobalDataService.instance.clearData();
      GlobalDataService.instance.isLogin = false;
      printSome("========login==????============");
      return null;
    } else {
      return responseData;
    }
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

    if ("pre119" == responseData['code']) {
      //充值订单错误---code":"pre119","message":"存在未完成的订单"
      return responseData;
    } else {
      // ToastUtils.showToast(
      //   msg: msg.replaceFirst("%s", "${responseData["result"] ?? ""}"),
      // );
    }

    return null;
  }
}

dealLoginAndRegisterSetting(Response response) async {
  String path = response.requestOptions.path;
  if (path.contains('getLoginAndRegisterSetting') ||
      path.contains('loginMember') ||
      path.contains('newMember')) {
    String? contentLen = response.headers['content-lengths']?[0];
    await StorageUtil.setString(Constants.storageContentLen, contentLen ?? "");
    Global.instance.registerVerifyType = contentLen?[1];
    Global.instance.loginVerifyType = contentLen?[2];

    String? xAuthToken = response.headers['x-auth-token']?[0];

    printSome("$path : x-auth-token $xAuthToken");

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
  if (path.contains('getLoginAndRegisterSetting') ||
      path.contains('loginMember') ||
      path.contains('newMember')) {
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

///把Code返回 $1 code
(dynamic, dynamic) dealResData2(Response response) {
  var res = dealResData(response);
  var responseData =
      response.data is String ? jsonDecode(response.data) : response.data;
  var code = responseData['code'];
  return (code, res);
}

///测试用
List<String> proxyDevices() {
  return [
    "1b416813-be21-4966-bfd3-db619ec3f8d8",
    "5c47ec9a-1b4d-40a1-9265-d728fb9dc021",
    "d4ed99e5-5263-4a34-a842-6b8fbd7c7ca0",
    "b707a700-1ccb-48c6-bad5-a52adddc0752",
    "ebe1d5ff-ed3e-4814-a066-7e72fb2da4b3",
    "97492c3a-2d7a-4832-98de-1f02ca090446",
  ];
}

///测试用
String proxyIp() {
  return "192.168.10.245:8888";
}
