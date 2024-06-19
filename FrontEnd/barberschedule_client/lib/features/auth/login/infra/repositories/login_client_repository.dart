import 'package:barberschedule_client/features/auth/login/domain/dto/requests/login_client_request.dart';
import 'package:barberschedule_client/features/auth/login/domain/dto/responses/login_client_response.dart';
import 'package:barberschedule_client/features/auth/login/domain/repositories/i_login_client_repository.dart';
import 'package:barberschedule_client/features/auth/login/infra/datasources/i_login_client_datasource.dart';

class LoginClientRepository extends ILoginClientRepository {
  LoginClientRepository({required ILoginClientDataSource dataSource})
      : _dataSource = dataSource;
  final ILoginClientDataSource _dataSource;

  @override
  Future<LoginClientResponse> login(String email, String password) async {
    var request = LoginClientRequest(email: email, password: password);

    var result = await _dataSource.loginCLient(request);

    return result;
  }
}
