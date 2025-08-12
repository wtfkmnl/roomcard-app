import 'site_language.dart';

class Site {
  String? homeColumns;
  String? appVersionIos;
  String? authLoginMethod;
  String? upgraded;
  String? gameUpgradedUrl;
  String? iosDownUrl;
  String? betColumns;
  String? siteLayoutId;
  String? appDownloadUrl;
  String? appVersionAndroid;
  String? androidDownUrl;
  List<SiteLanguage>? siteLanguage;
  String? ksEntryEnable;
  String? layoutId;

  Site({
    this.homeColumns,
    this.appVersionIos,
    this.authLoginMethod,
    this.upgraded,
    this.gameUpgradedUrl,
    this.iosDownUrl,
    this.betColumns,
    this.siteLayoutId,
    this.appDownloadUrl,
    this.appVersionAndroid,
    this.androidDownUrl,
    this.siteLanguage,
    this.ksEntryEnable,
    this.layoutId,
  });

  factory Site.fromJson(Map<String, dynamic> json) => Site(
        homeColumns: json['homeColumns'] as String?,
        appVersionIos: json['appVersionIos'] as String?,
        authLoginMethod: json['authLoginMethod'] as String?,
        upgraded: json['upgraded'] as String?,
        gameUpgradedUrl: json['game_upgraded_url'] as String?,
        iosDownUrl: json['iosDownUrl'] as String?,
        betColumns: json['betColumns'] as String?,
        siteLayoutId: json['siteLayoutId'] as String?,
        appDownloadUrl: json['appDownloadUrl'] as String?,
        appVersionAndroid: json['appVersionAndroid'] as String?,
        androidDownUrl: json['androidDownUrl'] as String?,
        siteLanguage: (json['siteLanguage'] as List<dynamic>?)
            ?.map((e) => SiteLanguage.fromJson(e as Map<String, dynamic>))
            .toList(),
        ksEntryEnable: json['ks_entry_enable'] as String?,
        layoutId: json['layoutId'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'homeColumns': homeColumns,
        'appVersionIos': appVersionIos,
        'authLoginMethod': authLoginMethod,
        'upgraded': upgraded,
        'game_upgraded_url': gameUpgradedUrl,
        'iosDownUrl': iosDownUrl,
        'betColumns': betColumns,
        'siteLayoutId': siteLayoutId,
        'appDownloadUrl': appDownloadUrl,
        'appVersionAndroid': appVersionAndroid,
        'androidDownUrl': androidDownUrl,
        'siteLanguage': siteLanguage?.map((e) => e.toJson()).toList(),
        'ks_entry_enable': ksEntryEnable,
        'layoutId': layoutId,
      };
}
