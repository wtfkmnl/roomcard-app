class MemberName {
  bool? enable;
  bool? required;

  MemberName({this.enable, this.required});

  factory MemberName.fromJson(Map<String, dynamic> json) => MemberName(
        enable: json['enable'] as bool?,
        required: json['required'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'enable': enable,
        'required': required,
      };
}
