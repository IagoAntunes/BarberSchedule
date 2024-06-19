import 'package:barberschedule_client/features/auth/login/domain/dto/requests/login_client_request.dart';
import 'package:barberschedule_client/features/auth/login/domain/dto/responses/login_client_response.dart';

abstract class ILoginClientDataSource {
  Future<LoginClientResponse> loginCLient(LoginClientRequest request);
}
