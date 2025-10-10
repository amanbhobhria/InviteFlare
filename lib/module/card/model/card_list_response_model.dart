class CardListResponseModel {
  List<CardCategoryDataModel>? categories;
  List<CardsListData>? cards;
  CustomCard? customCard;
  Meta? meta;

  CardListResponseModel(
      {this.categories, this.cards, this.customCard, this.meta});

  CardListResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <CardCategoryDataModel>[];
      json['categories'].forEach((v) {
        categories!.add(new CardCategoryDataModel.fromJson(v));
      });
    }
    if (json['cards'] != null) {
      cards = <CardsListData>[];
      json['cards'].forEach((v) {
        cards!.add(new CardsListData.fromJson(v));
      });
    }
    customCard = json['custom_card'] != null
        ? new CustomCard.fromJson(json['custom_card'])
        : null;
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    if (this.cards != null) {
      data['cards'] = this.cards!.map((v) => v.toJson()).toList();
    }
    if (this.customCard != null) {
      data['custom_card'] = this.customCard!.toJson();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class CardCategoryDataModel {
  dynamic title;
  dynamic slug;
  dynamic navLink;

  CardCategoryDataModel({this.title, this.slug, this.navLink});

  CardCategoryDataModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    slug = json['slug'];
    navLink = json['nav_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['nav_link'] = this.navLink;
    return data;
  }
}

class CardsListData {
  dynamic type;
  dynamic title;
  dynamic slug;
  dynamic navLink;
  dynamic thumb;
  dynamic alt;
  dynamic id;
  bool? isFree;
  bool? isPremium;
  List<Null>? attributes;

  CardsListData(
      {this.type,
      this.title,
      this.slug,
      this.navLink,
      this.thumb,
      this.alt,
      this.id,
      this.isFree,
      this.isPremium,
      this.attributes});

  CardsListData.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    title = json['title'];
    slug = json['slug'];
    navLink = json['nav_link'];
    thumb = json['thumb'];
    alt = json['alt'];
    id = json['id'];
    isFree = json['is_free'];
    isPremium = json['is_premium'];
    // if (json['attributes'] != null) {
    //   attributes = <Null>[];
    //   json['attributes'].forEach((v) {
    //     attributes!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['nav_link'] = this.navLink;
    data['thumb'] = this.thumb;
    data['alt'] = this.alt;
    data['id'] = this.id;
    data['is_free'] = this.isFree;
    data['is_premium'] = this.isPremium;
    // if (this.attributes != null) {
    //   data['attributes'] = this.attributes!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class CustomCard {
  dynamic type;
  dynamic title;
  dynamic slug;
  dynamic navLink;
  dynamic thumb;
  dynamic id;
  bool? isFree;
  bool? isPremium;
  List<Null>? attributes;

  CustomCard(
      {this.type,
      this.title,
      this.slug,
      this.navLink,
      this.thumb,
      this.id,
      this.isFree,
      this.isPremium,
      this.attributes});

  CustomCard.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    title = json['title'];
    slug = json['slug'];
    navLink = json['nav_link'];
    thumb = json['thumb'];
    id = json['id'];
    isFree = json['is_free'];
    isPremium = json['is_premium'];
    // if (json['attributes'] != null) {
    //   attributes = <Null>[];
    //   json['attributes'].forEach((v) {
    //     attributes!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['nav_link'] = this.navLink;
    data['thumb'] = this.thumb;
    data['id'] = this.id;
    data['is_free'] = this.isFree;
    data['is_premium'] = this.isPremium;
    // if (this.attributes != null) {
    //   data['attributes'] = this.attributes!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Meta {
  dynamic path;
  dynamic perPage;
  dynamic nextCursor;
  dynamic prevCursor;

  Meta({this.path, this.perPage, this.nextCursor, this.prevCursor});

  Meta.fromJson(Map<String, dynamic> json) {
    path = json['path'];
    perPage = json['per_page'];
    nextCursor = json['next_cursor'];
    prevCursor = json['prev_cursor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['next_cursor'] = this.nextCursor;
    data['prev_cursor'] = this.prevCursor;
    return data;
  }
}
