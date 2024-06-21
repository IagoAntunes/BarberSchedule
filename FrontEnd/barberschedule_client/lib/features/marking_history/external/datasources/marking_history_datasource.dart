import 'dart:io';

import 'package:barberschedule_client/core/utils/app_api_routes.dart';
import 'package:barberschedule_client/services/http/i_http_service.dart';

import '../../../../core/response/base_service_response.dart';
import '../../domain/queryParameters/get_orders_by_userid_query_parameter.dart';
import '../../infra/datasources/i_marking_history_datasource.dart';

class MarkingHistoryDataSource implements IMarkingHistoryDataSource {
  MarkingHistoryDataSource({required IHttpService httpService})
      : _httpService = httpService;
  final IHttpService _httpService;

  @override
  Future<ResponseDataObject> getMarkingHistory(
      GetOrdersByUserIdQueryParameter queryParameter) async {
    try {
      final response = await _httpService.get(
        AppApiRoutes.getOrdersByUserId(),
        queryParameters: queryParameter.toMap(),
      );
      if (response!.statusCode == HttpStatus.ok) {
        return ResponseData.success(response.data);
      }
      return ResponseData.error({'data': 'error'});
    } catch (e) {
      return ResponseData.error({'data': 'error'});
    }
  }
}
