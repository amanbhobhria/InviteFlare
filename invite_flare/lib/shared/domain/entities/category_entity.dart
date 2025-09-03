/// title : "Birthday"
/// slug : "birthday"
/// icon_xs : null
/// icon_xl : null
/// bg_color : null
/// nav_link : "/invitations/birthday"
/// banner : {"title":"Birthday Invitations","sub_title":"Celebrate every special moment.","description":"Make birthdays unforgettable with our vibrant invitations.","background_color":"#fbf6ee"}
/// seo : {"meta_title":"Birthday Invitations","meta_description":"Find the perfect birthday invitation for all ages and themes. Explore our collection of fun, unique, and themed birthday invitations.","page_title":"Birthday Invitations","page_description":"Celebrate every birthday in style! Choose from our range of personalized invitations to make the day extra special.","canonical_url":"/categories/birthday"}
/// category : [{"title":"Kids Birthday","slug":"kids-birthday","icon_xs":null,"icon_xl":null,"bg_color":null,"nav_link":"/invitations/kids-birthday"},{"title":"Adult Birthday","slug":"adult-birthday","icon_xs":null,"icon_xl":null,"bg_color":null,"nav_link":"/invitations/adult-birthday"},{"title":"Themed Birthday","slug":"themed-birthday","icon_xs":null,"icon_xl":null,"bg_color":null,"nav_link":"/invitations/themed-birthday"},{"title":"Funny Birthday","slug":"funny-birthday","icon_xs":null,"icon_xl":null,"bg_color":null,"nav_link":"/invitations/funny-birthday"},{"title":"For her","slug":"invitation-for-her","icon_xs":null,"icon_xl":null,"bg_color":null,"nav_link":"/invitations/invitation-for-her"}]
/// parent : null


class CategoryEntity {

  static List<CategoryEntity> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => CategoryEntity.fromJson(json)).toList();
  }

  CategoryEntity({
      String? title, 
      String? slug, 
      dynamic iconXs, 
      dynamic iconXl, 
      dynamic bgColor, 
      String? navLink, 
      Banner? banner, 
      Seo? seo, 
      List<Category>? category, 
      dynamic parent,}){
    _title = title;
    _slug = slug;
    _iconXs = iconXs;
    _iconXl = iconXl;
    _bgColor = bgColor;
    _navLink = navLink;
    _banner = banner;
    _seo = seo;
    _category = category;
    _parent = parent;
}

  CategoryEntity.fromJson(dynamic json) {
    _title = json['title'];
    _slug = json['slug'];
    _iconXs = json['icon_xs'];
    _iconXl = json['icon_xl'];
    _bgColor = json['bg_color'];
    _navLink = json['nav_link'];
    _banner = json['banner'] != null ? Banner.fromJson(json['banner']) : null;
    _seo = json['seo'] != null ? Seo.fromJson(json['seo']) : null;
    if (json['category'] != null) {
      _category = [];
      json['category'].forEach((v) {
        _category?.add(Category.fromJson(v));
      });
    }
    _parent = json['parent'];
  }
  String? _title;
  String? _slug;
  dynamic _iconXs;
  dynamic _iconXl;
  dynamic _bgColor;
  String? _navLink;
  Banner? _banner;
  Seo? _seo;
  List<Category>? _category;
  dynamic _parent;
CategoryEntity copyWith({  String? title,
  String? slug,
  dynamic iconXs,
  dynamic iconXl,
  dynamic bgColor,
  String? navLink,
  Banner? banner,
  Seo? seo,
  List<Category>? category,
  dynamic parent,
}) => CategoryEntity(  title: title ?? _title,
  slug: slug ?? _slug,
  iconXs: iconXs ?? _iconXs,
  iconXl: iconXl ?? _iconXl,
  bgColor: bgColor ?? _bgColor,
  navLink: navLink ?? _navLink,
  banner: banner ?? _banner,
  seo: seo ?? _seo,
  category: category ?? _category,
  parent: parent ?? _parent,
);
  String? get title => _title;
  String? get slug => _slug;
  dynamic get iconXs => _iconXs;
  dynamic get iconXl => _iconXl;
  dynamic get bgColor => _bgColor;
  String? get navLink => _navLink;
  Banner? get banner => _banner;
  Seo? get seo => _seo;
  List<Category>? get category => _category;
  dynamic get parent => _parent;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['slug'] = _slug;
    map['icon_xs'] = _iconXs;
    map['icon_xl'] = _iconXl;
    map['bg_color'] = _bgColor;
    map['nav_link'] = _navLink;
    if (_banner != null) {
      map['banner'] = _banner?.toJson();
    }
    if (_seo != null) {
      map['seo'] = _seo?.toJson();
    }
    if (_category != null) {
      map['category'] = _category?.map((v) => v.toJson()).toList();
    }
    map['parent'] = _parent;
    return map;
  }

}

/// title : "Kids Birthday"
/// slug : "kids-birthday"
/// icon_xs : null
/// icon_xl : null
/// bg_color : null
/// nav_link : "/invitations/kids-birthday"

class Category {
  Category({
      String? title, 
      String? slug, 
      dynamic iconXs, 
      dynamic iconXl, 
      dynamic bgColor, 
      String? navLink,}){
    _title = title;
    _slug = slug;
    _iconXs = iconXs;
    _iconXl = iconXl;
    _bgColor = bgColor;
    _navLink = navLink;
}

  Category.fromJson(dynamic json) {
    _title = json['title'];
    _slug = json['slug'];
    _iconXs = json['icon_xs'];
    _iconXl = json['icon_xl'];
    _bgColor = json['bg_color'];
    _navLink = json['nav_link'];
  }
  String? _title;
  String? _slug;
  dynamic _iconXs;
  dynamic _iconXl;
  dynamic _bgColor;
  String? _navLink;
Category copyWith({  String? title,
  String? slug,
  dynamic iconXs,
  dynamic iconXl,
  dynamic bgColor,
  String? navLink,
}) => Category(  title: title ?? _title,
  slug: slug ?? _slug,
  iconXs: iconXs ?? _iconXs,
  iconXl: iconXl ?? _iconXl,
  bgColor: bgColor ?? _bgColor,
  navLink: navLink ?? _navLink,
);
  String? get title => _title;
  String? get slug => _slug;
  dynamic get iconXs => _iconXs;
  dynamic get iconXl => _iconXl;
  dynamic get bgColor => _bgColor;
  String? get navLink => _navLink;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['slug'] = _slug;
    map['icon_xs'] = _iconXs;
    map['icon_xl'] = _iconXl;
    map['bg_color'] = _bgColor;
    map['nav_link'] = _navLink;
    return map;
  }

}

/// meta_title : "Birthday Invitations"
/// meta_description : "Find the perfect birthday invitation for all ages and themes. Explore our collection of fun, unique, and themed birthday invitations."
/// page_title : "Birthday Invitations"
/// page_description : "Celebrate every birthday in style! Choose from our range of personalized invitations to make the day extra special."
/// canonical_url : "/categories/birthday"

class Seo {
  Seo({
      String? metaTitle, 
      String? metaDescription, 
      String? pageTitle, 
      String? pageDescription, 
      String? canonicalUrl,}){
    _metaTitle = metaTitle;
    _metaDescription = metaDescription;
    _pageTitle = pageTitle;
    _pageDescription = pageDescription;
    _canonicalUrl = canonicalUrl;
}

  Seo.fromJson(dynamic json) {
    _metaTitle = json['meta_title'];
    _metaDescription = json['meta_description'];
    _pageTitle = json['page_title'];
    _pageDescription = json['page_description'];
    _canonicalUrl = json['canonical_url'];
  }
  String? _metaTitle;
  String? _metaDescription;
  String? _pageTitle;
  String? _pageDescription;
  String? _canonicalUrl;
Seo copyWith({  String? metaTitle,
  String? metaDescription,
  String? pageTitle,
  String? pageDescription,
  String? canonicalUrl,
}) => Seo(  metaTitle: metaTitle ?? _metaTitle,
  metaDescription: metaDescription ?? _metaDescription,
  pageTitle: pageTitle ?? _pageTitle,
  pageDescription: pageDescription ?? _pageDescription,
  canonicalUrl: canonicalUrl ?? _canonicalUrl,
);
  String? get metaTitle => _metaTitle;
  String? get metaDescription => _metaDescription;
  String? get pageTitle => _pageTitle;
  String? get pageDescription => _pageDescription;
  String? get canonicalUrl => _canonicalUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['meta_title'] = _metaTitle;
    map['meta_description'] = _metaDescription;
    map['page_title'] = _pageTitle;
    map['page_description'] = _pageDescription;
    map['canonical_url'] = _canonicalUrl;
    return map;
  }

}

/// title : "Birthday Invitations"
/// sub_title : "Celebrate every special moment."
/// description : "Make birthdays unforgettable with our vibrant invitations."
/// background_color : "#fbf6ee"

class Banner {
  Banner({
      String? title, 
      String? subTitle, 
      String? description, 
      String? backgroundColor,}){
    _title = title;
    _subTitle = subTitle;
    _description = description;
    _backgroundColor = backgroundColor;
}

  Banner.fromJson(dynamic json) {
    _title = json['title'];
    _subTitle = json['sub_title'];
    _description = json['description'];
    _backgroundColor = json['background_color'];
  }
  String? _title;
  String? _subTitle;
  String? _description;
  String? _backgroundColor;
Banner copyWith({  String? title,
  String? subTitle,
  String? description,
  String? backgroundColor,
}) => Banner(  title: title ?? _title,
  subTitle: subTitle ?? _subTitle,
  description: description ?? _description,
  backgroundColor: backgroundColor ?? _backgroundColor,
);
  String? get title => _title;
  String? get subTitle => _subTitle;
  String? get description => _description;
  String? get backgroundColor => _backgroundColor;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['sub_title'] = _subTitle;
    map['description'] = _description;
    map['background_color'] = _backgroundColor;
    return map;
  }

}