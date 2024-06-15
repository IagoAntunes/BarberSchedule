import 'package:barberschedule_client/core/utils/app_api_routes.dart';
import 'package:barberschedule_client/features/auth/login/domain/dto/requests/login_client_request.dart';
import 'package:barberschedule_client/features/auth/login/domain/dto/responses/login_client_response.dart';
import 'package:barberschedule_client/features/auth/login/domain/models/user_model.dart';
import 'package:barberschedule_client/features/auth/login/infra/datasources/i_login_client_datasource.dart';
import 'package:barberschedule_client/services/http/i_http_service.dart';

class LoginClientDataSource extends ILoginClientDataSource {
  LoginClientDataSource({required IHttpService httpService})
      : _httpService = httpService;
  final IHttpService _httpService;

  @override
  Future<LoginClientResponse> loginCLient(LoginClientRequest request) async {
    try {
      var result = await _httpService.post(
        AppApiRoutes.loginClient(),
        request.toJson(),
      );

      if (result!.statusCode == 200) {
        return LoginClientResponse(
          token: result.data['token'],
          user: UserModel.fromMap(result.data['user']),
          isSuccess: true,
        );
      }
      return LoginClientResponse.failure();
    } catch (e) {
      return LoginClientResponse.failure();
    }
  }
}
