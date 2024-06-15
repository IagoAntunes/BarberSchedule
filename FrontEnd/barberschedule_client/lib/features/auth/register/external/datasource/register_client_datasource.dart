import 'package:barberschedule_client/core/response/base_response_api.dart';
import 'package:barberschedule_client/core/utils/app_api_routes.dart';
import 'package:barberschedule_client/features/auth/register/domain/dto/register_client_request.dart';
import 'package:barberschedule_client/features/auth/register/infra/datasource/i_register_client_datasource.dart';
import 'package:barberschedule_client/services/http/i_http_service.dart';

class RegisterClientDataSource extends IRegisterClientDataSource {
  final IHttpService _httpService;
  RegisterClientDataSource({
    required IHttpService httpService,
  }) : _httpService = httpService;
  @override
  Future<BaseApiResponse> register(RegisterClientRequest request) async {
    try {
      print("url -> ${AppApiRoutes.registerClient()}");
      print("data -> ${request.toJson()}");
      final result = await _httpService.post(
        AppApiRoutes.registerClient(),
        request.toJson(),
      );
      if (result!.statusCode == 200) {
        return BaseApiResponse.success();
      } else {
        return BaseApiResponse.failure();
      }
    } catch (e) {
      print(e);
      return BaseApiResponse.failure();
    }
  }
}
