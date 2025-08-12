// ignore_for_file: non_constant_identifier_names

import 'dart:convert' show json, jsonDecode;

/// 与 [AppConfigModel] 相同功能, 该model包含了字典里的所有字段

class GlobalDicModel {
  String? bRL;
  String? cNY;
  String? iDR;
  String? iM_imAppUrl;
  String? iM_sportTeamLogo;
  String? iNR;
  String? mXN;
  String? uSDT;
  String? uSD;
  String? upay_mqtt_pwd;
  String? upay_mqtt_url;
  String? upay_mqtt_user;
  String? vND;
  String? chatroomUrl;
  String? common_static_resource_url;
  String? currency;
  String? data_encry_decry;
  String? data_encry_decry_path;
  String? dealerCode;
  String? googleOAuth2ClientId;
  String? googleOAuth2Secret;
  String? hisVideoUrl;
  String? hsdkie;
  String? immsgSocketUrl;
  String? immsgUrl;
  String? liveVideoUrl;
  String? lottery_api;
  String? lottery_api_h5;
  String? lundan_aId;
  String? lundanSdkUri;
  String? push_msg_url;
  String? sms_type;
  String? srqoi342;
  String? telegram_apiToken;
  String? telegram_domain;
  String? wangyi_captchaId;
  String? withdraw_pwd;
  List<SiteModel?>? site;
  BaseSiteConfigModel? baseSiteConfig;

  GlobalDicModel.fromParams(
      {this.bRL,
      this.cNY,
      this.iDR,
      this.iM_imAppUrl,
      this.iM_sportTeamLogo,
      this.iNR,
      this.mXN,
      this.uSDT,
      this.uSD,
      this.upay_mqtt_pwd,
      this.upay_mqtt_url,
      this.upay_mqtt_user,
      this.vND,
      this.chatroomUrl,
      this.common_static_resource_url,
      this.currency,
      this.data_encry_decry,
      this.data_encry_decry_path,
      this.dealerCode,
      this.googleOAuth2ClientId,
      this.googleOAuth2Secret,
      this.hisVideoUrl,
      this.hsdkie,
      this.immsgSocketUrl,
      this.immsgUrl,
      this.liveVideoUrl,
      this.lottery_api,
      this.lottery_api_h5,
      this.lundan_aId,
      this.lundanSdkUri,
      this.push_msg_url,
      this.sms_type,
      this.srqoi342,
      this.telegram_apiToken,
      this.telegram_domain,
      this.wangyi_captchaId,
      this.withdraw_pwd,
      this.site,
      this.baseSiteConfig});

  factory GlobalDicModel(Object jsonStr) => jsonStr is String
      ? GlobalDicModel.fromJson(json.decode(jsonStr))
      : GlobalDicModel.fromJson(jsonStr);

  static GlobalDicModel? parse(jsonStr) =>
      ['null', '', null].contains(jsonStr) ? null : GlobalDicModel(jsonStr);

  GlobalDicModel.fromJson(jsonRes) {
    bRL = jsonRes['BRL'];
    cNY = jsonRes['CNY'];
    iDR = jsonRes['IDR'];
    iM_imAppUrl = jsonRes['IM.im_app_url'];
    iM_sportTeamLogo = jsonRes['IM.sport_team_logo'];
    iNR = jsonRes['INR'];
    mXN = jsonRes['MXN'];
    uSDT = jsonRes['USDT'];
    uSD = jsonRes['USD'];
    upay_mqtt_pwd = jsonRes['Upay.mqtt.pwd'];
    upay_mqtt_url = jsonRes['Upay.mqtt.url'];
    upay_mqtt_user = jsonRes['Upay.mqtt.user'];
    vND = jsonRes['VND'];
    chatroomUrl = jsonRes['chatroom_url'];
    common_static_resource_url = jsonRes['common.static.resource.url'];
    currency = jsonRes['currency'];
    data_encry_decry = jsonRes['data.encry.decry'];
    data_encry_decry_path = jsonRes['data.encry.decry.path'];
    dealerCode = jsonRes['dealerCode'];
    googleOAuth2ClientId = jsonRes['googleOAuth2ClientId'];
    googleOAuth2Secret = jsonRes['googleOAuth2Secret'];
    hisVideoUrl = jsonRes['hisVideoUrl'];
    hsdkie = jsonRes['hsdkie'];
    immsgSocketUrl = jsonRes['immsg_socket_url'];
    immsgUrl = jsonRes['immsg_url'];
    liveVideoUrl = jsonRes['liveVideoUrl'];
    lottery_api = jsonRes['lottery.api'];
    lottery_api_h5 = jsonRes['lottery.api.h5'];
    lundan_aId = jsonRes['lundan.aId'];
    lundanSdkUri = jsonRes['lundan_sdk_uri'];
    push_msg_url = jsonRes['push.msg.url'];
    sms_type = jsonRes['sms.type'];
    srqoi342 = jsonRes['srqoi342'];
    telegram_apiToken = jsonRes['telegram.apiToken'];
    telegram_domain = jsonRes['telegram.domain'];
    wangyi_captchaId = jsonRes['wangyi.captchaId'];
    withdraw_pwd = jsonRes['withdraw.pwd'];
    site = jsonRes['site'] == null ? null : [];

    for (var siteItem in site == null ? [] : jsonRes['site']) {
      site!.add(siteItem == null ? null : SiteModel.fromJson(siteItem));
    }

    baseSiteConfig = jsonRes['baseSiteConfig'] == null
        ? null
        : BaseSiteConfigModel.fromJson(jsonRes['baseSiteConfig']);
  }

  @override
  String toString() {
    return '{"USD": ${uSD != null ? json.encode(uSD) : 'null'}, "BRL": ${bRL != null ? json.encode(bRL) : 'null'}, "CNY": ${cNY != null ? json.encode(cNY) : 'null'}, "IDR": ${iDR != null ? json.encode(iDR) : 'null'}, "IM.im_app_url": ${iM_imAppUrl != null ? json.encode(iM_imAppUrl) : 'null'}, "IM.sport_team_logo": ${iM_sportTeamLogo != null ? json.encode(iM_sportTeamLogo) : 'null'}, "INR": ${iNR != null ? json.encode(iNR) : 'null'}, "MXN": ${mXN != null ? json.encode(mXN) : 'null'}, "USDT": ${uSDT != null ? json.encode(uSDT) : 'null'}, "Upay.mqtt.pwd": ${upay_mqtt_pwd != null ? json.encode(upay_mqtt_pwd) : 'null'}, "Upay.mqtt.url": ${upay_mqtt_url != null ? json.encode(upay_mqtt_url) : 'null'}, "Upay.mqtt.user": ${upay_mqtt_user != null ? json.encode(upay_mqtt_user) : 'null'}, "VND": ${vND != null ? json.encode(vND) : 'null'}, "chatroom_url": ${chatroomUrl != null ? json.encode(chatroomUrl) : 'null'}, "common.static.resource.url": ${common_static_resource_url != null ? json.encode(common_static_resource_url) : 'null'}, "currency": ${currency != null ? json.encode(currency) : 'null'}, "data.encry.decry": ${data_encry_decry != null ? json.encode(data_encry_decry) : 'null'}, "data.encry.decry.path": ${data_encry_decry_path != null ? json.encode(data_encry_decry_path) : 'null'}, "dealerCode": ${dealerCode != null ? json.encode(dealerCode) : 'null'}, "googleOAuth2ClientId": ${googleOAuth2ClientId != null ? json.encode(googleOAuth2ClientId) : 'null'}, "googleOAuth2Secret": ${googleOAuth2Secret != null ? json.encode(googleOAuth2Secret) : 'null'}, "hisVideoUrl": ${hisVideoUrl != null ? json.encode(hisVideoUrl) : 'null'}, "hsdkie": ${hsdkie != null ? json.encode(hsdkie) : 'null'}, "immsg_socket_url": ${immsgSocketUrl != null ? json.encode(immsgSocketUrl) : 'null'}, "immsg_url": ${immsgUrl != null ? json.encode(immsgUrl) : 'null'}, "liveVideoUrl": ${liveVideoUrl != null ? json.encode(liveVideoUrl) : 'null'}, "lottery.api": ${lottery_api != null ? json.encode(lottery_api) : 'null'}, "lottery.api.h5": ${lottery_api_h5 != null ? json.encode(lottery_api_h5) : 'null'}, "lundan.aId": ${lundan_aId != null ? json.encode(lundan_aId) : 'null'}, "lundan_sdk_uri": ${lundanSdkUri != null ? json.encode(lundanSdkUri) : 'null'}, "push.msg.url": ${push_msg_url != null ? json.encode(push_msg_url) : 'null'}, "sms.type": ${sms_type != null ? json.encode(sms_type) : 'null'}, "srqoi342": ${srqoi342 != null ? json.encode(srqoi342) : 'null'}, "telegram.apiToken": ${telegram_apiToken != null ? json.encode(telegram_apiToken) : 'null'}, "telegram.domain": ${telegram_domain != null ? json.encode(telegram_domain) : 'null'}, "wangyi.captchaId": ${wangyi_captchaId != null ? json.encode(wangyi_captchaId) : 'null'}, "withdraw.pwd": ${withdraw_pwd != null ? json.encode(withdraw_pwd) : 'null'}, "site": $site, "baseSiteConfig": $baseSiteConfig}';
  }

  dynamic toJson() => jsonDecode(toString());
}

class BaseSiteConfigModel {
  String? agent_allow_do_register;
  String? agentShareUrl;
  String? autoRebate;
  String? bucket_apiUrl;
  String? bucket_id;
  String? bucket_key;
  String? bucket_type;
  String? defaultCurrency;
  String? defaultLanguageCode;
  String? firstAddMemberCard;
  String? other_online_url;
  String? supportCurrency;
  String? supportLanguageCode;
  String? withdrawCardTypeSupport;
  String? ossDomain;
  String? timeZoneId;

  ///是否支持删除pix账户 0不支持 1支持
  String? delete_pix_support;

  ///客户端提现是否弹出绑定手机号的弹窗
  String? draw_money_phone_support;
  String? game_covername_show;
  String? isWithdrawalPasswordRequired; //是否需要输入交易密码
  String? add_member_card_security_verify_way;  //1短信，2密码，0不需要
  String? pix_sub_type_support;
  List<String>? _pixSubTypes;
  List<String>? get pixSubTypes {
    if (_pixSubTypes == null) {
      var types = pix_sub_type_support
          ?.split(",")
          .map((e) => e.replaceAll("PIX_", ""))
          .toList();

      _pixSubTypes = types;
    }
    return _pixSubTypes;
  }
  String? withdraw_card_type_num;

  BaseSiteConfigModel.fromParams(
      {this.agent_allow_do_register,
      this.agentShareUrl,
      this.autoRebate,
      this.bucket_apiUrl,
      this.bucket_id,
      this.bucket_key,
      this.bucket_type,
      this.defaultCurrency,
      this.defaultLanguageCode,
      this.firstAddMemberCard,
      this.other_online_url,
      this.supportCurrency,
      this.supportLanguageCode,
      this.withdrawCardTypeSupport,
      this.ossDomain,
      this.timeZoneId,
      this.pix_sub_type_support,
      this.delete_pix_support,
      this.draw_money_phone_support,
      this.game_covername_show,
      this.isWithdrawalPasswordRequired,
      this.add_member_card_security_verify_way,
      this.withdraw_card_type_num});

  BaseSiteConfigModel.fromJson(jsonRes) {
    agent_allow_do_register = jsonRes['agent.allow.do.register'];
    agentShareUrl = jsonRes['agent_share_url'];
    autoRebate = jsonRes['auto_rebate'];
    bucket_apiUrl = jsonRes['bucket.apiUrl'];
    bucket_id = jsonRes['bucket.id'];
    bucket_key = jsonRes['bucket.key'];
    bucket_type = jsonRes['bucket.type'];
    defaultCurrency = jsonRes['defaultCurrency'];
    defaultLanguageCode = jsonRes['defaultLanguageCode'];
    firstAddMemberCard = jsonRes['first_add_member_card'];
    other_online_url = jsonRes['other.online.url'];
    supportCurrency = jsonRes['supportCurrency'];
    supportLanguageCode = jsonRes['supportLanguageCode'];
    withdrawCardTypeSupport = jsonRes['withdraw_card_type_support'];
    ossDomain = jsonRes['ossDomain'];
    timeZoneId = jsonRes['timeZoneId'];
    pix_sub_type_support = jsonRes["pix_sub_type_support"];
    delete_pix_support = jsonRes["delete_pix_support"];
    draw_money_phone_support = jsonRes["draw_money_phone_support"];
    game_covername_show = jsonRes["game_covername_show"];
    isWithdrawalPasswordRequired = jsonRes["isWithdrawalPasswordRequired"];
    add_member_card_security_verify_way = jsonRes['add_member_card_security_verify_way'];
    withdraw_card_type_num = jsonRes['withdraw_card_type_num'];
  }

  @override
  String toString() {
    return '{"withdraw_card_type_num":${withdraw_card_type_num??""},"add_member_card_security_verify_way":${add_member_card_security_verify_way??""},"isWithdrawalPasswordRequired": ${isWithdrawalPasswordRequired != null ? '${json.encode(isWithdrawalPasswordRequired)}' : 'null'}, "agent.allow.do.register": ${agent_allow_do_register != null ? '${json.encode(agent_allow_do_register)}' : 'null'}, "agent_share_url": ${agentShareUrl != null ? "${json.encode(agentShareUrl)}" : 'null'}, "auto_rebate": ${autoRebate != null ? "${json.encode(autoRebate)}" : 'null'}, "bucket.apiUrl": ${bucket_apiUrl != null ? "${json.encode(bucket_apiUrl)}" : 'null'}, "bucket.id": ${bucket_id != null ? "${json.encode(bucket_id)}" : 'null'}, "bucket.key": ${bucket_key != null ? "${json.encode(bucket_key)}" : 'null'}, "bucket.type": ${bucket_type != null ? "${json.encode(bucket_type)}" : 'null'}, "defaultCurrency": ${defaultCurrency != null ? "${json.encode(defaultCurrency)}" : 'null'}, "defaultLanguageCode": ${defaultLanguageCode != null ? "${json.encode(defaultLanguageCode)}" : 'null'}, "first_add_member_card": ${firstAddMemberCard != null ? "${json.encode(firstAddMemberCard)}" : 'null'}, "other.online.url": ${other_online_url != null ? "${json.encode(other_online_url)}" : 'null'}, "supportCurrency": ${supportCurrency != null ? "${json.encode(supportCurrency)}" : 'null'}, "supportLanguageCode": ${supportLanguageCode != null ? "${json.encode(supportLanguageCode)}" : 'null'}, "withdraw_card_type_support": ${withdrawCardTypeSupport != null ? "${json.encode(withdrawCardTypeSupport)}" : 'null'}}';
  }

  dynamic toJson() => jsonDecode(toString());
}

class SiteModel {
  String? appDownloadUrl;
  String? appVersionAndroid;
  String? appVersionIos;
  String? authLoginMethod;
  String? gameUpgradedUrl;
  String? h5Url;
  String? h5BrowseIcon;
  String? layoutId;
  String? siteLayoutId;
  String? sliverWindow;
  String? systemMaintenanceTime;
  String? upgraded;
  String? upgradedUrl;
  List<SiteLanguageModel?>? siteLanguage;

  SiteModel.fromParams(
      {this.appDownloadUrl,
      this.appVersionAndroid,
      this.appVersionIos,
      this.authLoginMethod,
      this.gameUpgradedUrl,
      this.h5Url,
      this.h5BrowseIcon,
      this.layoutId,
      this.siteLayoutId,
      this.sliverWindow,
      this.systemMaintenanceTime,
      this.upgraded,
      this.upgradedUrl,
      this.siteLanguage});

  SiteModel.fromJson(jsonRes) {
    appDownloadUrl = jsonRes['appDownloadUrl'];
    appVersionAndroid = jsonRes['appVersionAndroid'];
    appVersionIos = jsonRes['appVersionIos'];
    authLoginMethod = jsonRes['authLoginMethod'];
    gameUpgradedUrl = jsonRes['game_upgraded_url'];
    h5Url = jsonRes['h5Url'];
    h5BrowseIcon = jsonRes['h5_browse_icon'];
    layoutId = jsonRes['layoutId'];
    siteLayoutId = jsonRes['siteLayoutId'];
    sliverWindow = jsonRes['sliverWindow'];
    systemMaintenanceTime = jsonRes['systemMaintenanceTime'];
    upgraded = jsonRes['upgraded'];
    upgradedUrl = jsonRes['upgraded_url'];
    siteLanguage = jsonRes['siteLanguage'] == null ? null : [];

    for (var siteLanguageItem
        in siteLanguage == null ? [] : jsonRes['siteLanguage']) {
      siteLanguage!.add(siteLanguageItem == null
          ? null
          : SiteLanguageModel.fromJson(siteLanguageItem));
    }
  }

  @override
  String toString() {
    return '{"appDownloadUrl": ${appDownloadUrl != null ? json.encode(appDownloadUrl) : 'null'}, "appVersionAndroid": ${appVersionAndroid != null ? json.encode(appVersionAndroid) : 'null'}, "appVersionIos": ${appVersionIos != null ? json.encode(appVersionIos) : 'null'}, "authLoginMethod": ${authLoginMethod != null ? json.encode(authLoginMethod) : 'null'}, "game_upgraded_url": ${gameUpgradedUrl != null ? json.encode(gameUpgradedUrl) : 'null'}, "h5Url": ${h5Url != null ? json.encode(h5Url) : 'null'}, "h5_browse_icon": ${h5BrowseIcon != null ? json.encode(h5BrowseIcon) : 'null'}, "layoutId": ${layoutId != null ? json.encode(layoutId) : 'null'}, "siteLayoutId": ${siteLayoutId != null ? json.encode(siteLayoutId) : 'null'}, "sliverWindow": ${sliverWindow != null ? json.encode(sliverWindow) : 'null'}, "systemMaintenanceTime": ${systemMaintenanceTime != null ? json.encode(systemMaintenanceTime) : 'null'}, "upgraded": ${upgraded != null ? json.encode(upgraded) : 'null'}, "upgraded_url": ${upgradedUrl != null ? json.encode(upgradedUrl) : 'null'}, "siteLanguage": $siteLanguage}';
  }

  dynamic toJson() => jsonDecode(toString());
}

class SiteLanguageModel {
  String? homeLogoUrl;
  String? languageCode;
  String? siteDesc;
  String? siteLogoUrl;
  String? siteName;
  String? login_logo;

  String? signLogoUrl;

  SiteLanguageModel.fromParams({
    this.homeLogoUrl,
    this.languageCode,
    this.siteDesc,
    this.siteLogoUrl,
    this.siteName,
    this.login_logo,
    this.signLogoUrl,
  });

  SiteLanguageModel.fromJson(jsonRes) {
    homeLogoUrl = jsonRes['homeLogoUrl'];
    languageCode = jsonRes['languageCode'];
    siteDesc = jsonRes['siteDesc'];
    siteLogoUrl = jsonRes['siteLogoUrl'];
    siteName = jsonRes['siteName'];
  }

  @override
  String toString() {
    return '{"homeLogoUrl": ${homeLogoUrl != null ? json.encode(homeLogoUrl) : 'null'}, "login_logo": ${login_logo != null ? json.encode(login_logo) : 'null'}, "languageCode": ${languageCode != null ? json.encode(languageCode) : 'null'}, "siteDesc": ${siteDesc != null ? json.encode(siteDesc) : 'null'}, "siteLogoUrl": ${siteLogoUrl != null ? json.encode(siteLogoUrl) : 'null'}, "siteName": ${siteName != null ? json.encode(siteName) : 'null'}}';
  }

  dynamic toJson() => jsonDecode(toString());
}
