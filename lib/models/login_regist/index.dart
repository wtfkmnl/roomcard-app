import 'invitation_code.dart';
import 'member_name.dart';
import 'phone.dart';

export './invitation_code.dart';
export './member_name.dart';
export './phone.dart';

class LoginRegisterSettingModel {
  int? registerEnable;
  int? registerIpLimit;
  int? loginIpLimit;
  MemberName? memberName;
  Phone? phone;
  InvitationCode? invitationCode;
  ///注册账户类型，0普通账号 1手机号 egisterAccountType=1的时候，不发验证码直接注册
  int? registerAccountType;
  List<int>? registerAuthType;
  List<int>? loginAuthType;
  int? loginWrongLimit;
  List<int>? registerMethod;
  List<int>? loginMethod;
  int? sysAuthType;

  LoginRegisterSettingModel({
    this.registerEnable,
    this.registerIpLimit,
    this.loginIpLimit,
    this.memberName,
    this.phone,
    this.invitationCode,
    this.registerAuthType,
    this.loginAuthType,
    this.loginWrongLimit,
    this.registerMethod,
    this.loginMethod,
    this.sysAuthType,
    this.registerAccountType,
  });

  factory LoginRegisterSettingModel.fromJson(Map<String, dynamic> json) {
    return LoginRegisterSettingModel(
      registerEnable: json['registerEnable'] as int?,
      registerIpLimit: json['registerIpLimit'] as int?,
      loginIpLimit: json['loginIpLimit'] as int?,
      memberName: json['memberName'] == null
          ? null
          : MemberName.fromJson(json['memberName'] as Map<String, dynamic>),
      phone: json['phone'] == null
          ? null
          : Phone.fromJson(json['phone'] as Map<String, dynamic>),
      invitationCode: json['invitationCode'] == null
          ? null
          : InvitationCode.fromJson(
              json['invitationCode'] as Map<String, dynamic>),
      registerAuthType: json['registerAuthType']?.cast<int>(),
      loginAuthType: json['loginAuthType']?.cast<int>(),
      loginWrongLimit: json['loginWrongLimit'] as int?,
      registerMethod: json['registerMethod']?.cast<int>(),
      loginMethod: json['loginMethod']?.cast<int>(),
      sysAuthType: json['sysAuthType'] as int?,
      registerAccountType: json['registerAccountType'],
    );
  }

  Map<String, dynamic> toJson() => {
        'registerEnable': registerEnable,
        'registerIpLimit': registerIpLimit,
        'loginIpLimit': loginIpLimit,
        'memberName': memberName?.toJson(),
        'phone': phone?.toJson(),
        'invitationCode': invitationCode?.toJson(),
        'registerAuthType': registerAuthType,
        'loginAuthType': loginAuthType,
        'loginWrongLimit': loginWrongLimit,
        'registerMethod': registerMethod,
        'loginMethod': loginMethod,
        'sysAuthType': sysAuthType,
      };
}
