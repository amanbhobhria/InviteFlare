class GuestEntity {
  GuestEntity({
    int? id,
    String? name,
    String? email,
  }) {
    _id = id;
    _name = name;
    _email = email;
  }

  GuestEntity.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _email = json['email'];
  }
  int? _id;
  String? _name;
  String? _email;

  int? get id => _id;
  String? get name => _name;
  String? get email => _email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['email'] = _email;
    return map;
  }
}
