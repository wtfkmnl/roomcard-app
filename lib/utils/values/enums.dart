import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

// enum Currency {
//   cny(
//     type: 'CNY',
//     name: '人民币',
//     units: "元",
//     icon: R.assetsImagesJinbiIcon,
//     symbol5: R.assetsImagesCurrencySymbolCNY5,
//     symbolHeight: 35 * 0.64,
//   ),
//   usdt(
//     type: 'USDT',
//     name: 'USDT',
//     units: "USDT",
//     icon: R.assetsImagesCurrencyUSDT,
//     symbol5: R.assetsImagesCurrencySymbolUSDT5,
//     symbolHeight: 35 * 0.64,
//   ),
//   usd(
//     type: 'USD',
//     name: '美元',
//     units: "美元",
//     icon: R.assetsImagesMeiyuanIcon,
//     symbol5: R.assetsImagesCurrencySymbolUSD5,
//     symbolHeight: 44 * 0.64,
//   ),
//   sgd(
//     type: 'SGD',
//     name: '新币',
//     units: '新币',
//     icon: "assets/images/icon_sgd_2x.png",
//     symbol5: R.assetsImagesCurrencySymbolSGD5,
//     symbolHeight: 44 * 0.64,
//   ),
//   vnd(
//     type: 'VND',
//     name: '越南盾',
//     units: '越南盾',
//     icon: "assets/images/icon_vnd_2x.png",
//     symbol5: R.assetsImagesCurrencySymbolVND5,
//     symbolHeight: 43 * 0.8,
//   ),
//   krw(
//     type: 'KRW',
//     name: '韩元',
//     units: '韩元',
//     icon: "assets/images/icon_krw_2x.png",
//     symbol5: R.assetsImagesCurrencySymbolKRW5,
//     symbolHeight: 66 * 0.64,
//   ),
//   idr(
//     type: 'IDR',
//     name: '印尼盾',
//     units: '印尼盾',
//     icon: "assets/images/icon_idr_2x.png",
//     symbol5: R.assetsImagesCurrencySymbolIDR5,
//     symbolHeight: 45 * 0.64,
//   ),
//   myr(
//     type: 'MYR',
//     name: '马来西亚盾',
//     units: '马来西亚盾',
//     icon: "assets/images/icon_myr_2x.png",
//     symbol5: R.assetsImagesCurrencySymbolMYR5,
//     symbolHeight: 35 * 0.64,
//   ),
//   jpy(
//     type: 'JPY',
//     name: '日元',
//     units: '日元',
//     icon: "assets/images/icon_jpy_2x.png",
//     symbol5: R.assetsImagesCurrencySymbolCNY5,
//     symbolHeight: 35 * 0.64,
//   ),
//   brl(
//     type: 'BRL',
//     name: '巴西雷亚尔',
//     units: '巴西雷亚尔',
//     icon: R.assetsImagesCurrencyBRL,
//     symbol5: R.assetsImagesCurrencySymbolBRL5,
//     symbolHeight: 44 * 0.64,
//   ),
//   mxn(
//     type: 'MXN',
//     name: '墨西哥比索',
//     units: '墨西哥比索',
//     icon: "assets/images/icon_mxn_2x.png",
//     symbol5: R.assetsImagesCurrencySymbolMXN5,
//     symbolHeight: 35 * 0.5,
//   ),
//   inr(
//     type: 'INR',
//     name: '印度卢比',
//     units: '印度卢比',
//     icon: "assets/images/icon_inr_2x.png",
//     symbol5: R.assetsImagesCurrencySymbolINR5,
//     symbolHeight: 35 * 0.5,
//   ),
//   php(
//     type: 'PHP',
//     name: 'PHP',
//     units: 'PHP',
//     icon: R.assetsImagesCurrencyPHP,
//     symbol5: R.assetsImagesCurrencyPHP,
//     symbolHeight: 35 * 0.5,
//   );

//   const Currency({
//     required this.type,
//     required this.name,
//     required this.icon,
//     required this.symbol5,
//     required this.symbolHeight,
//     required this.units,
//   });

//   final String type;
//   final String name;
//   final String icon;
//   final String symbol5;
//   final double symbolHeight;
//   final String units;

//   String nameForLanguage() {
//     switch (this) {
//       case Currency.cny:
//         return "currencyCNY".tr;
//       case Currency.usdt:
//         return "currencyUSDT".tr;
//       case Currency.usd:
//         return "currencyUSD".tr;
//       case Currency.sgd:
//         return "currencySGD".tr;
//       case Currency.vnd:
//         return "currencyVND".tr;
//       case Currency.krw:
//         return "currencyKRW".tr;
//       case Currency.idr:
//         return "currencyIDR".tr;
//       case Currency.myr:
//         return "currencyMYR".tr;
//       case Currency.jpy:
//         return "currencyJPY".tr;
//       case Currency.brl:
//         return "currencyBRL".tr;
//       case Currency.mxn:
//         return "currencyMXN".tr;
//       case Currency.inr:
//         return "currencyINR".tr;
//       case Currency.php:
//         return "php".tr;
//       default:
//         return "";
//     }
//   }

//   String nameUnitsForLanguage() {
//     switch (this) {
//       case Currency.cny:
//         return "元".tr;
//       case Currency.usdt:
//         return "currencyUSDT".tr;
//       case Currency.usd:
//         return "currencyUSD".tr;
//       case Currency.sgd:
//         return "currencySGD".tr;
//       case Currency.vnd:
//         return "currencyVND".tr;
//       case Currency.krw:
//         return "currencyKRW".tr;
//       case Currency.idr:
//         return "currencyIDR".tr;
//       case Currency.myr:
//         return "currencyMYR".tr;
//       case Currency.jpy:
//         return "currencyJPY".tr;
//       case Currency.brl:
//         return "currencyBRL".tr;
//       case Currency.mxn:
//         return "currencyMXN".tr;
//       case Currency.inr:
//         return "currencyINR".tr;
//       case Currency.php:
//         return "php".tr;
//       default:
//         return "";
//     }
//   }
// }

enum FastPayStatus {
  succ(value: 4, text: "支付成功"),
  cancel(value: 5, text: "支付取消"),
  unUpload(value: 2, text: "创建订单，但是没有上传凭证"),
  upload(value: 3, text: "创建订单，上传了凭证");

  final int value;
  final String text;

  const FastPayStatus({required this.value, required this.text});
}

enum PayColumnType {
  //栏目编码  0虚拟账户  1银联 2微信 3	支付宝 4Visa  5USDT 6BTC 7ETH 8万事达 9Pix 10U币 1199钱包
  //12VNPay 13GCash 14momo 15PayPal 16ZaloPay
  virtualCurrency(title: "虚拟币", columnCode: 0),
  unionpay(title: "银行卡快充", columnCode: 41),
  wechat(title: "微信快捷", columnCode: 40),

  alipay(title: "支付宝钱包", columnCode: 43),

  bankCard(title: "维萨", columnCode: 4),

  usdt(title: "USDT", columnCode: 5),

  btc(title: "BTC", columnCode: 6),

  eth(title: "ETH", columnCode: 7),

  MASTER(title: "万事达", columnCode: 8),
  PIX(title: "PIX", columnCode: 9),
  uPay(title: "U币", columnCode: 10),

  pay99(title: "99钱包", columnCode: 11),

  VNPay(title: "VNPay", columnCode: 12),

  GCash(title: "GCash", columnCode: 13),

  momo(title: "momo", columnCode: 14),

  PayPal(title: "PayPal", columnCode: 15),
  TaoBao(title: "淘宝", columnCode: 37),
  YunShanFu(title: "云闪付", columnCode: 35),
  ShuZiRenMinbi(title: "数字人民币", columnCode: 36),
  QQ(title: "QQ", columnCode: 38),
  aliPayQuick(title: "支付宝快捷", columnCode: 39),
  okPay(title: "OKPay钱包", columnCode: 24),

  ZaloPay(title: "ZaloPay", columnCode: 16);

  final String title;
  // final String icon;
  // final double iconW;
  // final double iconH;
  //栏目编码  0虚拟账户  1银联 2微信 3	支付宝 4Visa  5USDT 6BTC 7ETH 8万事达 9Pix 10U币 1199钱包
  //12VNPay 13GCash 14momo 15PayPal 16ZaloPay
  final int columnCode;

  const PayColumnType({
    required this.title,
    // required this.icon,
    // required this.iconW,
    // required this.iconH,
    required this.columnCode,
  });

  String nameForLanguage() {
    switch (this) {
      case PayColumnType.wechat:
        return "wechat".tr;
      case PayColumnType.alipay:
        return "支付宝钱包".tr;
      case PayColumnType.pay99:
        return "wallet99".tr;
      case PayColumnType.PIX:
        return "pixPay".tr;
      case PayColumnType.virtualCurrency:
        return "virtualCurrency".tr;
      case PayColumnType.unionpay:
        return "银行卡快充".tr;
      case PayColumnType.MASTER:
        return "master".tr;
      case PayColumnType.bankCard:
        return "visa".tr;
      case PayColumnType.uPay:
        return "uCoinDeposit".tr;
      case PayColumnType.okPay:
        return "OKPay钱包".tr;
      case PayColumnType.QQ:
        return "QQ钱包".tr;
      default:
        return title;
    }
  }
}

// 属于博速类型的快捷支付
List<int> fastPay = [38, 39, 41, 36, 40, 35];
List<int> payBankCodes = [4, 8];
List<int> payCryptoCodes = [0, 5, 6, 7];
List<int> payEWalletCodes = [1, 2, 3, 9, 10, 11, 12, 13, 14, 15, 16];

// enum WalletType {
//   bankCard(
//     name: '银行卡',
//     type: 4,
//     icon: AssetsImages.walletTopupUnionPayPng,
//     icon1: AssetsImages.walletBankIconPng,
//   ),

//   cryptocurrency(
//     name: '虚拟账户',
//     type: 5,
//     icon: AssetsImages.coinUsdtPng,
//     icon1: AssetsImages.walletCroptyIconPng,
//   ),

//   eWallet(
//     name: '电子钱包',
//     type: 6,
//     icon: AssetsImages.walletTopupIconPixPng,
//     icon1: AssetsImages.walletEwalletIconPng,
//   ),

//   fastWallet(name: '快捷提现', type: 7, icon: "", icon1: "");

//   const WalletType({
//     required this.name,
//     required this.type,
//     required this.icon,
//     required this.icon1,
//   });

//   final String name;
//   final String icon;
//   final String icon1;
//   final int type;

//   String nameForLanguage() {
//     switch (this) {
//       case WalletType.cryptocurrency:
//         return "virtualCurrency".tr;
//       case WalletType.eWallet:
//         return "topupTabWallet".tr;
//       case WalletType.bankCard:
//         return "bankCard".tr;
//       default:
//         return name;
//     }
//   }
// }

// enum EWalletType {
//   // 2微信 3支付宝 9Pix 10U币 1199钱包 12VNPay 13GCash 14momo 15PayPal 16ZaloPay
//   wechat(name: "微信", icon: AssetsImages.walletTopupWechatPng, type: 2),

//   alipay(name: "支付宝", icon: AssetsImages.walletTopupAlipayPng, type: 3),
//   PIX(name: "PIX", icon: AssetsImages.walletTopupIconPixPng, type: 9),
//   uPay(name: "U币充值", icon: AssetsImages.walletTopupUpayPng, type: 10),

//   pay99(name: "99钱包", icon: AssetsImages.topupTypeIcon_99payPng, type: 11),

//   VNPay(name: "VNPay", icon: AssetsImages.topupTypeIconVnpayPng, type: 12),

//   GCash(name: "GCash", icon: AssetsImages.topupTypeIconGcashPng, type: 13),

//   momo(name: "momo", icon: AssetsImages.topupTypeIconMomoPng, type: 14),

//   PayPal(name: "PayPal", icon: AssetsImages.topupTypeIconPaypalPng, type: 15),

//   ZaloPay(
//     name: "ZaloPay",
//     icon: AssetsImages.topupTypeIconZalopayPng,
//     type: 16,
//   ),
//   AliPayYS(name: "支付宝原生", icon: AssetsImages.walletTopupAlipayPng, type: 35);

//   const EWalletType({
//     required this.name,
//     required this.icon,
//     required this.type,
//   });

//   final String name;
//   final String icon;
//   final int type;

//   bool get isWechat => this == EWalletType.wechat;
//   bool get isAlipay => this == EWalletType.alipay;
//   bool get isPIX => this == EWalletType.PIX;
//   bool get isUPay => this == EWalletType.uPay;
//   bool get isPay99 => this == EWalletType.pay99;
//   bool get isVNPay => this == EWalletType.VNPay;
//   bool get isGCash => this == EWalletType.GCash;
//   bool get isMomo => this == EWalletType.momo;
//   bool get isPayPal => this == EWalletType.PayPal;
//   bool get isZaloPay => this == EWalletType.ZaloPay;
//   bool get isAliPayYS => this == EWalletType.AliPayYS;

//   String nameForLanguage() {
//     switch (this) {
//       case EWalletType.wechat:
//         return "wechat".tr;
//       case EWalletType.alipay:
//         return "alipay".tr;
//       case EWalletType.uPay:
//         return "uCoinDeposit".tr;
//       case EWalletType.pay99:
//         return "wallet99".tr;
//       default:
//         return name;
//     }
//   }
// }

// enum BankWalletType {
//   // 银行卡   1银联  4Visa 8万事达
//   unionpay(name: "银联", icon: AssetsImages.walletTopupWechatPng, type: 1),

//   visa(name: "Visa", icon: AssetsImages.walletTopupAlipayPng, type: 4),
//   master(name: "万事达", icon: AssetsImages.walletTopupIconPixPng, type: 8);

//   const BankWalletType({
//     required this.name,
//     required this.icon,
//     required this.type,
//   });

//   final String name;
//   final String icon;
//   final int type;

//   String nameForLanguage() {
//     switch (this) {
//       case BankWalletType.unionpay:
//         return "unipay".tr;
//       case BankWalletType.visa:
//         return "visa".tr;
//       case BankWalletType.master:
//         return "master".tr;
//       default:
//         return name;
//     }
//   }
// }

// enum CryptoWalletType {
//   // 虚拟账号 5USDT  6BTC 7ETH

//   USDT(name: "USDT", icon: AssetsImages.walletTopupWechatPng, type: 5),

//   BTC(name: "BTC", icon: AssetsImages.walletTopupAlipayPng, type: 6),
//   ETH(name: "ETH", icon: AssetsImages.walletTopupIconPixPng, type: 7);

//   const CryptoWalletType({
//     required this.name,
//     required this.icon,
//     required this.type,
//   });

//   final String name;
//   final String icon;
//   final int type;
// }

enum AcctChangeType {
  // all(
  //   type: -1,
  //   name: '全部',
  // ),
  recharge(type: 0, name: '充值'),
  withdraw(type: 1, name: '提现')
  // platformChange(
  //   type: 1,
  //   name: '游戏切换',
  // ),
  // recharge(
  //   type: 2,
  //   name: '会员充值',
  // ),
  // withdraw(
  //   type: 3,
  //   name: '会员取款',
  // ),
  // withdrawCancel(
  //   type: 4,
  //   name: '会员取款退回',
  // ),
  // manualRecharge(
  //   type: 5,
  //   name: '人工存入',
  // ),
  // manualWithdraw(
  //   type: 6,
  //   name: '人工扣款',
  // ),
  // giftBonus(
  //   type: 7,
  //   name: '赠送彩金',
  // ),
  // codeCleaning(
  //   type: 8,
  //   name: '洗码',
  // ),
  // balanceChange(
  //   type: 9,
  //   name: '货币互转',
  // ),
  // vipWeek(
  //   type: 10,
  //   name: '周礼金',
  // ),
  // vipMonth(
  //   type: 11,
  //   name: '月礼金',
  // ),
  // vipSalary(
  //   type: 13,
  //   name: 'VIP晋级彩金',
  // ),
  // rechargeDiscount(
  //   type: 14,
  //   name: '充值优惠',
  // ),
  // taskPromotional(
  //   type: 15,
  //   name: '任务奖金',
  // ),
  // bet(
  //   type: 16,
  //   name: '投注',
  // ),
  // happy(
  //   type: 17,
  //   name: '中奖',
  // ),
  // score(
  //   type: 18,
  //   name: '积分兑换',
  // ),
  // activityScore(
  //   type: 19,
  //   name: '活动积分',
  // ),
  // getCommission(
  //   type: 20,
  //   name: '领取佣金',
  // ),
  // recommendReward(
  //   type: 21,
  //   name: '推荐奖励',
  // ),
  // freshWllBeing(
  //   type: 22,
  //   name: '新人福利',
  // ),
  // rescueFundsActivity(
  //   type: 23,
  //   name: '救援金活动',
  // ),
  // redEnvelopes(
  //   type: 24,
  //   name: '红包',
  // ),
  // signInActivity(
  //   type: 25,
  //   name: '签到活动',
  // ),
  // backMoneyActivity(
  //   type: 26,
  //   name: '返利活动',
  // ),
  // rechargeActivity(
  //   type: 27,
  //   name: '充值活动',
  // ),
  // redemptionCodeActivity(
  //   type: 28,
  //   name: '兑换码活动',
  // ),
  // agentActivity(
  //   type: 29,
  //   name: '代理活动',
  // ),
  // promotionSubmissionActivity(
  //   type: 30,
  //   name: '推广提交活动',
  // ),
  // agentCommissionRebateActivity(
  //   type: 31,
  //   name: '代理返佣活动',
  // ),
  // luckyFortune(
  //   type: 32,
  //   name: '幸运彩金',
  // ),
  // advice(
  //   type: 33,
  //   name: '意见采纳',
  // ),
  // luckyFortune(
  //   type: 34,
  //   name: '幸运彩金',
  // ),
  // shareTurntableReward(
  //   type: 35,
  //   name: '分享转盘奖励',
  // ),
  // vipDay(
  //   type: 38,
  //   name: '日礼金',
  // )
  ;

  const AcctChangeType({required this.name, required this.type});

  final String name;
  final int type;

  /// type 转 enum
  static AcctChangeType? valueOfCode(int code) {
    for (var e in AcctChangeType.values) {
      if (e.type == code) {
        return e;
      }
    }
    return null;
  }

  String nameForLanguage() {
    switch (this) {
      // case all:
      //   return "all".tr;
      // case AcctChangeType.recommendReward:
      //   return "walletChangeTypeEnum_recommendReward".tr;
      // case AcctChangeType.getCommission:
      //   return "walletChangeTypeEnum_getCommission".tr;

      // case AcctChangeType.platformChange:
      // return "walletChangeTypeEnum_platformChange".tr;
      case AcctChangeType.recharge:
        return "walletChangeTypeEnum_recharge".tr;
      case AcctChangeType.withdraw:
        return "walletChangeTypeEnum_withdraw".tr;
      // case AcctChangeType.withdrawCancel:
      //   return "walletChangeTypeEnum_withdrawCancel".tr;
      // case AcctChangeType.manualRecharge:
      //   return "walletChangeTypeEnum_manualRecharge".tr;
      // case AcctChangeType.manualWithdraw:
      //   return "walletChangeTypeEnum_manualWithdraw".tr;
      // case AcctChangeType.giftBonus:
      //   return "walletChangeTypeEnum_giftBonus".tr;
      // case AcctChangeType.codeCleaning:
      //   return "walletChangeTypeEnum_codeCleaning".tr;
      // case AcctChangeType.balanceChange:
      //   return "walletChangeTypeEnum_balanceChange".tr;
      // case AcctChangeType.vipWeek:
      //   return "walletChangeTypeEnum_vipWeek".tr;
      // case AcctChangeType.vipMonth:
      //   return "walletChangeTypeEnum_vipMonth".tr;
      // case AcctChangeType.vipSalary:
      //   return "walletChangeTypeEnum_vipSalary".tr;
      // case AcctChangeType.taskPromotional:
      //   return "walletChangeTypeEnum_taskPromotional".tr;
      // case AcctChangeType.rechargeDiscount:
      //   return "walletChangeTypeEnum_rechargeDiscount".tr;
      // case AcctChangeType.bet:
      //   return "walletChangeTypeEnum_bet".tr;
      // case AcctChangeType.happy:
      //   return "walletChangeTypeEnum_happy".tr;
      // case AcctChangeType.score:
      //   return "walletChangeTypeEnum_score".tr;
      // case AcctChangeType.activityScore:
      //   return "walletChangeTypeEnum_activityScore".tr;
      // case AcctChangeType.freshWllBeing:
      //   return "walletChangeTypeEnum_freshWllBeing".tr;
      // case rescueFundsActivity:
      //   return "rescueFundActivity".tr;
      // case redEnvelopes:
      //   return "redEnvelope".tr;
      // case signInActivity:
      //   return "signInActivity".tr;
      // case backMoneyActivity:
      //   return "rebateActivity".tr;
      // case rechargeActivity:
      //   return "rechargeActivity".tr;
      // case redemptionCodeActivity:
      //   return "redemptionCodeActivity".tr;
      // case agentActivity:
      //   return "agentActivity".tr;
      // case promotionSubmissionActivity:
      //   return "promotionSubmissionActivity".tr;
      // case agentCommissionRebateActivity:
      //   return "agentRebateActivity".tr;
      // case luckyFortune:
      //   return "luckyBonus".tr;

      // case shareTurntableReward:
      //   return "shareTurntableReward".tr;
      // case advice:
      //   return "advice".tr;
      // case vipDay:
      //   return "walletChangeTypeEnum_vipDay".tr;
      default:
        return "";
    }
  }
}

// enum HomeColumns {
//   hot(
//     name: '热门',
//     type: "0",
//     iconOn: AssetsImages.hotOnPng,
//     iconOff: AssetsImages.hotOffPng,
//     iconGame: AssetsImages.hotGamePng,
//   ),
//   music(
//     name: '音乐',
//     type: "1",
//     iconOn: AssetsImages.musicOnPng,
//     iconOff: AssetsImages.musicOffPng,
//     iconGame: AssetsImages.musicGamePng,
//   ),
//   european(
//     name: '欧洲',
//     type: "2",
//     iconOn: AssetsImages.europeanOnPng,
//     iconOff: AssetsImages.europeanOffPng,
//     iconGame: AssetsImages.europeanGamePng,
//   ),
//   asian(
//     name: '亚洲',
//     type: "3",
//     iconOn: AssetsImages.asianOnPng,
//     iconOff: AssetsImages.asianOffPng,
//     iconGame: AssetsImages.asianGamePng,
//   ),
//   china(
//     name: '中国',
//     type: "4",
//     iconOn: AssetsImages.chinaOnPng,
//     iconOff: AssetsImages.chinaOffPng,
//     iconGame: AssetsImages.chinaGamePng,
//   ),
//   table(
//     name: '桌游',
//     type: "5",
//     iconOn: AssetsImages.tableOnPng,
//     iconOff: AssetsImages.tableOffPng,
//     iconGame: AssetsImages.tableGamePng,
//   );

//   const HomeColumns({
//     required this.name,
//     required this.type,
//     required this.iconOn,
//     required this.iconOff,
//     required this.iconGame,
//   });

//   final String name;
//   final String iconOn;
//   final String iconOff;
//   final String iconGame;
//   final String type;

//   String nameForLanguage() {
//     switch (this) {
//       case HomeColumns.hot:
//         return "hot".tr;
//       case HomeColumns.asian:
//         return "asia".tr;
//       case HomeColumns.china:
//         return "china".tr;
//       case HomeColumns.european:
//         return "europe".tr;
//       case HomeColumns.music:
//         return "music".tr;
//       case HomeColumns.table:
//         return "desktop".tr;

//       default:
//         return "";
//     }
//   }
// }

// enum GameType {
//   // CP:彩票 TY:体育 ZR:真人 DZ:电子 QP:棋牌 BY:捕鱼 DJ:电竞
//   all(
//     name: '全部',
//     type: "",
//   ),
//   // cp(
//   //   name: '彩票',
//   //   type: "CP",
//   // ),
//   // ty(
//   //   name: '体育',
//   //   type: "TY",
//   // ),
//   zr(
//     name: '真人',
//     type: "ZR",
//   ),
//   dz(
//     name: '电子',
//     type: "DZ",
//   ),
//   qp(
//     name: '棋牌',
//     type: "QP",
//   ),
//   by(
//     name: '捕鱼',
//     type: "BY",
//   );
//   // dj(
//   //   name: '电竞',
//   //   type: "DJ",
//   // ),

//   final String name;
//   final String type;

//   const GameType({
//     required this.name,
//     required this.type,
//   });
// }

// enum DateFilterType {
//   all(value: 0, text: "全部时间"),
//   today(value: 1, text: "今日"),
//   yesterday(value: 2, text: "昨日"),
//   day7(value: 3, text: "近7日"),
//   day15(value: 4, text: "近15日"),
//   day30(value: 5, text: "近30日");

//   final int value;
//   final String text;
//   const DateFilterType({
//     required this.value,
//     required this.text,
//   });

//   ///今日
//   String textForLanguage() {
//     switch (this) {
//       case DateFilterType.all:
//         return "allDate2".tr;
//       case DateFilterType.yesterday:
//         return "yesterday".tr;
//       case DateFilterType.today:
//         return "today".tr;
//       case DateFilterType.day7:
//         return "last7days".tr;
//       case DateFilterType.day15:
//         return "last15days".tr;
//       case DateFilterType.day30:
//         return "last30days".tr;
//       default:
//         return "";
//     }
//   }

//   ///今天
//   String textForLanguage2() {
//     switch (this) {
//       case DateFilterType.all:
//         return "AllTheTime".tr;
//       case DateFilterType.yesterday:
//         return "Yesterday".tr;
//       case DateFilterType.today:
//         return "Today".tr;
//       case DateFilterType.day7:
//         return "Last7days".tr;
//       case DateFilterType.day15:
//         return "Last15days".tr;
//       case DateFilterType.day30:
//         return "Last30days".tr;
//       default:
//         return "";
//     }
//   }
// }

enum LanguageType {
  zh(
    name: "简体中文",
    languageCode: "zh",
    // icon: AssetsImages.languageChinesePng,
    // icon1: AssetsImages.languageChinese1Png,
  ),
  en(
    name: "English",
    languageCode: "eng",
    // icon: AssetsImages.languageEnglishPng,
    // icon1: AssetsImages.languageEnglish1Png,
  ),

  ///西班牙语
  es(
    name: "español",
    languageCode: "es_MX",
    // icon: R.assetsImagesEsFlag,
    // icon1: R.assetsImagesEsFlag,
  ),

  ///葡萄牙语
  pt(
    name: "Português",
    languageCode: "pt_BR",
    // icon: AssetsImages.languagePortuguesePng,
    // icon1: AssetsImages.languagePortuguese1Png,
  ),

  ///韩文
  kr(
    name: "한국인",
    languageCode: "kr",
    // icon: AssetsImages.iconKrw_2xPng,
    // icon1: AssetsImages.iconKrw_2xPng
  ),

  ///日语
  jp(
    name: "日本語",
    languageCode: "jp",
    // icon: AssetsImages.iconJpy_2xPng,
    // icon1: AssetsImages.iconJpy_2xPng
  ),

  ///越南语
  vn(
    name: "Tiếng Việt",
    languageCode: "vn",
    // icon: AssetsImages.vietnamPng,
    // icon1: AssetsImages.vietnam1Png
  ),

  ///印地语
  hi(
    name: "हिंदी",
    languageCode: "hi",
    // icon: AssetsImages.indiaPng,
    // icon1: AssetsImages.india1Png
  ),

  ///泰语
  th(
    name: "แบบไทย",
    languageCode: "th",
    // icon: R.assetsImagesVnFlag,
    // icon1: R.assetsImagesVnFlag
  ),

  ///菲律宾
  fil(
    name: "Pilipinas",
    languageCode: "fil",
    // icon: AssetsImages.philipPng,
    // icon1: AssetsImages.philip1Png
  );

  final String name;
  final String languageCode;
  final String? icon;
  final String? icon1;

  const LanguageType({
    required this.name,
    required this.languageCode,
    this.icon,
    this.icon1,
  });

  Locale locale() {
    Locale locale = const Locale('zh', 'CN');
    switch (this) {
      case LanguageType.zh:
        locale = const Locale('zh', 'CN');
        break;
      case LanguageType.en:
        locale = const Locale('en', 'US');
        break;

      case LanguageType.es:
        locale = const Locale('es');
        break;

      case LanguageType.pt:
        locale = const Locale('pt', "BR");
        break;

      case LanguageType.kr:
        locale = const Locale('kr');
        break;

      case LanguageType.jp:
        locale = const Locale('jp');
        break;

      case LanguageType.vn:
        locale = const Locale('vn');
        break;
      case LanguageType.hi:
        locale = const Locale('hi');
        break;

      case LanguageType.th:
        locale = const Locale('th');
        break;

      case LanguageType.fil:
        locale = const Locale('fil');
        break;

      default:
    }

    return locale;
  }

  bool get isZh => this == LanguageType.zh;
  bool get isEn => this == LanguageType.en;
  bool get isEs => this == LanguageType.es;
  bool get isPt => this == LanguageType.pt;
  bool get isKr => this == LanguageType.kr;
  bool get isJp => this == LanguageType.jp;
  bool get isVn => this == LanguageType.vn;
  bool get isHi => this == LanguageType.hi;
  bool get isTh => this == LanguageType.th;
  bool get isFil => this == LanguageType.fil;
}

enum AppStatus {
  update(name: "更新"),
  maintenance(name: "维护"),
  stopUse(name: "暂停使用"),
  normal(name: "正常");

  final String name;

  const AppStatus({required this.name});

  bool get isUpdate => this == AppStatus.update;
  bool get isMaintenance => this == AppStatus.maintenance;
  bool get isStopUse => this == AppStatus.stopUse;
  bool get isNormal => this == AppStatus.normal;
}

enum GameFilterType {
  all(value: 'all'),
  collect(value: 'collect'),
  hot(value: 'hot');

  final String value;

  const GameFilterType({required this.value});
}

enum AlertType {
  update(level: 1000),
  notice(level: 1),
  login(level: 1);

  final int level;

  const AlertType({required this.level});
}

enum GameFilters {
  all(code: "All", name: "全部"),
  dz(code: "DZ", name: "全部"),
  sx(code: "SX", name: "视讯"),
  by(code: "BY", name: "捕鱼"),
  qp(code: "QP", name: "棋牌");

  final String code;
  final String name;
  const GameFilters({required this.name, required this.code});

  String textForLanguage() {
    switch (this) {
      case GameFilters.all:
        return "allGame2".tr;
      case GameFilters.dz:
        return "DZ".tr;
      case GameFilters.sx:
        return "SX".tr;
      case GameFilters.by:
        return "BY".tr;
      case GameFilters.qp:
        return "QP".tr;
      default:
        return "";
    }
  }
}

///用户禁止行为类型
enum ClientRestrictionsType {
  loginGame(v: 1),

  ///领取优惠
  getPreferential(v: 2),
  withdraw(v: 3);

  final int v;
  const ClientRestrictionsType({required this.v});
}

enum LoginType {
  none(requestMethod: 0),
  account(requestMethod: 0),
  phone(requestMethod: 1),
  google(requestMethod: 6);

  final int requestMethod;

  const LoginType({required this.requestMethod});
}

enum RegisterType { account, phone, none }

// verifyType 0不验证 1:蓝盾验证码,2:网易验证码 3短信
enum VerifyType {
  none(value: "0"),
  landun(value: "1"),
  wangyi(value: "2"),
  sms(value: "3");

  final String value;

  const VerifyType({required this.value});
}
