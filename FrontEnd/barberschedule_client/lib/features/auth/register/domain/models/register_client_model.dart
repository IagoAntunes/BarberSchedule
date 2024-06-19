import 'dart:convert';

class RegisterClientModel {
  String email;
  String name;
  String phoneNumber;
  String password;
  String photo;
  RegisterClientModel({
    required this.email,
    required this.name,
    required this.phoneNumber,
    required this.password,
    required this.photo,
  });
  RegisterClientModel.empty({
    this.email = '',
    this.name = '',
    this.phoneNumber = '',
    this.password = '',
    this.photo = '',
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
      'password': password,
      'photo': photo,
    };
  }

  factory RegisterClientModel.fromMap(Map<String, dynamic> map) {
    return RegisterClientModel(
      email: map['email'] as String,
      name: map['name'] as String,
      phoneNumber: map['phoneNumber'] as String,
      password: map['password'] as String,
      photo: map['photo'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterClientModel.fromJson(String source) =>
      RegisterClientModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
