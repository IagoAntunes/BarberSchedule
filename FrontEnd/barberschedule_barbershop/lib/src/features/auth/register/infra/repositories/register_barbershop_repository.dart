import 'package:barberschedule_barbershop/src/core/response/base_service_response.dart';
import 'package:barberschedule_barbershop/src/features/auth/login/domain/models/payment_method_model.dart';
import 'package:barberschedule_barbershop/src/features/auth/register/domain/repositories/i_register_barbershop_repository.dart';

import '../../../../../core/response/base_response_api.dart';
import '../../domain/dto/register_barbershop_request.dart';
import '../../domain/models/register_barbershop_model.dart';
import '../datasource/i_register_barbershop_datasource.dart';

class RegisterBarberShopRepository extends IRegisterBarberShopRepository {
  RegisterBarberShopRepository(
      {required IRegisterBarberShopDataSource dataSource})
      : _dataSource = dataSource;
  final IRegisterBarberShopDataSource _dataSource;
  @override
  Future<BaseApiResponse> registerBarberShop(
    RegisterBarberShopModel barberShopModel,
  ) async {
    var request = RegisterBarberShopRequest(
      email: barberShopModel.email,
      name: barberShopModel.name,
      phoneNumber: barberShopModel.phoneNumber,
      password: barberShopModel.password,
      photo: barberShopModel.photo,
      availableTimes: barberShopModel.avaibleTimes,
      city: barberShopModel.city,
      description: barberShopModel.description,
      number: barberShopModel.number,
      price: double.parse(barberShopModel.price),
      state: barberShopModel.state,
      paymentMethods: barberShopModel.paymentMethods,
    );

    final result = await _dataSource.register(request);
    return result;
  }

  @override
  Future<List<PaymentMethodModel>> getPaymentMethods() async {
    final result = await _dataSource.getPaymentMethods();

    if (result is SuccessResponseData) {
      return (result.data['data'] as List)
          .map((e) => PaymentMethodModel.fromMap(e))
          .toList();
    }

    return [];
  }
}
