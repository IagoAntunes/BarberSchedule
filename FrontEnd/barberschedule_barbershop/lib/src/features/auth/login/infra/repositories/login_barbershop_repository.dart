import '../../domain/dto/requests/login_barbershop_request.dart';
import '../../domain/dto/responses/login_barbershop_response.dart';
import '../../domain/repositories/i_login_barbershop_repository.dart';
import '../datasources/i_login_barbershop_datasource.dart';

class LoginBarberShopRepository extends ILoginBarberShopRepository {
  LoginBarberShopRepository({required ILoginBarberShopDataSource dataSource})
      : _dataSource = dataSource;
  final ILoginBarberShopDataSource _dataSource;

  @override
  Future<LoginBarberShopResponse> login(String email, String password) async {
    var request = LoginBarberShopRequest(email: email, password: password);

    var result = await _dataSource.loginBarberShop(request);

    return result;
  }
}
