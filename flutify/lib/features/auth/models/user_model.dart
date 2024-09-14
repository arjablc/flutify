import 'dart:convert';

import 'package:equatable/equatable.dart';

//ignoring cause only final fields are passed in as props
// ignore: must_be_immutable
class UserModel extends Equatable {
  final String? id;
  final String name;
  final String email;
  String? password;
  String? accessToken;

  UserModel({required this.name, required this.email, this.id, this.password, this.accessToken});

  UserModel copyWith(
          {String? name, String? id, String? email, String? password, String? accessToken}) =>
      UserModel(
          id: id ?? this.id,
          name: name ?? this.name,
          email: email ?? this.email,
          password: password ?? this.password,
          accessToken: accessToken ?? this.accessToken);

  factory UserModel.fromRawJson(String str) => UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        password: json['password'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'password': password,
      };
  @override
  String toString() {
    return 'name: $name, email: $email,';
  }

  @override
  // TODO: implement props
  List<Object?> get props => [email, id];
}
