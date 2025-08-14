class BaseResModel {
  String? code;
  String? message;
  dynamic result;

  BaseResModel({this.code, this.message, this.result});

  factory BaseResModel.fromJson(Map<String, dynamic> json) => BaseResModel(
        code: json['code'] as String?,
        message: json['message'] as String?,
        result: json['result'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'message': message,
        'result': result,
      };
}
