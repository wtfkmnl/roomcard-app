class BaseSiteConfig {
  String? other;
  String? autoRebate;
  String? agentShareUrl;
  String? supportLanguageCode;
  String? defaultCurrency;
  String? defaultLanguageCode;
  String? agent;
  String? withdrawCardTypeSupport;
  String? supportCurrency;

  BaseSiteConfig({
    this.other,
    this.autoRebate,
    this.agentShareUrl,
    this.supportLanguageCode,
    this.defaultCurrency,
    this.defaultLanguageCode,
    this.agent,
    this.withdrawCardTypeSupport,
    this.supportCurrency,
  });

  factory BaseSiteConfig.fromJson(Map<String, dynamic> json) {
    return BaseSiteConfig(
      other: json['other.online.url'] as String?,
      autoRebate: json['auto_rebate'] as String?,
      agentShareUrl: json['agent_share_url'] as String?,
      supportLanguageCode: json['supportLanguageCode'] as String?,
      defaultCurrency: json['defaultCurrency'] as String?,
      defaultLanguageCode: json['defaultLanguageCode'] as String?,
      agent: json['agent.allow.do.register'] as String?,
      withdrawCardTypeSupport: json['withdraw_card_type_support'] as String?,
      supportCurrency: json['supportCurrency'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'other': other,
        'auto_rebate': autoRebate,
        'agent_share_url': agentShareUrl,
        'supportLanguageCode': supportLanguageCode,
        'defaultCurrency': defaultCurrency,
        'defaultLanguageCode': defaultLanguageCode,
        'agent': agent,
        'withdraw_card_type_support': withdrawCardTypeSupport,
        'supportCurrency': supportCurrency,
      };
}
