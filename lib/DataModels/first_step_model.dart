// To parse this JSON data, do
//
//     final signUpOneModel = signUpOneModelFromJson(jsonString);

import 'dart:convert';

SignUpOneModel signUpOneModelFromJson(String str) => SignUpOneModel.fromJson(json.decode(str));

String signUpOneModelToJson(SignUpOneModel data) => json.encode(data.toJson());

class SignUpOneModel {
  SignUpOneModel({
    this.phoneNumber,
    this.password,
    this.email,
    this.name,
    this.countryCode,
  });

  final String? phoneNumber;
  final String? password;
  final String? email;
  final String? name;
  final String? countryCode;

  factory SignUpOneModel.fromJson(Map<String, dynamic> json) => SignUpOneModel(
    phoneNumber: json["phoneNumber"],
    password: json["password"],
    email: json["email"],
    name: json["name"],
    countryCode: json["countryCode"],
  );

  Map<String, dynamic> toJson() => {
    "phoneNumber": phoneNumber,
    "password": password,
    "email": email,
    "name": name,
    "countryCode": countryCode,
  };
}
