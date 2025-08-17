import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as GET;
import 'package:roomcard/global.dart';
import 'package:roomcard/utils/Tools.dart';
import 'package:roomcard/utils/commonUtils.dart';
import 'package:roomcard/utils/storage_util.dart';
import 'package:roomcard/utils/values/constants.dart';
import 'package:uuid/uuid.dart';

List<String> _needAuthPaths = [
  '/mc/loginMember',
  '/mc/newMember',
  '/simple/newMember',
  '/mc/selectMember',
];

/// 拦截
class RequestInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers["uuid"] = const Uuid().v4();
    options.headers["languagecode"] = Tools.getCurLanguage().languageCode;

    debugPrint("==uuid======${options.headers["uuid"]} ====${options.path} ");

    if (options.extra.containsKey("from") && options.extra["from"] == "agent") {
      ///代理开户特殊处理
      bool isAgentRegist = options.path.contains("/mc/newMember");
      bool isAgentSms = options.path.contains("/sy/sms");

      var authorization = StorageUtil.getString(
        Constants.storageAuthorizationAgent,
      );
      var xAuthToken = StorageUtil.getString(Constants.storageXAuthTokenAgent);

      if (isAgentRegist) {
        if (authorization.isNotEmpty) {
          options.headers["authorization"] = authorization;
        }

        if (isAgentRegist || isAgentSms) {
          if (xAuthToken.isNotEmpty) {
            options.headers["x-auth-token"] = xAuthToken;
          }
        }
      }

      return handler.next(options);
    }

    if (options.extra.containsKey("from") &&
        options.extra["from"] == "feedback" &&
        options.path.contains("getLoginAndRegisterSetting")) {
      return handler.next(options);
    }

    if (Global.instance.xAuthToken != null) {
      options.headers["x-auth-token"] = Global.instance.xAuthToken;
    }

    if (_needAuthPaths.contains(options.path)) {
      options.headers["authorization"] = Global.instance.authorization;
    }
    // print("==headers======${options.headers}");
    return handler.next(options);
  }

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    // 200 请求成功, 201 添加成功
    printSome("返回内容----$response");

    if (response.statusCode != 200 && response.statusCode != 201) {
      handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          response: response,
        ),
        true,
      );
    }
    handler.next(response);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // var exception = HttpException(err.message ?? "");
    if (err.response?.statusCode == 502) {
      // if (!Global.instance.didShowMaintenanceAlert) {
      //   Global.instance.didShowMaintenanceAlert = true;
      //   await showDialog(
      //     barrierDismissible: kDebugMode ? true : false,
      //     context: GET.Get.context!,
      //     builder: (context) {
      //       var time = DateTime.now().add(const Duration(hours: 1)).millisecondsSinceEpoch;

      //       return MaintenanceAlert(
      //         maintenanceTime: dateFormatMillSecond(format: "yyyy-MM-dd HH:mm", dateStamp: time),
      //       );
      //     },
      //   );
      //   Global.instance.didShowMaintenanceAlert = false;
      // }
    }
    switch (err.type) {
      case DioException.badResponse:
      // break;
      case DioException.connectionError:
      // break;
      case DioException.connectionTimeout:
      // break;
      case DioException.receiveTimeout:
      // break;
      case DioException.sendTimeout:
      // break;
      default:
        handler.next(err);
        break;
    }
  }
}
