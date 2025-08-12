import 'base_site_config.dart';
import 'site.dart';

export './base_site_config.dart';
export './site.dart';
export './site_language.dart';

class AppConfigModel {
  String? googleOAuth2ClientId;
  String? googleOAuth2Secret;
  String? lundan;
  String? wangyi;
  String? withdraw;
  String? im;
  String? upayMqttPwd;
  String? upayMqttUrl;
  String? upayMqttUser;
  String? chatroomUrl;
  String? common;
  String? hisVideoUrl;
  String? hsdkie;
  String? immsgSocketUrl;
  String? immsgUrl;
  String? liveVideoUrl;
  String? lotteryApi;
  String? lotteryApiH5;
  String? lundanSdkUri;
  String? push;
  String? srqoi342;
  String? dealerCode;
  String? currency;
  String? mxn;
  String? usdt;
  String? brl;
  String? cny;
  String? vnd;
  List<Site>? site;
  BaseSiteConfig? baseSiteConfig;

  AppConfigModel({
    this.googleOAuth2ClientId,
    this.googleOAuth2Secret,
    this.lundan,
    this.wangyi,
    this.withdraw,
    this.im,
    this.upayMqttPwd,
    this.upayMqttUrl,
    this.upayMqttUser,
    this.chatroomUrl,
    this.common,
    this.hisVideoUrl,
    this.hsdkie,
    this.immsgSocketUrl,
    this.immsgUrl,
    this.liveVideoUrl,
    this.lotteryApi,
    this.lotteryApiH5,
    this.lundanSdkUri,
    this.push,
    this.srqoi342,
    this.dealerCode,
    this.currency,
    this.mxn,
    this.usdt,
    this.brl,
    this.cny,
    this.vnd,
    this.site,
    this.baseSiteConfig,
  });

  factory AppConfigModel.fromJson(Map<String, dynamic> json) {
    return AppConfigModel(
      googleOAuth2ClientId: json['googleOAuth2ClientId'] as String?,
      googleOAuth2Secret: json['googleOAuth2Secret'] as String?,
      lundan: json['lundan.aId'] as String?,
      wangyi: json['wangyi.captchaId'] as String?,
      withdraw: json['withdraw.pwd'] as String?,
      im: json['IM.im_app_url'] as String?,
      upayMqttPwd: json['Upay.mqtt.pwd'] as String?,
      upayMqttUrl: json['Upay.mqtt.url'] as String?,
      upayMqttUser: json['Upay.mqtt.user'] as String?,
      chatroomUrl: json['chatroom_url'] as String?,
      common: json['common.static.resource.url'] as String?,
      hisVideoUrl: json['hisVideoUrl'] as String?,
      hsdkie: json['hsdkie'] as String?,
      immsgSocketUrl: json['immsg_socket_url'] as String?,
      immsgUrl: json['immsg_url'] as String?,
      liveVideoUrl: json['liveVideoUrl'] as String?,
      lotteryApi: json['lottery.api'] as String?,
      lotteryApiH5: json['lottery.api.h5'] as String?,
      lundanSdkUri: json['lundan_sdk_uri'] as String?,
      push: json['push.msg.url'] as String?,
      srqoi342: json['srqoi342'] as String?,
      dealerCode: json['dealerCode'] as String?,
      currency: json['currency'] as String?,
      mxn: json['MXN'] as String?,
      usdt: json['USDT'] as String?,
      brl: json['BRL'] as String?,
      cny: json['CNY'] as String?,
      vnd: json['VND'] as String?,
      site: (json['site'] as List<dynamic>?)
          ?.map((e) => Site.fromJson(e as Map<String, dynamic>))
          .toList(),
      baseSiteConfig: json['baseSiteConfig'] == null
          ? null
          : BaseSiteConfig.fromJson(
              json['baseSiteConfig'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'googleOAuth2ClientId': googleOAuth2ClientId,
        'googleOAuth2Secret': googleOAuth2Secret,
        'lundan': lundan,
        'wangyi': wangyi,
        'withdraw': withdraw,
        'IM': im,
        'upayMqttPwd': upayMqttPwd,
        'upayMqttUrl': upayMqttUrl,
        'upayMqttUser': upayMqttUser,
        'chatroom_url': chatroomUrl,
        'common': common,
        'hisVideoUrl': hisVideoUrl,
        'hsdkie': hsdkie,
        'immsg_socket_url': immsgSocketUrl,
        'immsg_url': immsgUrl,
        'liveVideoUrl': liveVideoUrl,
        'lotteryApi': lotteryApi,
        'lotteryApiH5': lotteryApiH5,
        'lundan_sdk_uri': lundanSdkUri,
        'push': push,
        'srqoi342': srqoi342,
        'dealerCode': dealerCode,
        'currency': currency,
        'MXN': mxn,
        'USDT': usdt,
        'BRL': brl,
        'CNY': cny,
        'VND': vnd,
        'site': site?.map((e) => e.toJson()).toList(),
        'baseSiteConfig': baseSiteConfig?.toJson(),
      };
}
