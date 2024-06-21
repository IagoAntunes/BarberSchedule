import 'dart:convert';

class PaymentMethodModel {
  int idPaymentMethod;
  String name;
  PaymentMethodModel({
    required this.idPaymentMethod,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idPaymentMethod': idPaymentMethod,
      'name': name,
    };
  }

  factory PaymentMethodModel.fromMap(Map<String, dynamic> map) {
    return PaymentMethodModel(
      idPaymentMethod: map['idPaymentMethod'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentMethodModel.fromJson(String source) =>
      PaymentMethodModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
