class LoginBarberShopRequest {
  final String email;
  final String password;

  LoginBarberShopRequest({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
