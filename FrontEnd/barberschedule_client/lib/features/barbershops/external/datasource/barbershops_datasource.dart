import 'dart:io';

import 'package:barberschedule_client/core/response/base_service_response.dart';
import 'package:barberschedule_client/core/utils/app_api_routes.dart';
import 'package:barberschedule_client/features/barbershops/intra/datasource/i_barbershops_datasource.dart';
import 'package:barberschedule_client/services/http/i_http_service.dart';

class BarbershopsDataSource extends IBarberShopsDataSource {
  BarbershopsDataSource({required IHttpService httpService})
      : _httpService = httpService;
  final IHttpService _httpService;

  @override
  Future<ResponseDataObject> getBarberShops() async {
    try {
      final response = await _httpService.get(
        AppApiRoutes.getAllBarberShops(),
      );
      if (response!.statusCode == HttpStatus.ok) {
        return ResponseData.success(response.data);
      }
      return ResponseData.error(response.data);
    } catch (e) {
      return ResponseData.error({'data': 'error'});
    }
  }
}
