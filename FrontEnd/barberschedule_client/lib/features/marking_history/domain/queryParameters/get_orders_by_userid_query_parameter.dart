import 'dart:convert';

class GetOrdersByUserIdQueryParameter {
  String userId;
  GetOrdersByUserIdQueryParameter({
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
    };
  }

  String toJson() => json.encode(toMap());
}
