class BusinessModel {
  final String? domainImage;
  final String? link;
  final String? name;
  final int? sort;

  BusinessModel({
    this.domainImage,
    this.link,
    this.name,
    this.sort,
  });

  factory BusinessModel.fromJson(Map<String, dynamic> json) {
    return BusinessModel(
      domainImage: json['domainImage'] as String?,
      link: json['link'] as String?,
      name: json['name'] as String?,
      sort: json['sort'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'domainImage': domainImage,
      'link': link,
      'name': name,
      'sort': sort,
    };
  }
}