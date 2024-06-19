import 'package:barberschedule_client/core/response/base_response_api.dart';
import 'package:barberschedule_client/features/auth/register/domain/dto/register_client_request.dart';
import 'package:barberschedule_client/features/auth/register/domain/models/register_client_model.dart';
import 'package:barberschedule_client/features/auth/register/domain/repositories/i_register_client_repository.dart';
import 'package:barberschedule_client/features/auth/register/infra/datasource/i_register_client_datasource.dart';

class RegisterClientRepository extends IRegisterClientRepository {
  RegisterClientRepository({required IRegisterClientDataSource dataSource})
      : _dataSource = dataSource;
  IRegisterClientDataSource _dataSource;
  @override
  Future<BaseApiResponse> registerClient(
    RegisterClientModel clientModel,
  ) async {
    var request = RegisterClientRequest(
      email: clientModel.email,
      name: clientModel.name,
      phoneNumber: clientModel.phoneNumber,
      password: clientModel.password,
      photo: clientModel.photo,
    );

    final result = await _dataSource.register(request);
    return result;
  }
}
