import 'dart:convert';

class RegisterClientRequest {
  String email;
  String name;
  String phoneNumber;
  String password;
  String roleName = "CLIENT";
  String photo;
  RegisterClientRequest({
    required this.email,
    required this.name,
    required this.phoneNumber,
    required this.password,
    required this.photo,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
      'password': password,
      'roleName': roleName,
      'photo': photo,
    };
  }

  String toJson() => json.encode(toMap());
}/*

  "email": "string",
  "name": "string",
  "phoneNumber": "string",
  "password": "string",
  "roleName": "string",
  "photo": "string"
}
*/
