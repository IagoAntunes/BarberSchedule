import 'package:barberschedule_client/core/response/base_response_api.dart';
import 'package:barberschedule_client/features/auth/register/domain/dto/register_client_request.dart';

abstract class IRegisterClientDataSource {
  Future<BaseApiResponse> register(RegisterClientRequest request);
}
