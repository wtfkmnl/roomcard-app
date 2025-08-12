import 'dart:convert' show json;

class AcctInfoModel {
  int? memberRowId;
  num? balanceBrl;
  num? balanceCny;
  num? balanceIdr;
  num? balanceInr;
  num? balanceJpy;
  num? balanceKrw;
  num? balanceMxn;
  num? balanceMyr;
  num? balancePhp;
  num? balanceSgd;
  num? balanceUsd;
  num? balanceUsdt;
  num? balanceVnd;
  String? currency;
  String? memberId;
  String? site;

  AcctInfoModel.fromParams({
    this.memberRowId,
    this.balanceBrl,
    this.balanceCny,
    this.balanceIdr,
    this.balanceInr,
    this.balanceJpy,
    this.balanceKrw,
    this.balanceMxn,
    this.balanceMyr,
    this.balancePhp,
    this.balanceSgd,
    this.balanceUsd,
    this.balanceUsdt,
    this.balanceVnd,
    this.currency,
    this.memberId,
    this.site,
  });

  factory AcctInfoModel(Object jsonStr) =>
      jsonStr is String
          ? AcctInfoModel.fromJson(json.decode(jsonStr))
          : AcctInfoModel.fromJson(jsonStr);

  static AcctInfoModel? parse(jsonStr) =>
      ['null', '', null].contains(jsonStr) ? null : AcctInfoModel(jsonStr);

  AcctInfoModel.fromJson(jsonRes) {
    memberRowId = jsonRes['memberRowId'];
    balanceBrl = jsonRes['balanceBrl'];
    balanceCny = jsonRes['balanceCny'];
    balanceIdr = jsonRes['balanceIdr'];
    balanceInr = jsonRes['balanceInr'];
    balanceJpy = jsonRes['balanceJpy'];
    balanceKrw = jsonRes['balanceKrw'];
    balanceMxn = jsonRes['balanceMxn'];
    balanceMyr = jsonRes['balanceMyr'];
    balancePhp = jsonRes['balancePhp'];
    balanceSgd = jsonRes['balanceSgd'];
    balanceUsd = jsonRes['balanceUsd'];
    balanceUsdt = jsonRes['balanceUsdt'];
    balanceVnd = jsonRes['balanceVnd'];
    currency = jsonRes['currency'];
    memberId = jsonRes['memberId'];
    site = jsonRes['site'];
  }

  @override
  String toString() {
    return '{"memberRowId": $memberRowId, "balanceBrl": $balanceBrl, "balanceCny": $balanceCny, "balanceIdr": $balanceIdr, "balanceInr": $balanceInr, "balanceJpy": $balanceJpy, "balanceKrw": $balanceKrw, "balanceMxn": $balanceMxn, "balanceMyr": $balanceMyr, "balancePhp": $balancePhp, "balanceSgd": $balanceSgd, "balanceUsd": $balanceUsd, "balanceUsdt": $balanceUsdt, "balanceVnd": $balanceVnd, "currency": ${currency != null ? '${json.encode(currency)}' : 'null'}, "memberId": ${memberId != null ? '${json.encode(memberId)}' : 'null'}, "site": ${site != null ? '${json.encode(site)}' : 'null'}}';
  }

  Map<String, dynamic> toJson() => json.decode(toString());

  // num? get balance {
  //   var value = CommonUtils.currencyBalance(
  //     CommonUtils.getCurrentSelectCurrency(),
  //   );
  //   return value;
  // }

  // set balance(num? value) {
  //   switch (CommonUtils.getCurrentSelectCurrency()) {
  //     case Currency.cny:
  //       balanceCny = value;
  //     case Currency.usdt:
  //       balanceUsdt = value;
  //     case Currency.usd:
  //       balanceUsd = value;
  //     case Currency.sgd:
  //       balanceSgd = value;
  //     case Currency.vnd:
  //       balanceVnd = value;
  //     case Currency.krw:
  //       balanceKrw = value;
  //     case Currency.idr:
  //       balanceIdr = value;
  //     case Currency.myr:
  //       balanceMyr = value;
  //     case Currency.jpy:
  //       balanceJpy = value;
  //     case Currency.brl:
  //       balanceBrl = value;
  //     case Currency.mxn:
  //       balanceMxn = value;
  //     default:
  //   }
  // }
}

// class AcctInfoModel {
//   int? memberRowId;
//   String? memberId;
//   String? site;
//   String? currency;
//   num? balanceCny;
//   num? balanceUsdt;
//   num? balanceUsd;
//   num? balanceSgd;
//   num? balanceVnd;
//   num? balanceJpy;
//   num? balanceKrw;
//   num? balanceIdr;
//   num? balanceMyr;
//   num? balanceBrl;
//   num? balanceMxn;
//   num? balance;

//   AcctInfoModel({
//     this.memberRowId,
//     this.memberId,
//     this.site,
//     this.currency,
//     this.balanceCny,
//     this.balanceUsdt,
//     this.balanceUsd,
//     this.balanceSgd,
//     this.balanceVnd,
//     this.balanceJpy,
//     this.balanceKrw,
//     this.balanceIdr,
//     this.balanceMyr,
//     this.balanceBrl,
//     this.balanceMxn,
//     this.balance,
//   });

//   factory AcctInfoModel.fromJson(Map<String, dynamic> json) => AcctInfoModel(
//         memberRowId: json['memberRowId'] as int?,
//         memberId: json['memberId'] as String?,
//         site: json['site'] as String?,
//         currency: json['currency'] as String?,
//         balanceCny: json['balanceCny'] as num?,
//         balanceUsdt: json['balanceUsdt'] as num?,
//         balanceUsd: json['balanceUsd'] as num?,
//         balanceSgd: json['balanceSgd'] as num?,
//         balanceVnd: json['balanceVnd'] as num?,
//         balanceJpy: json['balanceJpy'] as num?,
//         balanceKrw: json['balanceKrw'] as num?,
//         balanceIdr: json['balanceIdr'] as num?,
//         balanceMyr: json['balanceMyr'] as num?,
//         balanceBrl: json['balanceBrl'] as num?,
//         balanceMxn: json['balanceMxn'] as num?,
//         balance: json['balance'] as num,
//       );

//   Map<String, dynamic> toJson() => {
//         'memberRowId': memberRowId,
//         'memberId': memberId,
//         'site': site,
//         'currency': currency,
//         'balanceCny': balanceCny,
//         'balanceUsdt': balanceUsdt,
//         'balanceUsd': balanceUsd,
//         'balanceSgd': balanceSgd,
//         'balanceVnd': balanceVnd,
//         'balanceJpy': balanceJpy,
//         'balanceKrw': balanceKrw,
//         'balanceIdr': balanceIdr,
//         'balanceMyr': balanceMyr,
//         'balanceBrl': balanceBrl,
//         'balanceMxn': balanceMxn,
//         'balance': balance,
//       };
// }
