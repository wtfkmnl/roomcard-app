class Phone {
  bool? enable;
  bool? required;

  Phone({this.enable, this.required});

  factory Phone.fromJson(Map<String, dynamic> json) => Phone(
        enable: json['enable'] as bool?,
        required: json['required'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'enable': enable,
        'required': required,
      };
}
