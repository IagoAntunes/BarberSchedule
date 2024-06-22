import 'dart:convert';

class RegisterBarberShopRequest {
  final String email;
  final String name;
  final String description;
  final String password;
  final String phoneNumber;
  final String state;
  final String city;
  final String number;
  final String photo;
  final String availableTimes;
  final double price;
  final List<int> paymentMethods;
  final String roleName;
  RegisterBarberShopRequest({
    required this.name,
    required this.email,
    required this.description,
    required this.password,
    required this.phoneNumber,
    required this.state,
    required this.city,
    required this.number,
    required this.photo,
    required this.availableTimes,
    required this.price,
    required this.paymentMethods,
    this.roleName = "BARBERSHOP",
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
      'description': description,
      'phoneNumber': phoneNumber,
      'state': state,
      'city': city,
      'number': number,
      'photo': photo,
      'availableTimes': availableTimes,
      'price': price,
      'paymentMethods': paymentMethods.map((x) => x).toList(),
      'roleName': roleName,
    };
  }

  String toJson() => json.encode(toMap());
}
