class FilterEntity {
  FilterEntity({
    String? name,
    List<Values>? values,
  }) {
    _name = name;
    _values = values;
  }

  FilterEntity.fromJson(dynamic json) {
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
  Values? _selectedValue;

  String? get name => _name;
  List<Values>? get values => _values;
  Values? get selectedValue => _selectedValue;

  set selectedValue(Values? value) {
    _selectedValue = value;
  }

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
