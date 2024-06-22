import '../../../../../core/response/base_response_api.dart';
import '../../../../../core/response/base_service_response.dart';
import '../../domain/dto/register_barbershop_request.dart';

abstract class IRegisterBarberShopDataSource {
  Future<BaseApiResponse> register(RegisterBarberShopRequest request);

  Future<ResponseDataObject> getPaymentMethods();
}
