import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

// import 'package:app_settings/app_settings.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:roomcard/api/app_config.dart';
import 'package:roomcard/api/user.dart';
import 'package:roomcard/global.dart';
import 'package:roomcard/models/login_regist/index.dart';
import 'package:roomcard/models/member_info_model.dart';
import 'package:roomcard/r.dart';
import 'package:roomcard/services/global_data_service.dart';
import 'package:roomcard/utils/Tools.dart';
import 'package:roomcard/utils/commonUtils.dart';
import 'package:roomcard/utils/common_extension/common_extension.dart';
import 'package:roomcard/utils/keyboard_extension.dart';
import 'package:roomcard/utils/mixin/captcha.dart';
import 'package:roomcard/utils/storage_util.dart';
import 'package:roomcard/utils/top_toast.dart';
import 'package:roomcard/utils/values/constants.dart';
import 'package:roomcard/utils/values/country.dart';
import 'package:roomcard/utils/values/enums.dart';

class LoginTabItem {
  String? name;
  int? value;
  String? images;
  bool? isSelected;
  LoginTabItem({this.name, this.value, this.images, this.isSelected = false});
}

class TabItem {
  String? name;
  String? images;
  bool? isSelected;
  int? value;
  TabItem({this.name, this.images, this.value, this.isSelected});
}

class LoginRigistController extends GetxController
    with CaptchaMixin, GetTickerProviderStateMixin {
  //账号密码登录
  late final TextEditingController accountTEC = TextEditingController();
  late final TextEditingController psdTEC = TextEditingController();
  //电话号码登录
  late final TextEditingController phoneLoginTEC = TextEditingController();
  late final TextEditingController phoneCodeLoginTEC = TextEditingController();

  //电话号码注册
  late final TextEditingController phoneRegistTEC = TextEditingController();
  late final TextEditingController phoneCodeRegistTEC = TextEditingController();

  // 邀请码
  late final TextEditingController inviteCodeTEC = TextEditingController();
  // 姓名
  late final TextEditingController memberNameTEC = TextEditingController();
  // 账户注册手机号
  late final TextEditingController accountPhoneTEC = TextEditingController();

  //账号注册
  late final TextEditingController accountRegistTEC = TextEditingController();
  late final TextEditingController psdRegistTEC = TextEditingController();
  late final TextEditingController configPsdTEC = TextEditingController();
  late final CustomPopupMenuController decimalMemuController =
      CustomPopupMenuController();

  final statusFilterOpen = false.obs;

  List<LoginTabItem> loginTitle = [
    LoginTabItem(name: "一键注册", value: 3, isSelected: false),
    LoginTabItem(name: "登录", value: 0, isSelected: true),
    LoginTabItem(name: "注册", value: 1, isSelected: false),
  ];

  List<TabItem> tabs = [
    TabItem(
      images: R.assetsImagesLoginAccountIcon,
      name: '账号登录',
      value: 0,
      isSelected: true,
    ),
    TabItem(
      images: R.assetsImagesLoginPhoneIcon,
      name: '手机登录',
      value: 1,
      isSelected: false,
    ),
  ];

  /// 登录注册配置
  final _loginRegistConfigInfos = LoginRegisterSettingModel.fromJson({}).obs;
  LoginRegisterSettingModel get loginRegistConfigInfos =>
      _loginRegistConfigInfos.value;
  set loginRegistConfigInfos(LoginRegisterSettingModel value) =>
      _loginRegistConfigInfos.value = value;

  LoginTabItem loginTab = LoginTabItem(name: "登录", value: 0);
  LoginTabItem registerTab = LoginTabItem(name: "注册", value: 1);
  LoginTabItem clickRegisterTab = LoginTabItem(name: "一键注册", value: 3);

  final selectedType = LoginTabItem(name: "登录", value: 0).obs;
  // 注册的输入框是否已经输入完成
  final resgiterInputFinish = false.obs;
  // 登录的输入框是否已经输入完成
  final loginInputFinish = false.obs;
  var invitationCode = "";
  String currency = "";
  LanguageType language = Tools.getCurLanguage();

  RxInt codeIndexs = 0.obs;
  List<Country> countryData = Country.values;

  RxBool isRememberPwd = false.obs;

  var memberIdRandom = "";
  var memberPwdRandom = "";

  RxList accountList = [].obs;
  RxInt accountIndex = 0.obs;

  final tabContentList = <Widget>[].obs;

  // final canSubmit = false.obs;
  final loginCanSubmit = false.obs;
  final registerCanSubmit = false.obs;

  var obscureText = false;
  var obscureText1 = true;
  var obscureText2 = true;

  @override
  void onInit() async {
    super.onInit();
    // loginTitle = [LoginTabItem(name: "登录", value: 0, isSelected: true)];
    // OpenshareDataHandle.handleData();

    ever(selectedType, (val) {
      setSubmitState();
    });
  }

  @override
  void onReady() async {
    super.onReady();

    // requestConfigInfo();

    isRememberPwd.value =
        await StorageUtil.getBool(Constants.storageRememberPassword) ?? false;
    placeStorgeAccountPassword();
    update();
  }

  Future<LoginRegisterSettingModel?> requestConfigInfo() async {
    // ToastUtils.showLoading();
    var model = await AppConfigApi.getLoginAndRegisterSetting();
    // ToastUtils.hideLoading();
    if (model == null) {
      return null;
    }
    loginRegistConfigInfos = model;
    model.registerMethod!.forEach((el) {
      if (el == registerTab.value) {
        if (!loginTitle.contains(registerTab)) {
          loginTitle.add(registerTab);
        }
      }
      if (el == clickRegisterTab.value) {
        if (!loginTitle.contains(clickRegisterTab)) {
          loginTitle.add(clickRegisterTab);
        }
      }
    });

    return model;
  }

  bool accountPhoneEnable() {
    if (loginRegistConfigInfos.registerAccountType == 1) {
      return true;
    }
    return loginRegistConfigInfos.phone?.enable ?? false;
  }

  bool accountPhoneRequired() {
    if (loginRegistConfigInfos.registerAccountType == 1) {
      return true;
    }
    return loginRegistConfigInfos.phone?.required ?? false;
  }

  bool invitationCodeEnable() {
    return loginRegistConfigInfos.invitationCode?.enable ?? false;
  }

  bool invitationCodeRequired() {
    return loginRegistConfigInfos.invitationCode?.required ?? false;
  }

  bool memberNameEnable() {
    return loginRegistConfigInfos.memberName?.enable ?? false;
  }

  bool memberNameRequired() {
    return loginRegistConfigInfos.memberName?.required ?? false;
  }

  void switchUIType(LoginTabItem tabItem) {
    KeyboardHelper.close(Get.context);
    selectedType.value = tabItem;
    placeStorgeAccountPassword();
    update();
  }

  void switchLonginType(bool isLogin) {
    KeyboardHelper.close(Get.context);

    // if (isLogin) {
    //   loginType.value = !loginType.value;
    // } else {
    //   registType.value = !registType.value;
    // }
    update();
  }

  remberMemberAccountAndPassWord() {
    isRememberPwd.value = !isRememberPwd.value;
    CommonUtils.rememberPassword(isRememberPwd.value);
    update();
  }

  // 存储的账号密码显示到界面上

  Future<void> placeStorgeAccountPassword({bool removeInView = true}) async {
    // 只有在记住密码选项开启时执行
    if (isRememberPwd.value == true || removeInView) {
      // 获取存储的账号密码列表
      var list = await StorageUtil().getMemberAccountPsd();

      // 根据登录时间排序，最近登录的排在前面
      list.sort((a, b) {
        // 如果包含loginTime字段，则按时间排序
        if (a.containsKey('loginTime') && b.containsKey('loginTime')) {
          // 降序排列，最新的在前面
          return DateTime.parse(
            b['loginTime'],
          ).compareTo(DateTime.parse(a['loginTime']));
        }
        // 如果只有一个元素有loginTime，有loginTime的排前面
        else if (a.containsKey('loginTime')) {
          return -1;
        } else if (b.containsKey('loginTime')) {
          return 1;
        }
        // 都没有loginTime，保持原顺序
        return 0;
      });

      // 更新全局账号列表
      accountList.value = list;

      // 如果需要，更新界面上的账号密码输入框
      if (removeInView && list.isNotEmpty) {
        accountTEC.text = list.first["account"] ?? "";
        psdTEC.text = list.first["password"] ?? "";
      }
      setSubmitState();
      // 通知UI更新
      update();
    }
  }

  selectAccountIndex(int index) {
    accountIndex.value = index;
    accountTEC.text =
        accountList.isNotEmpty ? accountList[index]["account"] : "";
    psdTEC.text = accountList.isNotEmpty ? accountList[index]["password"] : "";
    update();
  }

  void memberWithloginOrregist() {
    if (selectedType.value.value == loginTab.value) {
      beforLogin();
    } else {
      regist(selectedType.value.value == clickRegisterTab.value);
    }
  }

  String generateUniqueId() {
    // 获取当前时间戳并转为32进制，取后4位
    String timestamp32 = DateTime.now().millisecondsSinceEpoch
        .toRadixString(32)
        .substring(
          DateTime.now().millisecondsSinceEpoch.toRadixString(32).length - 4,
        );

    // 生成一个随机数并转为32进制，取4位
    String random32 = (DateTime.now().microsecondsSinceEpoch % 100000)
        .toRadixString(32)
        .padLeft(4, '0');

    // 返回合并后的结果
    return (timestamp32 + random32).toUpperCase();
  }

  ///登录前 判断是否需要网易验证
  beforLogin() {
    if (Global.instance.loginVerifyType == VerifyType.wangyi.value) {
      initCaptchaPlugin(languageCode: LanguageType.pt.languageCode);
      captchaPlugin.showCaptcha(
        onSuccess: (data) {
          var validateCode = data["validate"];
          captchaPlugin.destroyCaptcha();
          login(validateCode: validateCode);
        },
      );
      return;
    }
    login();
  }

  Future login({dynamic validateCode}) async {
    // if (loginType.value == false) {
    if (accountTEC.text.isEmpty) {
      // ToastUtils.showToast(msg: "inputMemberId".tr);
      return;
    }

    if (psdTEC.text.isEmpty) {
      // ToastUtils.showToast(msg: "inputAcctPwd".tr);
      return;
    }

    var params = {
      "memberId": accountTEC.text,
      "memberPwd": psdTEC.text.md5Value(),
      "requestMethod": 0,
    };
    if (validateCode != null) {
      params["validateCode"] = validateCode;
    }
    var model = await UserApi.loginMember(params);
    if (model == null) {
      return;
    }
    await loginSucces(
      memberInfo: model,
      account: accountTEC.text,
      password: psdTEC.text,
    );
    // SharedEventBus.eventBus.fire(ShowLetterNoticeAlert());
    // SharedEventBus.eventBus.fire(
    //   LoginSuccessEvent(
    //     hasBindPhone: model.telephone != null && model.telephone!.isNotEmpty,
    //   ),
    // );
  }

  selectedAreaCode(int index) {
    codeIndexs.value = index;
    update();
  }

  Future regist(bool oneClickRegistration) async {
    Map<String, dynamic> params;

    if (oneClickRegistration) {
      memberIdRandom = generateUniqueId();
      memberPwdRandom = generateUniqueId();
      params = {
        "memberId": memberIdRandom,
        "memberPwd": Tools.generateMd5(memberPwdRandom),
        "telephone": "",
        "smsCode": "",
        "requestMethod": -1,
        "memberName": "",
      };
    } else {
      if (tabs.firstWhere((e) => e.isSelected!).value == 0) {
        ///账号注册

        if (psdRegistTEC.text.isEmpty) {
          // ToastUtils.showToast(msg: "inputAcctPwd".tr);
          return;
        }

        if (!isMatchAccountValidateInput(accountRegistTEC.text)) {
          // ToastUtils.showToast(msg: "账号格式不正确".tr);
          return;
        }

        if (psdRegistTEC.text.isEmpty) {
          // ToastUtils.showToast(msg: "inputAcctPwd".tr);
          return;
        }

        if (!isMatchPwdValidateInput(psdRegistTEC.text)) {
          // ToastUtils.showToast(msg: "loginPasswordLimit".tr);
          return;
        }

        if (psdRegistTEC.text != configPsdTEC.text) {
          // ToastUtils.showToast(msg: "agTwoPasswordsAreInconsistent".tr);
          return;
        }
      } else {
        if (!RegExp(r'^1[3-9]\d{9}$').hasMatch(phoneRegistTEC.text)) {
          // ToastUtils.showToast(msg: "请输入正确的手机号".tr);
          TopToast().show(
            Get.context!,
            message: "请输入正确的手机号",
            icon: Icons.error,
            iconColor: Colors.red,
          );
          return;
        }

        if (phoneCodeRegistTEC.text.isEmpty) {
          return;
        }
      }

      // // if (memberNameRequired()) {
      // //   // ToastUtils.showToast(msg: "请输入姓名".tr);
      // //   return;
      // // }
      // if (invitationCodeRequired()) {
      //   // ToastUtils.showToast(msg: "请输入邀请码".tr);
      //   return;
      // }

      var inviteCode = inviteCodeTEC.text;
      if (inviteCode.isEmpty) {
        // inviteCode = Global.instance.openShareDataModel.invitationCode;
      }

      params =
          tabs.firstWhere((e) => e.isSelected!).value == 0
              ? {
                "memberId": accountRegistTEC.text,
                "memberPwd": Tools.generateMd5(psdRegistTEC.text),
                "telephone": '',
                "smsCode": '',
                "requestMethod": 0,
                "memberName": memberNameTEC.text,
                "invitationCode": inviteCode,
              }
              : {
                "memberId": phoneRegistTEC.text,
                "memberPwd": '', //Tools.generateMd5(psdRegistTEC.text),
                "telephone": phoneRegistTEC.text,
                "smsCode": phoneCodeRegistTEC.text,
                "requestMethod": 0,
                "memberName": memberNameTEC.text,
                "invitationCode": inviteCode,
              };
    }
    params['deviceType'] = await Tools.getDevice();
    params['areaCode'] = countryData[codeIndexs.value].code;
    params['invitationCode'] =
        Global.instance.openShareDataModel.invitationCode;
    params['currency'] = currency;
    params['language'] = language.languageCode;

    params['downloadSite'] = Global.instance.openShareDataModel.downloadSite;

    var clipText = await Clipboard.getData(Clipboard.kTextPlain);
    if (clipText?.text != null) {
      try {
        var component = Uri.splitQueryString(clipText!.text!);
        if (component["note"] != null) {
          params["note"] = component["note"];
        }
      } catch (e) {
        printSome("处理咋贴内容发生错误 $e");
      }
    }
    printSome("注册参数 $params");
    if (Global.instance.registerVerifyType == VerifyType.wangyi.value) {
      initCaptchaPlugin(languageCode: LanguageType.pt.languageCode);
      captchaPlugin.showCaptcha(
        onSuccess: (data) {
          params['validateCode'] = data["validate"];
          captchaPlugin.destroyCaptcha();
          doRegist(params, oneClickRegistration);
        },
      );
    } else {
      doRegist(params, oneClickRegistration);
    }
  }

  Future doRegist(
    Map<String, dynamic> params,
    bool oneClickRegistration,
  ) async {
    MemberInfoModel? model;
    if (oneClickRegistration) {
      model = await UserApi.clickRegister(params);
    } else {
      model =
          tabs.firstWhere((e) => e.isSelected!).value == 0
              ? await UserApi.register(params)
              : await UserApi.newMember(params);
    }

    if (model != null) {
      StorageUtil.setString(Constants.storageMemberInfo, jsonEncode(model));
      Global.instance.memberInfo = model;
      GlobalDataService.instance.isLogin = true;

      // ToastUtils.showToast(msg: "注册成功".tr);
      if (oneClickRegistration) {
        await loginSucces(
          memberInfo: model,
          account: memberIdRandom,
          password: memberPwdRandom,
        );
        // SharedEventBus.eventBus.fire(ShowAfterClickRegisterDialog(
        //   memberIdRandom: memberIdRandom,
        //   memberPwdRandom: memberPwdRandom,
        // ));
      } else {
        await loginSucces(
          memberInfo: model,
          account: accountRegistTEC.text,
          password: psdRegistTEC.text,
        );
        // SharedEventBus.eventBus.fire(ShowAfterBindingPhoneDialog(
        //     hasBind: model.telephone != null && model.telephone!.isNotEmpty));
      }
    }
  }

  isRememberPassword() {
    CommonUtils.rememberPassword(!isRememberPwd.value);
  }

  /// 登录成功后的处理
  Future<void> loginSucces({
    required MemberInfoModel memberInfo,
    required String account,
    required String password,
  }) async {
    // 保存用户信息到全局
    Global.instance.memberInfo = memberInfo;

    // 获取已保存的账号列表
    // var list = await StorageUtil.getMemberAccountPsd();

    // // 根据登录时间排序，最近登录的排在前面
    // list.sort((a, b) {
    //   // 如果包含loginTime字段，则按时间排序
    //   if (a.containsKey('loginTime') && b.containsKey('loginTime')) {
    //     // 降序排列，最新的在前面
    //     return DateTime.parse(
    //       b['loginTime'],
    //     ).compareTo(DateTime.parse(a['loginTime']));
    //   }
    //   // 如果只有一个元素有loginTime，有loginTime的排前面
    //   else if (a.containsKey('loginTime')) {
    //     return -1;
    //   } else if (b.containsKey('loginTime')) {
    //     return 1;
    //   }
    //   // 都没有loginTime，保持原顺序
    //   return 0;
    // });

    // // 创建包含登录时间的账号记录
    // final now = DateTime.now();
    // final loginTime = now.toIso8601String();

    // // 在列表中查找是否已存在该账号
    // final existingIndex = list.indexWhere((item) => item["account"] == account);

    // if (existingIndex != -1) {
    //   // 已存在则更新密码和登录时间
    //   list[existingIndex] = {
    //     "account": account,
    //     "password": password,
    //     "loginTime": loginTime,
    //   };
    // } else {
    //   // 如果列表超过5个，移除最旧的记录
    //   if (list.length > 2) {
    //     list.removeLast();
    //   }
    //   // 不存在则添加新记录
    //   list.insert(0, {
    //     "account": account,
    //     "password": password,
    //     "loginTime": loginTime,
    //   });
    //   // accountLists.add();
    // }
    // 保存更新后的列表
    // await StorageU.setMemberAccountPsd(list);

    // // 保存当前用户信息
    // await Storage().setString(Constants.storageMemberIdAccount, account);
    // await Storage().setString(Constants.storageMemberPwd, password);
    // await Storage().setString(
    //   "${Constants.storageMemberIdAccount}_loginTime",
    //   loginTime,
    // );

    // // 自动记录账号密码
    // if (selectedType.value.value == loginTab.value) {
    //   if (!isRememberPwd.value) {
    //     var list = await Storage().getMemberAccountPsd();
    //     var listT =
    //         list.where((e) => e["account"] != memberInfo.memberId).toList();
    //     await Storage().setMemberAccountPsd(listT);
    //   }

    //   CommonUtils.rememberPassword(isRememberPwd.value);
    // } else {
    //   // CommonUtils.rememberPassword(true);
    // }

    // GlobalDataService.instance.checkLoginStatus();
    // // CommonUtils.handleNoticeAlert();
    // // 如果不是第三种登录类型，返回上一页面
    // // if (selectedType.value != 2) {
    // //   Get.back();
    // // }
    // Get.until((route) {
    //   return route.settings.name == RouteNames.mainTabPage;
    // });
    // var controller = Get.find<MainTabController>();
    // controller.selectIndex(0);
    // ToastUtils.showToast(msg: "登录成功".tr);
  }

  bool isMatchAccountValidateInput(String input) {
    final RegExp regex = RegExp(r'^[A-Za-z0-9]{6,16}$');
    return regex.hasMatch(input);
  }

  bool isMatchPwdValidateInput(String input) {
    final RegExp regex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,16}$');
    return regex.hasMatch(input);
  }

  setSubmitState() {
    if (selectedType.value.value == loginTab.value) {
      loginCanSubmit.value =
          accountTEC.text.isNotEmpty && psdTEC.text.isNotEmpty;
    }
    if (selectedType.value.value == registerTab.value) {
      registerCanSubmit.value =
          accountRegistTEC.text.isNotEmpty &&
          psdRegistTEC.text.isNotEmpty &&
          configPsdTEC.text.isNotEmpty;
      if (accountPhoneRequired()) {
        registerCanSubmit.value =
            registerCanSubmit.value && accountPhoneTEC.text.isEmpty;
      }
      if (invitationCodeRequired()) {
        registerCanSubmit.value =
            registerCanSubmit.value && inviteCodeTEC.text.isEmpty;
      }
      if (memberNameRequired()) {
        registerCanSubmit.value =
            registerCanSubmit.value && memberNameTEC.text.isEmpty;
      }
    }

    // if (selectedType.value.value == clickRegisterTab.value) {
    //   canSubmit.value = true;
    // }
  }

  @override
  void dispose() {
    accountTEC.dispose();
    psdTEC.dispose();
    phoneLoginTEC.dispose();
    phoneCodeLoginTEC.dispose();
    phoneRegistTEC.dispose();
    phoneCodeRegistTEC.dispose();
    accountRegistTEC.dispose();
    psdRegistTEC.dispose();
    configPsdTEC.dispose();
    decimalMemuController.dispose();
    inviteCodeTEC.dispose();
    memberNameTEC.dispose();
    accountPhoneTEC.dispose();
    super.dispose();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
