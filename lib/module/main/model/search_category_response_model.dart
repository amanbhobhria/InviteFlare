class SearchCategoryResponseModel {
  dynamic status;
  List<Data> data;

  SearchCategoryResponseModel({
    this.status,
    this.data = const [],
  });

  factory SearchCategoryResponseModel.fromJson(Map<String, dynamic> json) => SearchCategoryResponseModel(
      status: json['status'] as dynamic,
      data: (json['data'] as List<dynamic>?)
          ?.map((v) => Data.fromJson(v as Map<String, dynamic>))
          .toList() ??
          [],
    );

  Map<String, dynamic> toJson() => {
      'status': status,
      'data': data.map((v) => v.toJson()).toList(),
    };
}

class Data {
  dynamic title;
  dynamic slug;
  dynamic navLink;
  dynamic thumb;
  dynamic uuid;

  Data({
    this.title,
    this.slug,
    this.navLink,
    this.thumb,
    this.uuid,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      title: json['title'] as dynamic,
      slug: json['slug'] as dynamic,
      navLink: json['nav_link'] as dynamic,
      thumb: json['thumb'] as dynamic,
      uuid: json['uuid'] as dynamic,
    );

  Map<String, dynamic> toJson() => {
      'title': title,
      'slug': slug,
      'nav_link': navLink,
      'thumb': thumb,
      'uuid': uuid,
    };
}
