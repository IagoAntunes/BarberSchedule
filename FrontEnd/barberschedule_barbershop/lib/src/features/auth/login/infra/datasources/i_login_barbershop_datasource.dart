import '../../domain/dto/requests/login_barbershop_request.dart';
import '../../domain/dto/responses/login_barbershop_response.dart';

abstract class ILoginBarberShopDataSource {
  Future<LoginBarberShopResponse> loginBarberShop(
      LoginBarberShopRequest request);
}
