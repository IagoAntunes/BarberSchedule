import '../../../../../core/response/base_response_api.dart';
import '../../../login/domain/models/payment_method_model.dart';
import '../models/register_barbershop_model.dart';

abstract class IRegisterBarberShopRepository {
  Future<BaseApiResponse> registerBarberShop(
      RegisterBarberShopModel barberShopModel);
  Future<List<PaymentMethodModel>> getPaymentMethods();
}
