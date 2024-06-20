import 'dart:io';

import 'package:barberschedule_client/core/response/base_service_response.dart';
import 'package:barberschedule_client/core/utils/app_api_routes.dart';
import 'package:barberschedule_client/features/home/domain/queryParameters/get_next_order_query_parameter.dart';
import 'package:barberschedule_client/features/home/infra/datasources/i_scheduled_time_datasource.dart';
import 'package:barberschedule_client/services/http/i_http_service.dart';

class ScheduledTimeDataSource implements IScheduledTimeDataSource {
  ScheduledTimeDataSource({required IHttpService httpService})
      : _httpService = httpService;

  final IHttpService _httpService;

  @override
  Future<ResponseDataObject> getNextOrder(
      GetNextOrderQueryParameter queryParameter) async {
    try {
      final result = await _httpService.get(
        AppApiRoutes.getNextOrder(),
        queryParameters: queryParameter.toMap(),
      );
      if (result!.statusCode == HttpStatus.ok) {
        return ResponseData.success(result.data);
      }
      return ResponseData.error({'data': 'error'});
    } catch (e) {
      return ResponseData.error(e.toString());
    }
  }
}
