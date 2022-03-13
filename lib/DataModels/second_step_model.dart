// To parse this JSON data, do
//
//     final signUpTwoModel = signUpTwoModelFromJson(jsonString);

import 'dart:convert';

SignUpTwoModel signUpTwoModelFromJson(String str) => SignUpTwoModel.fromJson(json.decode(str));

String signUpTwoModelToJson(SignUpTwoModel data) => json.encode(data.toJson());

class SignUpTwoModel {
  SignUpTwoModel({
    this.phoneNumber,
    this.password,
    this.email,
    this.name,
    this.countryCode,
    this.otpNumberForEmail,
    this.otpNumberForPhone,
  });

  final String? phoneNumber;
  final String? password;
  final String? email;
  final String? name;
  final String? countryCode;
  final String? otpNumberForEmail;
  final String? otpNumberForPhone;

  factory SignUpTwoModel.fromJson(Map<String, dynamic> json) => SignUpTwoModel(
    phoneNumber: json["phoneNumber"],
    password: json["password"],
    email: json["email"],
    name: json["name"],
    countryCode: json["countryCode"],
    otpNumberForEmail: json["otpNumberForEmail"],
    otpNumberForPhone: json["otpNumberForPhone"],
  );

  Map<String, dynamic> toJson() => {
    "phoneNumber": phoneNumber,
    "password": password,
    "email": email,
    "name": name,
    "countryCode": countryCode,
    "otpNumberForEmail": otpNumberForEmail,
    "otpNumberForPhone": otpNumberForPhone,
  };
}
