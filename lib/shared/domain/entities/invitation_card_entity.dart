class InvitationCardEntity {
  InvitationCardEntity({
    this.status,
    this.data,
  });

  InvitationCardEntity.fromJson(dynamic json) {
    status = json['status'];
    if (json['cards'] != null) {
      data = [];
      json['cards'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }

  String? status;
  List<Data>? data;

  InvitationCardEntity copyWith({
    String? status,
    List<Data>? data,
  }) =>
      InvitationCardEntity(
        status: status ?? this.status,
        data: data ?? this.data,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['cards'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Data {
  Data({
    this.title,
    this.slug,
    this.navLink,
    this.thumb,
    this.uuid,
    this.id,
  });

  Data.fromJson(dynamic json) {
    title = json['title'];
    slug = json['slug'];
    navLink = json['nav_link'];
    thumb = json['thumb'];
    uuid = json['uuid'];
    id = json['id'];
  }

  String? title;
  String? slug;
  String? navLink;
  String? thumb;
  String? uuid;
  String? id;

  Data copyWith({
    String? title,
    String? slug,
    String? navLink,
    String? thumb,
    String? uuid,
  }) =>
      Data(
        title: title ?? this.title,
        slug: slug ?? this.slug,
        navLink: navLink ?? this.navLink,
        thumb: thumb ?? this.thumb,
        uuid: uuid ?? this.uuid,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['slug'] = slug;
    map['nav_link'] = navLink;
    map['thumb'] = thumb;
    map['uuid'] = uuid;
    map['id'] = id;
    return map;
  }
}
