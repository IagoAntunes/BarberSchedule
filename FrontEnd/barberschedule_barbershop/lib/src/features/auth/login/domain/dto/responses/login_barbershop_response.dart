import 'package:barberschedule_barbershop/src/features/auth/login/domain/models/barbershop_model.dart';

import '../../../../../../core/response/base_response_api.dart';

class LoginBarberShopResponse extends BaseApiResponse {
  final String token;
  final BarberShopModel? barberShop;

  LoginBarberShopResponse({
    required this.token,
    required this.barberShop,
    required super.isSuccess,
  });
  LoginBarberShopResponse.failure({
    this.token = '',
    this.barberShop,
    super.isSuccess = false,
  });
}
