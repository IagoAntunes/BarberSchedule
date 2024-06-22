import 'package:barberschedule_barbershop/src/features/auth/login/domain/models/barbershop_model.dart';

import '../../../../../core/utils/app_api_routes.dart';
import '../../../../../services/http/i_http_service.dart';
import '../../domain/dto/requests/login_barbershop_request.dart';
import '../../domain/dto/responses/login_barbershop_response.dart';
import '../../infra/datasources/i_login_barbershop_datasource.dart';

class LoginBarberShopDataSource extends ILoginBarberShopDataSource {
  LoginBarberShopDataSource({required IHttpService httpService})
      : _httpService = httpService;
  final IHttpService _httpService;

  @override
  Future<LoginBarberShopResponse> loginBarberShop(
      LoginBarberShopRequest request) async {
    try {
      var result = await _httpService.post(
        AppApiRoutes.loginBarberShop(),
        request.toJson(),
      );

      if (result!.statusCode == 200) {
        return LoginBarberShopResponse(
          token: result.data['token'],
          barberShop: BarberShopModel.fromMap(result.data['barberShop']),
          isSuccess: true,
        );
      }
      return LoginBarberShopResponse.failure();
    } catch (e) {
      return LoginBarberShopResponse.failure();
    }
  }
}
