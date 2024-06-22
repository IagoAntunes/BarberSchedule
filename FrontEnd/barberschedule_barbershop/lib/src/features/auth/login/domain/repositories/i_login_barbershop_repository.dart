import '../dto/responses/login_barbershop_response.dart';

abstract class ILoginBarberShopRepository {
  Future<LoginBarberShopResponse> login(String email, String password);
}
