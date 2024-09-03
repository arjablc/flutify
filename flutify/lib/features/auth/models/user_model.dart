import 'dart:convert';

class UserModel {
  String? name;
  String? email;
  String? password;

  UserModel({
    this.name,
    this.email,
    this.password,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? password,
  }) =>
      UserModel(
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
      );

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json['name'],
        email: json['email'],
        password: json['password'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
      };
  @override
  String toString() {
    return 'name: $name, email: $email, ';
  }
}
