import 'package:barberschedule_client/features/auth/login/domain/dto/responses/login_client_response.dart';

abstract class ILoginClientRepository {
  Future<LoginClientResponse> login(String email, String password);
}
