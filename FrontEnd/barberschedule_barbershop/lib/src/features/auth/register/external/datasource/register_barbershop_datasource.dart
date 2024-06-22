import 'package:barberschedule_barbershop/src/core/response/base_service_response.dart';

import '../../../../../core/response/base_response_api.dart';
import '../../../../../core/utils/app_api_routes.dart';
import '../../../../../services/http/i_http_service.dart';
import '../../domain/dto/register_barbershop_request.dart';
import '../../infra/datasource/i_register_barbershop_datasource.dart';

class RegisterBarberShopDataSource extends IRegisterBarberShopDataSource {
  final IHttpService _httpService;
  RegisterBarberShopDataSource({
    required IHttpService httpService,
  }) : _httpService = httpService;
  @override
  Future<BaseApiResponse> register(RegisterBarberShopRequest request) async {
    try {
      final result = await _httpService.post(
        AppApiRoutes.registerBarberShop(),
        request.toJson(),
      );
      if (result!.statusCode == 200) {
        return BaseApiResponse.success();
      } else {
        return BaseApiResponse.failure();
      }
    } catch (e) {
      return BaseApiResponse.failure();
    }
  }

  @override
  Future<ResponseDataObject> getPaymentMethods() async {
    try {
      final result = await _httpService.get(
        AppApiRoutes.getAllPaymentMethods(),
      );
      if (result!.statusCode == 200) {
        return ResponseData.success(result.data);
      } else {
        return ResponseData.error({'error': 'error'});
      }
    } catch (e) {
      return ResponseData.error({'error': 'error'});
    }
  }
}
