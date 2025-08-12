// ignore_for_file: constant_identifier_names
// 彩种本地信息枚举
enum LotteryInfoEnum {
  AMLHC(
    code: 'AMLHC',
    name: '澳门六合彩',
    shortName: '正澳彩',
    drawDuration: 60 * 10,
  ),
  AMLHC_O(
    code: 'AMLHC_O',
    name: '澳门六合彩',
    shortName: '老澳彩',
    drawDuration: 60 * 10,
  ),
  AMLHC_N(
    code: 'AMLHC_N',
    name: '澳门六合彩',
    shortName: '新澳彩',
    drawDuration: 60 * 10,
  ),
  XGLHC(
    code: 'XGLHC',
    name: '香港六合彩',
    shortName: '港彩',
    drawDuration: 0,
  ),

  JSLHC(
    code: 'JSLHC',
    name: '极速六合彩',
    shortName: '极速六合彩',
    drawDuration: 30,
  ),

  LHCFF(
    code: 'LHCFF',
    name: '急速六合彩',
    shortName: '急速六合彩',
    drawDuration: 60,
  ),
  KSLHC(
    code: 'KSLHC',
    name: '快速六合彩',
    shortName: '快速六合彩',
    drawDuration: 3 * 60,
  ),
  LHCWF(
    code: 'LHCWF',
    name: '幸运六合彩',
    shortName: '幸运六合彩',
    drawDuration: 60 * 3,
  ),
  YXXJS(
    code: 'YXXJS',
    name: '极速鱼虾蟹',
    shortName: '极速鱼虾蟹',
    drawDuration: 30,
  ),
  YXXFF(
    code: 'YXXFF',
    name: '急速鱼虾蟹',
    shortName: '急速鱼虾蟹',
    drawDuration: 60,
  ),
  YXXSF(
    code: 'YXXSF',
    name: '快速鱼虾蟹',
    shortName: '快速鱼虾蟹',
    drawDuration: 60 * 3,
  ),
  YXXWF(
    code: 'YXXWF',
    name: '幸运鱼虾蟹',
    shortName: '幸运鱼虾蟹',
    drawDuration: 5 * 60,
  ),
  KS_ZB(
    code: 'KS_ZB',
    name: '直播快三',
    shortName: '直播快三',
    drawDuration: 100,
  ),
  KSJS(
    code: 'KSJS',
    name: '极速快三',
    shortName: '极速快三',
    drawDuration: 30,
  ),
  KSFF(
    code: 'KSFF',
    name: '分分快三',
    shortName: '快三',
    drawDuration: 60,
  ),
  ///三分
  KSSF(
    code: 'KSSF',
    name: '快速快三',
    shortName: '快速快三',
    drawDuration: 60 * 3,
  ),
  ///五分
  KSWF(
    code: 'KSWF',
    name: '幸运快三',
    shortName: '幸运快三',
    drawDuration: 60 * 5,
  ),

  DZJS(
    code: 'DZJS',
    name: '极速摇钱',
    shortName: '极速摇钱',
    drawDuration: 30,
  ),
  DZFF(
    code: 'DZFF',
    name: '急速摇钱',
    shortName: '急速摇钱',
    drawDuration: 60,
  ),
  DZSF(
    code: 'DZSF',
    name: '快速摇钱',
    shortName: '快速摇钱',
    drawDuration: 3 * 60,
  ),
  DZWF(
    code: 'DZWF',
    name: '幸运摇钱',
    shortName: '幸运摇钱',
    drawDuration: 5 * 60,
  ),

  PK10XY(
    code: 'PK10XY',
    name: '幸运PK10',
    shortName: '幸运PK10',
    drawDuration: 60 * 5,
  ),
  XYFT(
    code: 'XYFT',
    name: '幸运飞艇',
    shortName: '幸运飞艇',
    drawDuration: 60 * 5,
  ),
  KSFT(
    code: 'KSFT',
    name: '快速飞艇',
    shortName: '快速飞艇',
    drawDuration: 60,
  ),
  XYSM(
    code: 'XYSM',
    name: '幸运赛马',
    shortName: '幸运赛马',
    drawDuration: 5 * 60,
  ),
  KLSM(
    code: 'KLSM',
    name: '快速赛马',
    shortName: '快速赛马',
    drawDuration: 60 * 3,
  ),
  KLSC(
    code: 'KLSC',
    name: '快速赛车',
    shortName: '快速赛车',
    drawDuration: 3 * 60,
  ),
  XYSC(
    code: 'XYSC',
    name: '幸运赛车',
    shortName: '幸运赛车',
    drawDuration: 60 * 5,
  ),
  SSC_ZB(
    code: 'SSC_ZB',
    name: '直播时时彩',
    shortName: '直播时时彩',
    drawDuration: 90,
  ),
  SSCJS(
    code: 'SSCJS',
    name: '极速时时彩',
    shortName: '极速时时彩',
    drawDuration: 30,
  ),
  SSCFF(
    code: 'SSCFF',
    name: '急速时时彩',
    shortName: '急速时时彩',
    drawDuration: 60,
  ),
  KSSSC(
    code: 'KSSSC',
    name: '快速时时彩',
    shortName: '快速时时彩',
    drawDuration: 60 * 3,
  ),
  XYSSC(
    code: 'XYSSC',
    name: '幸运时时彩',
    shortName: '幸运时时彩',
    drawDuration: 60 * 5,
  ),
  BJLJS(
    code: 'BJLJS',
    name: '极速百家乐',
    shortName: '极速百家乐',
    drawDuration: 30,
  ),
  BJLFF(
    code: 'BJLFF',
    name: '急速百家乐',
    shortName: '急速百家乐',
    drawDuration: 60,
  ),

  BJLSF(
    code: 'BJLSF',
    name: '快速百家乐',
    shortName: '快速百家乐',
    drawDuration: 60 * 3,
  ),
  BJLWF(
    code: 'BJLWF',
    name: '幸运百家乐',
    shortName: '幸运百家乐',
    drawDuration: 60 * 5,
  ),
  LHJS(
    code: 'LHJS',
    name: '极速龙虎',
    shortName: '极速龙虎',
    drawDuration: 30,
  ),
  LHFF(
    code: 'LHFF',
    name: '急速龙虎',
    shortName: '急速龙虎',
    drawDuration: 60,
  ),
  LHSF(
    code: 'LHSF',
    name: '快速龙虎',
    shortName: '快速龙虎',
    drawDuration: 60 * 3,
  ),
  LHWF(
    code: 'LHWF',
    name: '幸运龙虎',
    shortName: '幸运龙虎',
    drawDuration: 60 * 5,
  ),
  NNJS(
    code: 'NNJS',
    name: '极速牛牛',
    shortName: '极速牛牛',
    drawDuration: 30,
  ),
  NNFF(
    code: 'NNFF',
    name: '急速牛牛',
    shortName: '急速牛牛',
    drawDuration: 60,
  ),
  NNSF(
    code: 'NNSF',
    name: '快速牛牛',
    shortName: '快速牛牛',
    drawDuration: 60 * 3,
  ),
  NNWF(
    code: 'NNWF',
    name: '幸运牛牛',
    shortName: '幸运牛牛',
    drawDuration: 60 * 5,
  ),
  FTJS(
    code: 'FTJS',
    name: '极速飞艇',
    shortName: '极速飞艇',
    drawDuration: 30,
  ),
  KLFT(
    code: 'KLFT',
    name: '快速飞艇',
    shortName: '快速飞艇',
    drawDuration: 60 * 3,
  ),
  PK10FF(
    code: 'PK10FF',
    name: '急速PK10',
    shortName: '急速PK10',
    drawDuration: 60,
  ),
  PK10JS(
    code: 'PK10JS',
    name: '极速PK10',
    shortName: '极速PK10',
    drawDuration: 30,
  ),
  PK10KS(
    code: 'PK10KS',
    name: '快速PK10',
    shortName: '快速PK10',
    drawDuration: 60 * 3,
  ),
  SCFF(
    code: 'SCFF',
    name: '急速赛车',
    shortName: '急速赛车',
    drawDuration: 60,
  ),
  SCJS(
    code: 'SCJS',
    name: '极速赛车',
    shortName: '极速赛车',
    drawDuration: 30,
  ),
  xxx(
    code: 'xxx',
    name: '极速赛车',
    shortName: '极速赛车',
    drawDuration: 30,
  ),
  SMFF(
    code: 'SMFF',
    name: '急速赛马',
    shortName: '急速赛马',
    drawDuration: 60,
  ),
  SMJS(
    code: 'SMJS',
    name: '极速赛马',
    shortName: '极速赛马',
    drawDuration: 30,
  ),
  TXFF(
    code: 'TXFF',
    name: '腾讯分分彩',
    shortName: '腾讯分分彩',
    drawDuration: 60,
  ),
  TXSF(
    code: 'TXSF',
    name: '腾讯三分彩',
    shortName: '腾讯三分彩',
    drawDuration: 60 * 3,
  ),
  TXXY(
    code: 'TXXY',
    name: '腾讯五分彩',
    shortName: '腾讯五分彩',
    drawDuration: 60 * 5,
  );

  const LotteryInfoEnum({
    required this.code,
    required this.name,
    required this.shortName,
    required this.drawDuration, // 开奖周期(一般为多少时间一期)
  });

  final String name;
  final String shortName;
  final String code;
  final int drawDuration;
}

extension LotteryInfoEnumExtension on LotteryInfoEnum {
  String get drawInfo {
    if (code == 'XGLHC') {
      return '1周2-3期';
    }
    if (code == LotteryInfoEnum.AMLHC.code ||
        code == LotteryInfoEnum.AMLHC_O.code ||
        code == LotteryInfoEnum.AMLHC_N.code) {
      return '1天1期';
    }

    if (drawDuration < 60 || drawDuration % 60 != 0) {
      return '$drawDuration秒1期';
    }
    int min = (drawDuration / 60).floor();
    if (min < 60) {
      return '$min分1期';
    }
    int hour = (min / 60) as int;
    if (hour < 24) {
      return 'hour时1期';
    }
    int day = (hour / 24).floor();
    return '$day天1期';
  }
}

Map<String, LotteryInfoEnum> lotteryInfoMap = {
  for (var e in LotteryInfoEnum.values) e.code: e
};
