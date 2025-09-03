class SubcategoriesAndFilterModel {
  SubcategoriesAndFilterModel({
    String? title,
    String? slug,
    String? iconXs,
    String? iconXl,
    String? bgColor,
    String? navLink,
    List<Attributes>? attributes,
    Banner? banner,
    Seo? seo,
    List<Category>? category,
  }) {
    _title = title;
    _slug = slug;
    _iconXs = iconXs;
    _iconXl = iconXl;
    _bgColor = bgColor;
    _navLink = navLink;
    _attributes = attributes;
    _banner = banner;
    _seo = seo;
    _category = category;
  }

  SubcategoriesAndFilterModel.fromJson(dynamic json) {
    _title = json['title'];
    _slug = json['slug'];
    _iconXs = json['icon_xs'];
    _iconXl = json['icon_xl'];
    _bgColor = json['bg_color'];
    _navLink = json['nav_link'];
    if (json['attributes'] != null) {
      _attributes = [];
      json['attributes'].forEach((v) {
        _attributes?.add(Attributes.fromJson(v));
      });
    }
    _banner = json['banner'] != null ? Banner.fromJson(json['banner']) : null;
    _seo = json['seo'] != null ? Seo.fromJson(json['seo']) : null;
    if (json['category'] != null) {
      _category = [];
      json['category'].forEach((v) {
        _category?.add(Category.fromJson(v));
      });
    }
  }
  String? _title;
  String? _slug;
  String? _iconXs;
  String? _iconXl;
  String? _bgColor;
  String? _navLink;
  List<Attributes>? _attributes;
  Banner? _banner;
  Seo? _seo;
  List<Category>? _category;

  String? get title => _title;
  String? get slug => _slug;
  String? get iconXs => _iconXs;
  String? get iconXl => _iconXl;
  String? get bgColor => _bgColor;
  String? get navLink => _navLink;
  List<Attributes>? get attributes => _attributes;
  Banner? get banner => _banner;
  Seo? get seo => _seo;
  List<Category>? get category => _category;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['slug'] = _slug;
    map['icon_xs'] = _iconXs;
    map['icon_xl'] = _iconXl;
    map['bg_color'] = _bgColor;
    map['nav_link'] = _navLink;
    if (_attributes != null) {
      map['attributes'] = _attributes?.map((v) => v.toJson()).toList();
    }
    if (_banner != null) {
      map['banner'] = _banner?.toJson();
    }
    if (_seo != null) {
      map['seo'] = _seo?.toJson();
    }
    if (_category != null) {
      map['category'] = _category?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Category {
  Category({
    String? title,
    String? slug,
    String? iconXs,
    String? iconXl,
    String? bgColor,
    String? navLink,
  }) {
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
  String? _iconXs;
  String? _iconXl;
  String? _bgColor;
  String? _navLink;

  String? get title => _title;
  String? get slug => _slug;
  String? get iconXs => _iconXs;
  String? get iconXl => _iconXl;
  String? get bgColor => _bgColor;
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

class Seo {
  Seo({
    String? metaTitle,
    String? metaDescription,
    String? pageTitle,
    String? pageDescription,
    String? canonicalUrl,
  }) {
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

class Banner {
  Banner({
    String? title,
    String? subTitle,
    String? description,
    String? backgroundColor,
  }) {
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

class Attributes {
  Attributes({
    String? name,
    List<Values>? values,
  }) {
    _name = name;
    _values = values;
  }

  Attributes.fromJson(dynamic json) {
    _name = json['name'];
    if (json['values'] != null) {
      _values = [];
      json['values'].forEach((v) {
        _values?.add(Values.fromJson(v));
      });
    }
  }
  String? _name;
  List<Values>? _values;

  String? get name => _name;
  List<Values>? get values => _values;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    if (_values != null) {
      map['values'] = _values?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Values {
  Values({
    String? name,
    String? value,
    String? rgb,
  }) {
    _name = name;
    _value = value;
    _rgb = rgb;
  }

  Values.fromJson(dynamic json) {
    _name = json['name'];
    _value = json['value'];
    _rgb = json['rgb'];
  }
  String? _name;
  String? _value;
  String? _rgb;

  String? get name => _name;
  String? get value => _value;
  String? get rgb => _rgb;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['value'] = _value;
    map['rgb'] = _rgb;
    return map;
  }
}
