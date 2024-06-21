import 'dart:convert';

class BarberShopModel {
  final String id;
  final String userId;
  final String name;
  final String description;
  final String phoneNumber;
  final String state;
  final String city;
  final String number;
  final String availableTimes;
  final double price;
  BarberShopModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.description,
    required this.phoneNumber,
    required this.state,
    required this.city,
    required this.number,
    required this.availableTimes,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'name': name,
      'description': description,
      'phoneNumber': phoneNumber,
      'state': state,
      'city': city,
      'number': number,
      'availableTimes': availableTimes,
      'price': price,
    };
  }

  factory BarberShopModel.fromMap(Map<String, dynamic> map) {
    return BarberShopModel(
      id: map['id'].toString(),
      userId: map['userId'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      phoneNumber: map['phoneNumber'] as String,
      state: map['state'] as String,
      city: map['city'] as String,
      number: map['number'] as String,
      availableTimes: map['availableTimes'] as String,
      price: double.parse(map['price'].toString()),
    );
  }

  String toJson() => json.encode(toMap());

  factory BarberShopModel.fromJson(String source) =>
      BarberShopModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
