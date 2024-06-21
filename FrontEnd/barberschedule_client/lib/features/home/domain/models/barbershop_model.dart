// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'payment_method_model.dart';

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
  final List<PaymentMethodModel> paymentMethods;
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
    required this.paymentMethods,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'name': name,
      'description': description,
      'phoneNumber': phoneNumber,
      'state': state,
      'city': city,
      'number': number,
      'availableTimes': availableTimes,
      'price': price,
      'paymentMethods': paymentMethods.map((x) => x.toMap()).toList(),
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
      paymentMethods: List<PaymentMethodModel>.from(
        (map['paymentMethods'] as List<dynamic>).map<PaymentMethodModel>(
          (x) => PaymentMethodModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory BarberShopModel.fromJson(String source) =>
      BarberShopModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
