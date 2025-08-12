class MemberInfoModel {
  String? memberId;
  int? rowId;
  int? levelId;
  int? vipId;
  String? memberPwd;
  String? busiPwd;
  String? registerIp;
  String? registerAddress;
  String? invitationCode;
  String? channelId;
  String? downloadSite;
  String? site;
  num? frozen;
  num? depositFirstAmount;
  num? depositAmount;
  num? depositNumber;
  num? withdrawAmount;
  int? withdrawNumber;
  int? loginTimes;
  int? loginDate;
  int? createTime;
  int? updateTime;
  dynamic note;
  int? sex;
  String? nickName;
  String? memberName;
  String? telephone;
  String? areaCode;
  String? headPortrait;
  int? birthday;
  dynamic giftAddr;
  dynamic emailId;
  dynamic currency;
  dynamic balanceCny;
  dynamic balanceUsdt;
  dynamic balanceUsd;
  dynamic balanceSgd;
  dynamic balanceVnd;
  dynamic balanceJpy;
  dynamic balanceKrw;
  dynamic balanceIdr;
  dynamic balanceMyr;
  dynamic balanceBrl;
  dynamic balanceMxn;
  num? betAmount;
  num? rechargeAmount;
  dynamic lastObtainedVipId;
  num? currentScore;
  num? score;
  int? agent;
  String? linkCode;
  String? traceId;
  List<dynamic>? clientRestrictions;

  MemberInfoModel({
    this.memberId,
    this.rowId,
    this.levelId,
    this.vipId,
    this.memberPwd,
    this.busiPwd,
    this.registerIp,
    this.registerAddress,
    this.invitationCode,
    this.channelId,
    this.downloadSite,
    this.site,
    this.frozen,
    this.depositFirstAmount,
    this.depositAmount,
    this.depositNumber,
    this.withdrawAmount,
    this.withdrawNumber,
    this.loginTimes,
    this.loginDate,
    this.createTime,
    this.updateTime,
    this.note,
    this.sex,
    this.nickName,
    this.memberName,
    this.telephone,
    this.areaCode,
    this.headPortrait,
    this.birthday,
    this.giftAddr,
    this.emailId,
    this.currency,
    this.balanceCny,
    this.balanceUsdt,
    this.balanceUsd,
    this.balanceSgd,
    this.balanceVnd,
    this.balanceJpy,
    this.balanceKrw,
    this.balanceIdr,
    this.balanceMyr,
    this.balanceBrl,
    this.balanceMxn,
    this.betAmount,
    this.rechargeAmount,
    this.lastObtainedVipId,
    this.currentScore,
    this.score,
    this.agent,
    this.linkCode,
    this.traceId,
    this.clientRestrictions,
  });

  factory MemberInfoModel.fromJson(Map<String, dynamic> json) {
    return MemberInfoModel(
      memberId: json['memberId'] as String?,
      rowId: json['rowId'] as int?,
      levelId: json['levelId'] as int?,
      vipId: json['vipId'] as int?,
      memberPwd: json['memberPwd'] as String?,
      busiPwd: json['busiPwd'] as String?,
      registerIp: json['registerIp'] as String?,
      registerAddress: json['registerAddress'] as String?,
      invitationCode: json['invitationCode'] as String?,
      channelId: json['channelId'] as String?,
      downloadSite: json['downloadSite'] as String?,
      site: json['site'] as String?,
      frozen: json['frozen'] as num?,
      depositFirstAmount: json['depositFirstAmount'] as num?,
      depositAmount: json['depositAmount'] as num?,
      depositNumber: json['depositNumber'] as num?,
      withdrawAmount: json['withdrawAmount'] as num?,
      withdrawNumber: json['withdrawNumber'] as int?,
      loginTimes: json['loginTimes'] as int?,
      loginDate: json['loginDate'] as int?,
      createTime: json['createTime'] as int?,
      updateTime: json['updateTime'] as int?,
      note: json['note'] as dynamic,
      sex: json['sex'] as int?,
      nickName: json['nickName'] as String?,
      memberName: json['memberName'] as String?,
      telephone: json['telephone'] as String?,
      areaCode: json['areaCode'] as String?,
      headPortrait: json['headPortrait'] as String?,
      birthday: json['birthday'] as int?,
      giftAddr: json['giftAddr'] as dynamic,
      emailId: json['emailId'] as dynamic,
      currency: json['currency'] as dynamic,
      balanceCny: json['balanceCny'] as dynamic,
      balanceUsdt: json['balanceUsdt'] as dynamic,
      balanceUsd: json['balanceUsd'] as dynamic,
      balanceSgd: json['balanceSgd'] as dynamic,
      balanceVnd: json['balanceVnd'] as dynamic,
      balanceJpy: json['balanceJpy'] as dynamic,
      balanceKrw: json['balanceKrw'] as dynamic,
      balanceIdr: json['balanceIdr'] as dynamic,
      balanceMyr: json['balanceMyr'] as dynamic,
      balanceBrl: json['balanceBrl'] as dynamic,
      balanceMxn: json['balanceMxn'] as dynamic,
      betAmount: json['betAmount'] as num?,
      rechargeAmount: json['rechargeAmount'] as num?,
      lastObtainedVipId: json['lastObtainedVipId'] as dynamic,
      currentScore: json['currentScore'] as num?,
      score: json['score'] as num?,
      agent: json['agent'] as int?,
      linkCode: json['linkCode'] as String?,
      traceId: json['traceId'] as String?,
      clientRestrictions: json["clientRestrictions"],
    );
  }

  Map<String, dynamic> toJson() => {
        'memberId': memberId,
        'rowId': rowId,
        'levelId': levelId,
        'vipId': vipId,
        'memberPwd': memberPwd,
        'busiPwd': busiPwd,
        'registerIp': registerIp,
        'registerAddress': registerAddress,
        'invitationCode': invitationCode,
        'channelId': channelId,
        'downloadSite': downloadSite,
        'site': site,
        'frozen': frozen,
        'depositFirstAmount': depositFirstAmount,
        'depositAmount': depositAmount,
        'depositNumber': depositNumber,
        'withdrawAmount': withdrawAmount,
        'withdrawNumber': withdrawNumber,
        'loginTimes': loginTimes,
        'loginDate': loginDate,
        'createTime': createTime,
        'updateTime': updateTime,
        'note': note,
        'sex': sex,
        'nickName': nickName,
        'memberName': memberName,
        'telephone': telephone,
        'areaCode': areaCode,
        'headPortrait': headPortrait,
        'birthday': birthday,
        'giftAddr': giftAddr,
        'emailId': emailId,
        'currency': currency,
        'balanceCny': balanceCny,
        'balanceUsdt': balanceUsdt,
        'balanceUsd': balanceUsd,
        'balanceSgd': balanceSgd,
        'balanceVnd': balanceVnd,
        'balanceJpy': balanceJpy,
        'balanceKrw': balanceKrw,
        'balanceIdr': balanceIdr,
        'balanceMyr': balanceMyr,
        'balanceBrl': balanceBrl,
        'balanceMxn': balanceMxn,
        'betAmount': betAmount,
        'rechargeAmount': rechargeAmount,
        'lastObtainedVipId': lastObtainedVipId,
        'currentScore': currentScore,
        'score': score,
        'agent': agent,
        'linkCode': linkCode,
      };
}
