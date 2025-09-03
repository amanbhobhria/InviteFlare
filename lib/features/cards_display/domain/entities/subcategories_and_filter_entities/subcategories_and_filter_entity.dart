import 'package:invite_flare/features/cards_display/domain/domain.dart';

class SubcategoriesAndFilterEntity {
  SubcategoriesAndFilterEntity({
    String? title,
    String? thumb,
    String? slug,
    String? iconXs,
    String? iconXl,
    String? bgColor,
    String? navLink,
    List<FilterEntity>? filters,
    Banner? banner,
    List<SubCategoryEntity>? subCategory,
  }) {
    _title = title;
    _thumb = thumb;
    _slug = slug;
    _iconXs = iconXs;
    _iconXl = iconXl;
    _bgColor = bgColor;
    _navLink = navLink;
    _filters = filters;
    _banner = banner;
    _subcategory = subCategory;
  }

  SubcategoriesAndFilterEntity.fromJson(dynamic json) {
    _title = json['title'];
    _thumb = json['thumb'];
    _slug = json['slug'];
    _iconXs = json['icon_xs'];
    _iconXl = json['icon_xl'];
    _bgColor = json['bg_color'];
    _navLink = json['nav_link'];
    if (json['attributes'] != null) {
      _filters = [];
      json['attributes'].forEach((v) {
        _filters?.add(FilterEntity.fromJson(v));
      });
    }
    _banner = json['banner'] != null ? Banner.fromJson(json['banner']) : null;
    if (json['category'] != null) {
      _subcategory = [];
      json['category'].forEach((v) {
        _subcategory?.add(SubCategoryEntity.fromJson(v));
      });
    }
  }

  String? _title;
  String? _thumb;
  String? _slug;
  String? _iconXs;
  String? _iconXl;
  String? _bgColor;
  String? _navLink;
  List<FilterEntity>? _filters;
  Banner? _banner;
  List<SubCategoryEntity>? _subcategory;

  String? get title => _title;

  String? get thumb => _thumb;

  String? get slug => _slug;

  String? get iconXs => _iconXs;

  String? get iconXl => _iconXl;

  String? get bgColor => _bgColor;

  String? get navLink => _navLink;

  List<FilterEntity>? get filters => _filters;

  Banner? get banner => _banner;

  List<SubCategoryEntity>? get subcategory => _subcategory;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['thumb'] = _thumb;
    map['slug'] = _slug;
    map['icon_xs'] = _iconXs;
    map['icon_xl'] = _iconXl;
    map['bg_color'] = _bgColor;
    map['nav_link'] = _navLink;
    if (_filters != null) {
      map['attributes'] = _filters?.map((v) => v.toJson()).toList();
    }
    if (_banner != null) {
      map['banner'] = _banner?.toJson();
    }
    if (_subcategory != null) {
      map['category'] = _subcategory?.map((v) => v.toJson()).toList();
    }
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
