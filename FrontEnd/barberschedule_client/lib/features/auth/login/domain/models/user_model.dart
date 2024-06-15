import 'dart:convert';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String photo;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.photo,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'photo': photo,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    print(map);
    return UserModel(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phoneNumber'] as String,
      photo: map['photo'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
/*
{
  "user": {
    "id": "a3477a1e-0ee2-4c36-867e-8098938db312",
    "email": "iago@gmail.com",
    "name": "iago",
    "phoneNumber": "123456",
    "photo": ""
  },
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImlhZ29AZ21haWwuY29tIiwic3ViIjoiYTM0NzdhMWUtMGVlMi00YzM2LTg2N2UtODA5ODkzOGRiMzEyIiwibmFtZSI6ImlhZ28iLCJyb2xlIjoiQ0xJRU5UIiwibmJmIjoxNzE4NDAwNzI5LCJleHAiOjE3MTkwMDU1MjksImlhdCI6MTcxODQwMDcyOSwiaXNzIjoiYmFyYmVyc2NoZWR1bGUtYXV0aC1hcGkiLCJhdWQiOiJiYXJiZXJzY2hlZHVsZS1jbGllbnQifQ.NUEeRpxj5p8WcR7NYFY64EIp9qDfyG6-2jWMBCCaVzc"
}
*/