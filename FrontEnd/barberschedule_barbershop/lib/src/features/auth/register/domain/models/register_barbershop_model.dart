class RegisterBarberShopModel {
  String name;
  String description;
  String state;
  String city;
  String number;
  String photo;
  String avaibleTimes;
  String price;
  List<int> paymentMethods;

  String email;
  String phoneNumber;
  String password;
  String roleName;
  RegisterBarberShopModel({
    required this.name,
    required this.description,
    required this.state,
    required this.city,
    required this.number,
    required this.photo,
    required this.avaibleTimes,
    required this.price,
    required this.paymentMethods,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.roleName,
  });
  RegisterBarberShopModel.empty({
    this.name = '',
    this.description = '',
    this.state = '',
    this.city = '',
    this.number = '',
    this.photo = '',
    this.avaibleTimes = '',
    this.price = '',
    this.email = '',
    this.phoneNumber = '',
    this.password = '',
    this.roleName = '',
    this.paymentMethods = const [],
  });
}
