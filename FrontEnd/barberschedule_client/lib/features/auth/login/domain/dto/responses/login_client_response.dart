import 'package:barberschedule_client/core/response/base_response_api.dart';
import 'package:barberschedule_client/features/auth/login/domain/models/user_model.dart';

class LoginClientResponse extends BaseApiResponse {
  final String token;
  final UserModel? user;

  LoginClientResponse({
    required this.token,
    required this.user,
    required super.isSuccess,
  });
  LoginClientResponse.failure({
    this.token = '',
    this.user,
    super.isSuccess = false,
  });
}
