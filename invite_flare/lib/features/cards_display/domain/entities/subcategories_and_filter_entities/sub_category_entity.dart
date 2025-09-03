class SubCategoryEntity {
  SubCategoryEntity({
    String? title,
    String? slug,
    String? iconXs,
    String? iconXl,
    String? bgColor,
  }) {
    _title = title;
    _slug = slug;
    _iconXs = iconXs;
    _iconXl = iconXl;
    _bgColor = bgColor;
  }

  SubCategoryEntity.fromJson(dynamic json) {
    _title = json['title'];
    _slug = json['slug'];
    _iconXs = json['icon_xs'];
    _iconXl = json['icon_xl'];
    _bgColor = json['bg_color'];
  }

  String? _title;
  String? _slug;
  String? _iconXs;
  String? _iconXl;
  String? _bgColor;
  bool _isSelected = false;

  String? get title => _title;

  String? get slug => _slug;

  String? get iconXs => _iconXs;

  String? get iconXl => _iconXl;

  String? get bgColor => _bgColor;

  bool get isSelected => _isSelected;

  set isSelected(bool value) => _isSelected = value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['slug'] = _slug;
    map['icon_xs'] = _iconXs;
    map['icon_xl'] = _iconXl;
    map['bg_color'] = _bgColor;
    return map;
  }
}
