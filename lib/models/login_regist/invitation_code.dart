class InvitationCode {
  bool? enable;
  bool? required;

  InvitationCode({this.enable, this.required});

  factory InvitationCode.fromJson(Map<String, dynamic> json) {
    return InvitationCode(
      enable: json['enable'] as bool?,
      required: json['required'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
        'enable': enable,
        'required': required,
      };
}
