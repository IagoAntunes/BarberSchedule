import 'package:barberschedule_client/features/auth/register/domain/models/register_client_model.dart';

import '../../../../../core/response/base_response_api.dart';

abstract class IRegisterClientRepository {
  Future<BaseApiResponse> registerClient(RegisterClientModel clientModel);
}
