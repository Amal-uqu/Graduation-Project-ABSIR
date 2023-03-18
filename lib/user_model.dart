class User {
  String? id;
  String? name;
  String? email;
  String? password;

  User({this.id,
    this.name,
    this.email,
    this.password
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'].toString();
    email = json['email'].toString();
    password = json['password'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}