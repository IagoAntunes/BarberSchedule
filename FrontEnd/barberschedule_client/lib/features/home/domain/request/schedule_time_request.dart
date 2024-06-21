import 'dart:convert';

class ScheduleTimeRequest {
  final String userId;
  final String barberShopId;
  final String dateTime;
  final String paymentMethodId;
  final double price;
  final String status;

  ScheduleTimeRequest({
    required this.userId,
    required this.barberShopId,
    required this.dateTime,
    required this.paymentMethodId,
    required this.price,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'barberShopId': barberShopId,
      'dateTime': dateTime,
      'paymentMethodId': paymentMethodId,
      'price': price,
      'status': status,
    };
  }

  String toJson() {
    return json.encode(toMap());
  }
}
