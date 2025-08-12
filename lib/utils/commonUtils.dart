import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:core';
// import 'dart:math' as developer;
import 'dart:developer' as developer;
import 'dart:ui' as ui;

import 'package:timezone/timezone.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:collection/collection.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:html/dom.dart' as ht;
import 'package:html/parser.dart' as ht;
import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:roomcard/global.dart';
import 'package:roomcard/models/global_dic_model.dart';
import 'package:roomcard/services/config.dart';
import 'package:roomcard/services/global_data_service.dart';
import 'package:roomcard/utils/Tools.dart';
import 'package:roomcard/utils/encrypt_utils.dart';
import 'package:roomcard/utils/permission_helper.dart';
import 'package:roomcard/utils/storage_util.dart';
import 'package:roomcard/utils/values/constants.dart';
import 'package:roomcard/utils/values/enums.dart';
import 'package:stack_trace/stack_trace.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

void printSome(dynamic msg) {
  if (kReleaseMode || kProfileMode) {
    return;
  }
  var chain = Chain.current(); // Chain.forTrace(StackTrace.current);
  // 将 core 和 flutter 包的堆栈合起来（即相关数据只剩其中一条）
  chain = chain.foldFrames(
    (frame) => frame.isCore || frame.package == "flutter",
  );
  // 取出所有信息帧
  final frames = chain.toTrace().frames;
  // 找到当前函数的信息帧
  final idx = frames.indexWhere((element) => element.member == "printSome");
  if (idx == -1 || idx + 1 >= frames.length) {
    return;
  }
  // 调用当前函数的函数信息帧
  final frame = frames[idx + 1];

  developer.log("[${frame.uri.toString().split("/").last} ${frame.line}] $msg");
}

class CommonUtils {
  static bool validPhoneNumber(String number) {
    var phoneParse = PhoneNumber.parse(number);
    return phoneParse.isValid();
  }

  static String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  static void rememberPassword(bool remember) async {
    await StorageUtil.setBool(Constants.storageRememberPassword, remember);
  }

  static int getEndTime(int? etime, int? ctime) {
    //误差1秒就当1秒处理
    int currentTIme = ctime ?? DateTime.now().millisecondsSinceEpoch;
    int endTime = etime ?? currentTIme + 1000;
    endTime = endTime - currentTIme;
    return endTime < 1000 ? currentTIme + 1500 : etime ?? currentTIme + 1500;
  }

  static String ksBetItemNameForLanguage({required String item}) {
    if (item == "大") {
      return "ksBig".tr;
    }
    if (item == "小") {
      return "ksSmall".tr;
    }
    if (item == "单") {
      return "kOne".tr;
    }
    if (item == "双") {
      return "ksTwo".tr;
    }
    if (item == "大单") {
      return "bigOdd".tr;
    }
    if (item == "小单") {
      return "smallOdd".tr;
    }

    if (item == "大双") {
      return "bigEven".tr;
    }

    if (item == "小双") {
      return "smallEven".tr;
    }

    if (item == "急速快三") {
      return "fastKs".tr;
    }

    if (item == "顺子") {
      return "straight".tr;
    }

    if (item == "三不同") {
      return "threeDifferent".tr;
    }

    if (item == "二同单选") {
      return "twoSingle".tr;
    }

    if (item == "二不同") {
      return "twoDifferent".tr;
    }
    if (item == "点数") {
      return "ksRulePoint".tr;
    }
    if (item == "任意豹子") {
      return "ksAnyTriple".tr;
    }
    if (item == "豹子") {
      return "ksThree".tr;
    }
    if (item == "单骰") {
      return "ksSingleDice".tr;
    }
    if (item == "对子") {
      return "ksDouble".tr;
    }
    // if (item == "xxxx") {
    //   return "twoDifferent;
    // }
    // if (item == "xxxx") {
    //   return "twoDifferent;
    // }

    return item;
  }

  ///时时彩 固定显示英文不翻译
  static String fixedBigSmallOddEvenTextWithCode(String code) {
    const values = {
      "P14": "Big",
      "P15": "Small",
      "P16": "Odd",
      "P17": "Even",
      "P10": "Big",
      "P11": "Small",
      "P12": "Odd",
      "P13": "Even",
      "大": "Big",
      "小": "Small",
      "单": "Odd",
      "双": "Even",
    };

    return values[code] ?? code;
  }

  ///复制内容
  static setDataToast(String data) {
    if (data != '') {
      Clipboard.setData(ClipboardData(text: data));
    }
  }

  static String phoneNumberHandleSecurity(String? phone) {
    // 处理空值或无效输入
    if (phone == null || phone.isEmpty) {
      return '';
    }

    // 处理短号码（如果号码长度小于等于7位，直接返回原号码）
    if (phone.length <= 7) {
      return phone;
    }

    // 标准处理：保留前3位和后4位
    final int frontKeep = 3;
    final int endKeep = 4;

    // 确保处理范围有效
    if (frontKeep + endKeep >= phone.length) {
      // 如果保留的总位数大于等于原号码长度，则返回原号码
      return phone;
    }

    // 计算需要多少个星号（固定使用4个）
    final String mask = '****';

    return phone.replaceRange(frontKeep, phone.length - endKeep, mask);
  }

  /*static String phoneNumberHandleSecurity(String phone) {
    if (phone.length <= 6) {
      return phone;
    }
    return phone.replaceRange(3, phone.length - 2, "****");
  }*/

  static String mailHandleSecurity(String mail) {
    if (!mail.contains("@")) {
      return mail;
    }
    var array = mail.split("@");
    if (array.length < 2) {
      return mail;
    }
    var text = array.first;
    if (text.length == 1) {
      return mail;
    }
    String t = "";
    if (text.length == 2) {
      t = text.replaceRange(1, 1, "****");
    } else if (text.length < 7) {
      t = text.replaceRange(text.length - 2, text.length - 2, "****");
    } else {
      t = text.replaceRange(5, text.length - 2, "****");
    }

    return [t, array.last].join("@");
  }

  ///当前语言
  static LanguageType currentLanguage() {
    String langCode = Tools.getCurLanguage().locale().languageCode;
    return languageTypeWithLanguageCode(langCode);
  }

  //支持的语言
  static List<LanguageType> getSupportSupportLanguageCode() {
    var supportLanguageCode =
        Global.instance.dicModel?.baseSiteConfig?.supportLanguageCode;
    if (supportLanguageCode != null) {
      List<String> configLanguage = supportLanguageCode.toString().split(",");
      return LanguageType.values
          .where((element) => configLanguage.contains(element.languageCode))
          .toList();
    } else {
      return [LanguageType.zh];
    }
  }

  ///
  static LanguageType languageTypeWithLanguageCode(String code) {
    if (code == "zh") {
      return LanguageType.zh;
    }
    if (code == "en") {
      return LanguageType.en;
    }

    if (code == "es") {
      return LanguageType.es;
    }

    if (code == "pt") {
      return LanguageType.pt;
    }

    if (code == "kr") {
      return LanguageType.kr;
    }

    if (code == "jp") {
      return LanguageType.jp;
    }

    if (code == "vn") {
      return LanguageType.vn;
    }

    if (code == "hi") {
      return LanguageType.hi;
    }

    if (code == "th") {
      return LanguageType.th;
    }

    if (code == "fil") {
      return LanguageType.fil;
    }

    return LanguageType.zh;
  }

  /**
   * 汇率转换
   * @param currency 当前币种
   * @param toCurrency 目标币种
   * @return 换算后的金额
   */
  static double exchangeAmount(
    double amount,
    String currency,
    String toCurrency,
  ) {
    try {
      if (currency == toCurrency || amount.compareTo(0) <= 0) {
        return amount;
      } else {
        String? currencyStr;
        if (currency == "USDT") {
          currencyStr = Global.instance.dicModel?.uSDT;
        } else if (currency == "USD") {
          currencyStr = Global.instance.dicModel?.uSD;
        } else if (currency == "MXN") {
          currencyStr = Global.instance.dicModel?.mXN;
        } else if (currency == "BRL") {
          currencyStr = Global.instance.dicModel?.bRL;
        } else if (currency == "CNY") {
          currencyStr = Global.instance.dicModel?.cNY;
        } else if (currency == "VND") {
          currencyStr = Global.instance.dicModel?.vND;
        }
        Map<String, dynamic> currencyJson =
            currencyStr != null ? jsonDecode(currencyStr) : {};
        double bigDecimal =
            currencyJson.isEmpty
                ? 0
                : double.parse(
                  (currencyJson[toCurrency]! as String).replaceAll(",", ""),
                );
        return amount * bigDecimal;
      }
    } catch (e) {
      printSome("转换异常${e}");
      return 0;
    }
  }

  //汇率转换
  static double exchangeRate(String currency, String toCurrency) {
    String? currencyStr;
    if (currency == "USDT") {
      currencyStr = Global.instance.dicModel?.uSDT;
    } else if (currency == "USD") {
      currencyStr = Global.instance.dicModel?.uSD;
    } else if (currency == "MXN") {
      currencyStr = Global.instance.dicModel?.mXN;
    } else if (currency == "BRL") {
      currencyStr = Global.instance.dicModel?.bRL;
    } else if (currency == "CNY") {
      currencyStr = Global.instance.dicModel?.cNY;
    } else if (currency == "VND") {
      currencyStr = Global.instance.dicModel?.vND;
    }
    Map<String, dynamic> currencyJson =
        currencyStr != null ? jsonDecode(currencyStr) : {};
    double bigDecimal =
        currencyJson.isEmpty
            ? 0
            : double.parse(
              (currencyJson[toCurrency]! as String).replaceAll(",", ""),
            );
    return bigDecimal;
  }

  static AppStatus appStatus() {
    var site = Global.instance.dicModel?.site;
    var theSite = site?.firstWhereOrNull(
      (element) => element?.siteLayoutId == "1",
    );
    var systemMaintenanceTime = theSite?.systemMaintenanceTime;
    if (systemMaintenanceTime?.isEmpty ?? true) {
      String appVersion = "";
      String currentAppVersion =
          ConfigService.instance.platform?.version ?? "1.0.0";
      if (Platform.isAndroid) {
        appVersion = theSite?.appVersionAndroid ?? "";
      } else if (Platform.isIOS) {
        appVersion = theSite?.appVersionIos ?? "";
      }
      if (appVersion.isNotEmpty) {
        if (appVersion.compareTo(currentAppVersion) > 0) {
          return AppStatus.update;
        }
      }
      return AppStatus.normal;
    }
    if (systemMaintenanceTime == "1") {
      return AppStatus.stopUse;
    }
    return AppStatus.maintenance;
    // var dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(systemMaintenanceTime);
    // if (DateTime.now().isAfter(dateTime)) {
    //   return AppStatus.maintenance;
    // }
  }

  ///获取维护时间
  static String getMaintenanceTime() {
    var site = Global.instance.dicModel?.site;
    var theSite = site?.firstWhereOrNull(
      (element) => element?.siteLayoutId == "1",
    );
    var systemMaintenanceTime = theSite?.systemMaintenanceTime ?? "";
    return systemMaintenanceTime;
  }

  ///是否强制更新
  static bool isForceUpgrade() {
    var site = Global.instance.dicModel?.site;
    var theSite = site?.firstWhereOrNull(
      (element) => element?.siteLayoutId == "1",
    );
    var url = theSite?.upgraded == "1";
    return url;
  }

  ///获取更新地址
  static String getUpdateUrl() {
    var site = Global.instance.dicModel?.site;
    var theSite = site?.firstWhereOrNull(
      (element) => element?.siteLayoutId == "1",
    );
    var url = theSite?.upgradedUrl ?? "";
    return url;
  }

  ///获取H5的地址
  static String getH5Url() {
    var site = Global.instance.dicModel?.site;
    String h5Url =
        site
            ?.firstWhereOrNull((element) => element?.siteLayoutId == "1")
            ?.h5Url ??
        "";
    return h5Url;
  }

  ///当前站点
  static SiteModel? theSite() {
    return Global.instance.dicModel?.site?.firstWhereOrNull(
      (element) => element?.siteLayoutId == "1",
    );
  }

  static List<String> parseHtmlToArray(String html) {
    ht.DocumentFragment document = ht.parseFragment(html);
    var elements = document.querySelectorAll('*');
    return elements.map((element) => element.text).toSet().toList();
  }

  ///停止位置计算
  static int shareTurntableStopIndex(int index) {
    if (index == 0) {
      return 0;
    }
    return 8 - index;
  }

  ///计算一组文字的最大宽度
  static double textMaxLayoutWidth({
    required List<String> textArray,
    required TextStyle style,
  }) {
    double value = 0;
    for (var element in textArray) {
      var tp = TextPainter(
        textDirection: TextDirection.ltr,
        text: TextSpan(text: element, style: style),
      )..layout();
      value = max(value, tp.width);
    }
    return value;
  }

  ///去除字符串开始位置的所有0
  static String removeZeroAtStart(String text) {
    if (text.startsWith("0")) {
      return removeZeroAtStart(text.replaceRange(0, 1, ""));
    }
    return text;
  }

  ///限制小数点输入的检测
  static TextEditingValue textInputFormatterSingleDecimalPointFilter({
    required TextEditingValue oldValue,
    required TextEditingValue newValue,
  }) {
    String text = newValue.text;
    if (newValue.text.length == 2) {
      var item0 = newValue.text.characters.elementAt(0);
      var item1 = newValue.text.characters.elementAt(1);
      if (item0 == "0" && item1 != ".") {
        text = "0";
      }
    }
    String nText = "";
    bool point = false;
    for (var element in text.characters) {
      if (element == ".") {
        if (point) {
          continue;
        } else {
          nText += element;
        }
        point = true;
      } else {
        nText += element;
      }
    }

    return TextEditingValue(
      text: nText,
      selection: TextSelection(
        baseOffset: nText.length,
        extentOffset: nText.length,
      ),
    );
  }

  ///限制第一个字符不能是0
  static TextEditingValue textInputFormatterNotAllowStartWith0Filter({
    required TextEditingValue oldValue,
    required TextEditingValue newValue,
  }) {
    String text = newValue.text;

    var nText = removeZeroAtStart(text);

    return TextEditingValue(
      text: nText,
      selection: TextSelection(
        baseOffset: nText.length,
        extentOffset: nText.length,
      ),
    );
  }

  ///限制第一个字符不能是0,后面的只能是0
  static TextEditingValue textInputFormatterX0({
    required TextEditingValue oldValue,
    required TextEditingValue newValue,
  }) {
    String text = newValue.text;

    var nText = removeZeroAtStart(text);
    if (nText.length > 1) {
      nText = nText.replaceRange(1, nText.length, "0" * (nText.length - 1));
    }

    return TextEditingValue(
      text: nText,
      selection: TextSelection(
        baseOffset: nText.length,
        extentOffset: nText.length,
      ),
    );
  }

  ///在数据的语言字典中匹配当前语言值
  static String? getDataValueForCurrentLanguage({required String data}) {
    try {
      Map<String, dynamic> json = jsonDecode(data);
      var language = currentLanguage();
      var targetData = json.entries.firstWhereOrNull(
        (element) => element.key == language.languageCode,
      );
      return targetData?.value;
    } catch (e) {
      printSome(e);
      return "";
    }
  }

  static String removeHtmlSpanTags(String html) {
    ht.Document document = ht.parse(html);
    document.querySelectorAll('span').forEach((element) {
      element.replaceWith(ht.Text(element.innerHtml));
    });
    return document.body?.innerHtml ?? '';
  }

  static String removeHtmlTags(String html) {
    var document = ht.parse(html);
    String parsedString =
        ht.parse(document.body?.text).documentElement?.text ?? "";
    return parsedString;
  }

  ///时时彩投注内容处理 1_1 2_2
  ///后又改了不要前面的1_
  static String sscDragonTigerBetContent({required String content}) {
    if (content == "1") {
      return "dragon".tr;
    } else if (content == "2") {
      return "tiger".tr;
    } else if (content == "3") {
      return "And".tr;
    }
    return "";

    // var name = "";
    // var last = content.split("_").last;

    // if (last == "1") {
    //   name = "dragon".tr;
    // } else if (last == "2") {
    //   name = "tiger".tr;
    // } else if (last == "3") {
    //   name = "And".tr;
    // }
    // return name;
  }

  ///识别是否是telegram链接
  static bool checkTelegramLink(String link) {
    RegExp regex = RegExp(
      r'(https?:\/\/)?(www\.)?(t\.me|telegram\.me)\/[a-zA-Z0-9_]+',
    );
    return regex.hasMatch(link);
  }

  //-----------------------------------------------------------------

  /// 请求加密 返回[新的请求参数,新的requestOptions]
  static List encryptRequest({
    String? baseUrl,
    required String url,
    dynamic data,
    required Options requestOptions,
    bool? forceEncrypt,
  }) {
    var newData = data ?? {};
    var handleUrl = url.startsWith("/") ? url.replaceFirst("/", "") : url;

    if ((forceEncrypt ?? false) ||
        CommonUtils.isMustEncrypt(handleUrl) ||
        (CommonUtils.isNeedEncrypt(handleUrl) &&
            CommonUtils.isEnableEncrypt() &&
            newData != null)) {
      var info = CommonUtils.encryptInfo();

      if (requestOptions.headers == null) {
        requestOptions.headers = {"siteTime": info.last};
      } else {
        requestOptions.headers!["siteTime"] = info.last;
      }
      var dataStr = (newData is String) ? newData : jsonEncode(newData);
      var encryptedText = "";

      encryptedText = EncryptUtils.encryptAes(
        context: dataStr,
        key: info.first,
      );

      newData = {"data": encryptedText};
      debugPrint(
        "请求接口：${(baseUrl ?? "") + url} 加密key：${info.first} 参数： ${data ?? {}} 加密后：$newData\n\n",
      );
    } else {
      if (requestOptions.headers == null) {
        requestOptions.headers = {
          "siteTime": DateTime.now().millisecondsSinceEpoch,
        };
      } else {
        requestOptions.headers!["siteTime"] =
            DateTime.now().millisecondsSinceEpoch;
      }
    }

    return [newData, requestOptions];
  }

  static Future<dynamic> decryptResponse({
    required Response response,
    required String url,
  }) async {
    var requestHeader = response.requestOptions.headers;
    if (response.data is String) {
      try {
        response.data = jsonDecode(response.data);
        printSome("msg");
      } catch (e) {
        // printSome("$e $url");
      }
    }
    if (isNeedDecrypt(response: response)) {
      var sitetime = requestHeader["sitetime"];
      var decryptKey =
          isTheGameApi(response: response)
              ? theGameDecryptKey()
              : CommonUtils.enDecryptKey(sitetime);
      var text = EncryptUtils.decryptAes(
        context: response.data,
        key: decryptKey,
      );
      // printSome("\n接口：$url\n解密key：$decryptKey\n原始内容：${response.data}\n解密后：$text");
      debugPrint(
        "返回接口：${response.requestOptions.baseUrl + url} 参数：${response.requestOptions.extra["requestParam"]} 解密key：$decryptKey 解密后：$text\n\n",
      );
      response.data = jsonDecode(text) ?? text;
    } else {
      debugPrint("不需要解密 $response");
    }
    return response;
  }

  ///aes加密信息 [key, timeStamp]
  static List encryptInfo() {
    var timeStamp = DateTime.now().millisecondsSinceEpoch;

    var key = enDecryptKey(timeStamp);

    return [key, timeStamp];
  }

  ///解密key
  static String enDecryptKey(int timeStamp) {
    var timeStampStr = timeStamp.toString();
    var key =
        Global.instance.archiveModel.sIte! +
        timeStampStr.substring(timeStampStr.length - 8, timeStampStr.length);
    var str = "1111111111111111";
    key = str.replaceRange(str.length - key.length, str.length, key);
    return key;
  }

  static isMustEncrypt(String url) {
    var mustEncrypt = false;
    for (var i = 0; i < Global.instance.mustEncryPath.length; i++) {
      var item = Global.instance.mustEncryPath[i];
      if (item.contains(url)) {
        mustEncrypt = true;
        break;
      }
    }
    return mustEncrypt;
  }

  static bool isNeedEncrypt(String url) {
    var notNeedEncrypt = false;
    for (var i = 0; i < Global.instance.noEncryPath.length; i++) {
      var item = Global.instance.noEncryPath[i];
      if (item.contains(url)) {
        notNeedEncrypt = true;
        break;
      }
    }
    return !notNeedEncrypt;
  }

  static bool isNeedDecrypt({required Response response}) {
    // if (kDebugMode) {
    //   if (!isEnableEncrypt()) {
    //     return false;
    //   }
    // }

    var flag = response.data is String;
    return flag;
  }

  static String theGameDecryptKey() {
    var key = "1111111111111111";
    key = key.replaceRange(
      key.length - Global.instance.archiveModel.sIte!.length,
      key.length,
      Global.instance.archiveModel.sIte!,
    );
    return key;

    // return encryptInfo().first;
  }

  static bool isTheGameApi({required Response response}) {
    var isGame = response.requestOptions.uri.path.contains(
      "queryGameListForApp",
    );
    return isGame;
  }

  static bool isEnableEncrypt() {
    // return Global.instance.dicModel?.data_encry_decry == "1";
    return true;
  }

  //-----------------------------------------------------------------

  static String? sitePicUrl(String? icon) {
    if (icon?.contains("http") ?? false) {
      return icon;
    }
    if (icon?.startsWith("assets") ?? false) {
      return icon;
    }

    if ((Global.instance.dicModel?.baseSiteConfig?.ossDomain?.isEmpty ??
            true) ||
        (icon?.isEmpty ?? true)) {
      return null;
    }

    var url = "${Global.instance.dicModel!.baseSiteConfig!.ossDomain!}/$icon";
    return url;
  }

  static Future deleteAccountPasswordInSecurity({
    required String account,
  }) async {
    String? content;
    List array = [];

    bool handleData() {
      if (content == null) {
        return false;
      }

      array = jsonDecode(content!);
      array.removeWhere((element) => element["account"] == account);
      return true;
    }

    if (Platform.isIOS) {
      var storage = const FlutterSecureStorage();
      content = await storage.read(key: Constants.storageAccountInfoInSecurity);

      var result = handleData();
      if (!result) {
        return;
      }

      var jsonString = jsonEncode(array);

      printSome("保存账号 $jsonString");

      await storage.write(
        key: Constants.storageAccountInfoInSecurity,
        value: jsonString,
      );
    } else if (Platform.isAndroid) {
      int androidSDKVersion = 0;
      if (Platform.isAndroid) {
        DeviceInfoPlugin device = DeviceInfoPlugin();
        var info = await device.androidInfo;
        androidSDKVersion = info.version.sdkInt;
      }
      PermissionHelper.checkPermission(
        permissionList: () {
          if (Platform.isAndroid) {
            if (androidSDKVersion >= 33) {
              // print('当前安卓版本为Android 13 (API 33)');
              return [Permission.manageExternalStorage];
            } else {
              // print('当前安卓版本不是Android 13 (API 33)');
              return [Permission.storage];
            }
          } else {
            // print('不是安卓平台');
            return [Permission.storage];
          }
        }(),
        onSuccess: () async {
          Directory directory = Directory("/storage/emulated/0/PgFile");
          var file = File("${directory.path}/ap.txt");
          if (await file.exists()) {
            content = await file.readAsString();
          }
          var result = handleData();
          if (!result) {
            return;
          }

          var jsonString = jsonEncode(array);
          await file.writeAsString(jsonString);
        },
        errorMsg: "",
      );
    }
  }

  static Future storeAccountPasswordInSecurity({
    required Map<String, String> info,
  }) async {
    List array = [];
    String? content;
    var account = info["account"];
    if (account != null) {
      StorageUtil.setString(Constants.storageDefaultLoginAccount, account);
    }
    void checkSameData() {
      if (content != null) {
        var da = jsonDecode(content!);
        if (da is List) {
          array = da;
        }

        array.removeWhere((element) => element["account"] == account);
      }
      array.insert(0, info);
      array = array.sublist(0, min(array.length, 3));
    }

    if (Platform.isIOS) {
      var storage = const FlutterSecureStorage();
      content = await storage.read(key: Constants.storageAccountInfoInSecurity);
      checkSameData();

      var jsonString = jsonEncode(array);

      printSome("保存账号 $jsonString");

      await storage.write(
        key: Constants.storageAccountInfoInSecurity,
        value: jsonString,
      );
    } else if (Platform.isAndroid) {
      int androidSDKVersion = 0;
      if (Platform.isAndroid) {
        DeviceInfoPlugin device = DeviceInfoPlugin();
        var info = await device.androidInfo;
        androidSDKVersion = info.version.sdkInt;
      }
      PermissionHelper.checkPermission(
        permissionList: () {
          if (Platform.isAndroid) {
            if (androidSDKVersion >= 33) {
              // print('当前安卓版本为Android 13 (API 33)');
              return [Permission.manageExternalStorage];
            } else {
              // print('当前安卓版本不是Android 13 (API 33)');
              return [Permission.storage];
            }
          } else {
            // print('不是安卓平台');
            return [Permission.storage];
          }
        }(),
        onSuccess: () async {
          Directory directory = Directory("/storage/emulated/0/PgFile");
          var file = File("${directory.path}/ap.txt");
          if (await file.exists()) {
            content = await file.readAsString();
          }
          checkSameData();

          var jsonString = jsonEncode(array);
          await file.writeAsString(jsonString);

          // var file = File("/storage/emulated/0/Pg/test.txt");
          // var content = await file.readAsString();
          // printSome(content);
        },
        errorMsg: "",
      );
    }
  }

  static Future<List<dynamic>?> getAccountPasswordInSecurity({
    void Function(List<dynamic>?)? onAndroid,
  }) async {
    if (Platform.isIOS) {
      var storage = const FlutterSecureStorage();
      var jsonStr = await storage.read(
        key: Constants.storageAccountInfoInSecurity,
      );
      if (jsonStr == null) {
        return null;
      }
      var obj = jsonDecode(jsonStr);
      return obj;
    } else if (Platform.isAndroid) {
      int androidSDKVersion = 0;
      if (Platform.isAndroid) {
        DeviceInfoPlugin device = DeviceInfoPlugin();
        var info = await device.androidInfo;
        androidSDKVersion = info.version.sdkInt;
      }
      PermissionHelper.checkPermission(
        permissionList: () {
          if (Platform.isAndroid) {
            if (androidSDKVersion >= 33) {
              // print('当前安卓版本为Android 13 (API 33)');
              return [Permission.manageExternalStorage];
            } else {
              // print('当前安卓版本不是Android 13 (API 33)');
              return [Permission.storage];
            }
          } else {
            // print('不是安卓平台');
            return [Permission.storage];
          }
        }(),
        onSuccess: () async {
          // Directory directory = Directory("/storage/emulated/0/PgFile");
          // var dir = await directory.create(recursive: true);
          // var file = File("${dir.path}/info.txt");
          // await file.writeAsString(json);

          var file = File("/storage/emulated/0/PgFile/ap.txt");
          var content = await file.readAsString();
          if (content.isEmpty) {
            return;
          }
          var obj = jsonDecode(content);
          if (obj is List) {
            onAndroid?.call(obj);
          } else {
            printSome("数据类型错误");
          }

          return;
        },
        errorMsg: "",
      );
    }
    return null;
  }

  ///网络不可用
  static bool isNetworkReachable([List<ConnectivityResult>? status]) {
    status ??= GlobalDataService.instance.networkStatus;
    return status != null &&
        (status.contains(ConnectivityResult.ethernet) ||
            status.contains(ConnectivityResult.wifi) ||
            status.contains(ConnectivityResult.mobile));
  }

  ///获取对应的数据的时区偏移量
  static Future<int> getTimeZoneOffset(String timeZoneName) async {
    tz.initializeTimeZones();
    var detroit = getLocation(timeZoneName);
    var offset = detroit.currentTimeZone.offset;
    printSome("服务器时区偏移 ${offset / 3600000}");
    return offset;
  }
}
