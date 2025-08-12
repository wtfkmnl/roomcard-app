class SiteLanguage {
  String? rechargeDocUrl;
  String? infoBannerUrl;
  String? homeLogoUrl;
  String? siteName;
  String? loginBackGroundUrl;
  String? siteLogoUrl;
  String? languageCode;
  String? siteDesc;

  SiteLanguage({
    this.rechargeDocUrl,
    this.infoBannerUrl,
    this.homeLogoUrl,
    this.siteName,
    this.loginBackGroundUrl,
    this.siteLogoUrl,
    this.languageCode,
    this.siteDesc,
  });

  factory SiteLanguage.fromJson(Map<String, dynamic> json) => SiteLanguage(
        rechargeDocUrl: json['recharge_doc_url'] as String?,
        infoBannerUrl: json['infoBannerUrl'] as String?,
        homeLogoUrl: json['homeLogoUrl'] as String?,
        siteName: json['siteName'] as String?,
        loginBackGroundUrl: json['loginBackGroundUrl'] as String?,
        siteLogoUrl: json['siteLogoUrl'] as String?,
        languageCode: json['languageCode'] as String?,
        siteDesc: json['siteDesc'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'recharge_doc_url': rechargeDocUrl,
        'infoBannerUrl': infoBannerUrl,
        'homeLogoUrl': homeLogoUrl,
        'siteName': siteName,
        'loginBackGroundUrl': loginBackGroundUrl,
        'siteLogoUrl': siteLogoUrl,
        'languageCode': languageCode,
        'siteDesc': siteDesc,
      };
}
