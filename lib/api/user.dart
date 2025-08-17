import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:roomcard/global.dart';
import 'package:roomcard/models/acct_info_model.dart';
import 'package:roomcard/models/base_res_model.dart';
import 'package:roomcard/models/member_info_model.dart';
import 'package:roomcard/services/am_http.dart';
import 'package:roomcard/services/global_data_service.dart';
import 'package:roomcard/utils/Tools.dart';
import 'package:roomcard/utils/commonUtils.dart';
import 'package:roomcard/utils/storage_util.dart';
import 'package:roomcard/utils/values/constants.dart';

import '../models/business_model.dart';

class UserApi {
  /// 发送短信
  static Future<BaseResModel?> sySms({dynamic data, Options? options}) async {
    var res = await AMHttpService.to.post(
      '/sy/sms',
      data: data,
      options: options,
    );
    if (res != null) {
      var model = BaseResModel.fromJson(res);
      return model;
    }
    return null;
  }

  static Future<BaseResModel?> syEmailSms({
    dynamic data,
    Options? options,
  }) async {
    var res = await AMHttpService.to.post(
      '/sy/mail/code',
      data: data,
      options: options,
    );
    if (res != null) {
      var model = BaseResModel.fromJson(res);
      return model;
    }
    return null;
  }

  /// 用户登陆
  static Future<MemberInfoModel?> loginMember(data) async {
    data['channelId'] = Tools.getChannelId();
    Global.instance.spToken = '';
    Global.instance.platformAcct = '';
    var res = await AMHttpService.to.post('/mc/loginMember', data: data);
    if (res != null) {
      var model = MemberInfoModel.fromJson(res);
      Global.instance.memberInfo = model;
      return model;
    }
    return null;
  }

  /// 用户注册
  static Future<MemberInfoModel?> newMember(data) async {
    data['channelId'] = Tools.getChannelId();
    var res = await AMHttpService.to.post('/mc/loginMember', data: data);
    if (res != null) {
      return MemberInfoModel.fromJson(res);
    }
    return null;
  }

  /// 用户注册
  static Future<MemberInfoModel?> register(data) async {
    data['channelId'] = Tools.getChannelId();
    var res = await AMHttpService.to.post('/mc/newMember', data: data);
    if (res != null) {
      // Global.instance.initData(true);
      return MemberInfoModel.fromJson(res);
    }
    return null;
  }

  /// 一键注册
  static Future<MemberInfoModel?> clickRegister(data) async {
    data['channelId'] = Tools.getChannelId();
    var res = await AMHttpService.to.post('/simple/newMember', data: data);
    if (res != null) {
      // Global.instance.initData(true);
      return MemberInfoModel.fromJson(res);
    }
    return null;
  }

  ///用户信息
  static Future<MemberInfoModel> getMemberInfo() async {
    var res = await AMHttpService.to.post('/mc/selectMember', data: {});

    MemberInfoModel memberInfo = MemberInfoModel.fromJson(res ?? {});
    StorageUtil.setString(Constants.storageMemberInfo, jsonEncode(memberInfo));
    Global.instance.memberInfo = memberInfo;
    return memberInfo;
  }

  /// 查询账户信息 queryAllInfo = true 指定使用queryAcctInfo 获取所有币种信息
  static Future<AcctInfoModel?> queryAcctInfo({bool? queryAllInfo}) async {
    var spTokenCheck =
        Global.instance.spToken != null && Global.instance.spToken!.isNotEmpty;
    if (queryAllInfo == true) {
      spTokenCheck = false;
    }
    var res = await AMHttpService.to.post(
      spTokenCheck ? '/gc/queryPlatformBalance' : '/acct/queryAcctInfo',
      data: spTokenCheck
          ? {
              "languageCode": CommonUtils.currentLanguage().languageCode,
              "platformCode": "IM_TY",
              "memberRowId": GlobalDataService.instance.accountInfo.memberRowId,
              "targetCurrency": 'CNY',
            }
          : {},
    );
    if (res != null) {
      if (spTokenCheck) {
        // GlobalDataService.instance.accountInfo.balance = res;
        return res;
      }
      var model = AcctInfoModel.fromJson(res);
      GlobalDataService.instance.accountInfo = model;
      // if (model.currency != null) {
      //   var currency = Tools.getCurrencyMap(model.currency!);
      //   var myCurrency = CommonUtils.myCurrencyList();
      //   var supportedCurrency = CommonUtils.getSupportCurrency();
      //   if (supportedCurrency.contains(currency) &&
      //       !myCurrency.contains(currency)) {
      //     myCurrency.add(currency);
      //     Storage().setList(
      //       Constants.currencyList,
      //       myCurrency.map((e) => e.type).toList(),
      //     );
      //   }
      // }
      // if (Global.instance.memberInfo == null) {
      //   var memberInfo = Storage().getString(Constants.storageMemberInfo);
      //   if (memberInfo.isNotEmpty) {
      //     try {
      //       Global.instance.memberInfo = MemberInfoModel.fromJson(
      //         jsonDecode(memberInfo),
      //       );
      //     } catch (e) {
      //       printSome(e);
      //     }
      //   }
      // }

      return model;
    }
    return null;
  }

  // // 查询账户交易记录
  // static Future<AcctHisModel?> queryAcctHisPage(
  //   Map<String, dynamic> data,
  // ) async {
  //   var res = await AMHttpService.to.post('/acct/queryAcctHisPage', data: data);
  //   if (res != null) {
  //     return AcctHisModel.fromJson(res);
  //   }
  //   return null;
  // }

  // // 充值记录 提现记录
  // static Future<PayHisModel?> queryPayOrderPage(
  //   Map<String, dynamic> data,
  // ) async {
  //   var res = await AMHttpService.to.post('/pc/queryPayOrderPage', data: data);
  //   if (res != null) {
  //     return PayHisModel.fromJson(res);
  //   }
  //   return null;
  // }

  // // 获取未完成的订单
  // static Future<List<PaddingOrder>> pendingPayOrder() async {
  //   var res = await AMHttpService.to.post('/pc/pendingPayOrder');
  //   if (res != null && res is List) {
  //     return res.map((e) => PaddingOrder.fromJson(e)).toList();
  //   }
  //   return [];
  // }

  // 会员退出
  static Future<void> loginOut() async {
    await AMHttpService.to.post('/sys/loginOut');
  }

  // // 获取会员当前等级信息
  // static Future<MyVipInfoModel?> myVipInfo() async {
  //   var res = await AMHttpService.to.post('/vp/myVipInfo');
  //   if (res != null) {
  //     var model = MyVipInfoModel.fromJson(res);
  //     // var defaultCurrency = CommonUtils.getDefaultCurrency().type;
  //     // var currentCurrency = CommonUtils.getCurrentSelectCurrency().type;

  //     // model.betAmount = CommonUtils.exchangeAmount(
  //     //     model.betAmount?.toDouble() ?? 0, defaultCurrency, currentCurrency);

  //     return model;
  //   }
  //   return null;
  // }

  // // VIP福利检查
  // static Future<VipBounsInfoModel?> getVipInfo() async {
  //   var res = await AMHttpService.to.post('/vp/getVipInfo');

  //   if (res != null) {
  //     var model = VipBounsInfoModel.fromJson(res);
  //     return model;
  //   }
  //   return null;
  // }

  // VIP日积分领取
  static Future<bool> dayPoints() async {
    var res = await AMHttpService.to.post('/vp/dayPoints');
    return res['code'] == "C2";
  }

  // VIP周积分领取
  static Future<bool> weekPoints() async {
    var res = await AMHttpService.to.post('/vp/weekPoints');
    return res['code'] == "C2";
  }

  // VIP月积分领取
  static Future<bool> monthPoints() async {
    var res = await AMHttpService.to.post('/vp/monthPoints');
    return res['code'] == "C2";
  }

  // VIP晋级积分领取
  static Future<bool> upgradedPoints() async {
    var res = await AMHttpService.to.post('/vp/upgradedPoints');
    return res != null;
  }

  // 货币互转
  static Future<Map<String, dynamic>?> walletBalanceChange(
    Map<String, dynamic> data,
  ) async {
    var res = await AMHttpService.to.post(
      '/acct/walletBalanceChange',
      data: data,
    );
    return res;
  }

  static Future<bool> modifyMemberInfo(dynamic request) async {
    try {
      var res = await AMHttpService.to.post(
        '/mc/modifyMemberInfo',
        data: request,
      );
      printSome("返回内容----$res");
      return res['code'] == "C2";
    } catch (e) {
      return false;
    }
  }

  static Future<bool> modifyMemberTelePhone(dynamic request) async {
    try {
      var res = await AMHttpService.to.post(
        '/mc/modifyMemberTelePhone',
        data: request,
      );
      return res['code'] == "C2";
    } catch (e) {
      return false;
    }
  }

  static Future<bool> modifyMemberEmail(dynamic request) async {
    try {
      var res = await AMHttpService.to.post(
        '/mc/modifyMemberEmail',
        data: request,
      );
      return res['code'] == "C2";
    } catch (e) {
      return false;
    }
  }

  static Future<bool> checkSms(dynamic request) async {
    try {
      var res = await AMHttpService.to.post('/sy/checkSms', data: request);
      return res['code'] == "C2";
    } catch (e) {
      return false;
    }
  }

  static Future<bool> checkEmailSms(dynamic request) async {
    try {
      var res = await AMHttpService.to.post(
        '/sy/mail/checkCode',
        data: request,
      );
      return res['code'] == "C2";
    } catch (e) {
      return false;
    }
  }

  static Future<bool> changeWallet(String currency) async {
    try {
      var res = await AMHttpService.to.post(
        '/acct/changeWallet',
        data: {"currency": currency},
      );
      return res['code'] == "C2";
    } catch (e) {
      return false;
    }
  }

  // 重置密码
  static Future resetPassword({
    required String smsCode,
    required String telephone,
    required String areaCode,
    required String memberPwd,
    required String memberId,
  }) async {
    var res = await AMHttpService.to.post(
      '/mc/resetPassword',
      data: {
        "smsCode": smsCode,
        "telephone": telephone,
        "areaCode": areaCode,
        "memberPwd": memberPwd,
        "memberId": memberId,
      },
    );
    return res['code'] == "C2";
  }

  static Future<String?> uploadImg({required File imageFile}) async {
    var formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(imageFile.path),
    });
    var responseStr = await AMHttpService.to.post(
      '/picture/upload',
      data: formData,
    );
    return responseStr;
  }

  static Future<BaseResModel?> getBusinessList() async {
    try {
      var res = await AMHttpService.to.post('/bc/queryList');
      if (res != null) {
        return BaseResModel.fromJson(res);
      }
      return null;
    } catch (e) {
      throw Exception('获取商务合作列表失败: $e');
    }
  }
}
