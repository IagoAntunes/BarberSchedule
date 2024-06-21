import 'package:barberschedule_client/core/response/base_service_response.dart';

abstract class IBarberShopsDataSource {
  Future<ResponseDataObject> getBarberShops();
}
