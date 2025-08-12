import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:roomcard/global.dart';
import 'package:roomcard/models/app_config_model/index.dart';
import 'package:roomcard/models/global_dic_model.dart';
import 'package:roomcard/models/login_regist/index.dart';
import 'package:roomcard/services/am_http.dart';
import 'package:roomcard/services/global_data_service.dart';
import 'package:roomcard/utils/commonUtils.dart';
import 'package:roomcard/utils/storage_util.dart';
import 'package:roomcard/utils/values/constants.dart';

class AppConfigApi {
  /// 查询站点配置信息
  static Future<AppConfigModel?> dlicgh() async {
    var res = await AMHttpService.to.post('/sy/dlicgh');
    if (res != null) {
      Global.instance.dicModel = GlobalDicModel.fromJson(res);
      debugPrint("图片前缀 ${Global.instance.dicModel?.baseSiteConfig?.ossDomain}");
      // Global.instance.noEncryPath = Global.instance.dicModel?.data_encry_decry_path?.split(",") ?? []; // 已去除
      var timeZoneId = Global.instance.dicModel?.baseSiteConfig?.timeZoneId;
      if (timeZoneId != null &&
          !GlobalDataService.instance.timeZoneOffsetFlag) {
        GlobalDataService.instance.timeZoneOffsetFlag = true;
        var milliseconds = await CommonUtils.getTimeZoneOffset(timeZoneId);
        GlobalDataService.instance.timeZoneOffset -= Duration(
          milliseconds: milliseconds,
        );
        printSome(
          "新的时区偏移 ${GlobalDataService.instance.timeZoneOffset.inHours}",
        );
      }

      return AppConfigModel.fromJson(res);
    }
    return null;
  }

  // 登陆注册设置
  static Future<LoginRegisterSettingModel?> getLoginAndRegisterSetting({
    Options? options,
  }) async {
    var res = await AMHttpService.to.post(
      '/ad/getLoginAndRegisterSetting',
      options: options,
    );
    printSome("loginsetting----->$res");
    if (res != null) {
      var model = LoginRegisterSettingModel.fromJson(res);
      StorageUtil.setInt(Constants.storageSysAuthType, model.sysAuthType ?? 0);
      Global.instance.loginRegisterSettingModel = model;
      return model;
    }
    return null;
  }
}
