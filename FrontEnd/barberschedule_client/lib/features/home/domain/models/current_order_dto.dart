import 'dart:convert';

class CurrentOrderDto {
  final String orderId;
  final String userId;
  final String barberShopId;
  final String dateTime;
  final String paymentMethodId;
  final int price;
  final String status;
  final String nameBarberShop;
  CurrentOrderDto({
    required this.orderId,
    required this.userId,
    required this.barberShopId,
    required this.dateTime,
    required this.paymentMethodId,
    required this.price,
    required this.status,
    required this.nameBarberShop,
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
      'nameBarberShop': nameBarberShop,
    };
  }

  factory CurrentOrderDto.fromMap(Map<String, dynamic> map) {
    return CurrentOrderDto(
      orderId: map['orderId'] as String,
      userId: map['userId'] as String,
      barberShopId: map['barberShopId'] as String,
      dateTime: map['dateTime'] as String,
      paymentMethodId: map['paymentMethodId'] as String,
      price: map['price'] as int,
      status: map['status'] as String,
      nameBarberShop: map['nameBarberShop'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CurrentOrderDto.fromJson(String source) =>
      CurrentOrderDto.fromMap(json.decode(source) as Map<String, dynamic>);
}
