import 'dart:convert';

import 'package:barberschedule_client/features/home/domain/models/barbershop_model.dart';

class OrderModel {
  final String orderId;
  final String userId;
  final String barberShopId;
  final String dateTime;
  final String paymentMethodId;
  final double price;
  final String status;
  final BarberShopModel? barberShop;
  OrderModel({
    required this.orderId,
    required this.userId,
    required this.barberShopId,
    required this.dateTime,
    required this.paymentMethodId,
    required this.price,
    required this.status,
    required this.barberShop,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderId': orderId,
      'userId': userId,
      'barberShopId': barberShopId,
      'dateTime': dateTime,
      'paymentMethodId': paymentMethodId,
      'price': price,
      'status': status,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      orderId: map['orderId'] as String,
      userId: map['userId'] as String,
      barberShopId: map['barberShopId'] as String,
      dateTime: map['dateTime'] as String,
      paymentMethodId: map['paymentMethodId'] as String,
      price: map['price'] as double,
      status: map['status'] as String,
      barberShop: map['barberShop'] == null
          ? null
          : BarberShopModel.fromMap(map['barberShop'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
