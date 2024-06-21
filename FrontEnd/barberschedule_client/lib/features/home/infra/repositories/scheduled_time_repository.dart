import 'package:barberschedule_client/core/response/base_service_response.dart';
import 'package:barberschedule_client/features/home/domain/models/order_model.dart';
import 'package:barberschedule_client/features/home/domain/queryParameters/get_next_order_query_parameter.dart';
import 'package:barberschedule_client/features/home/domain/repositories/i_scheduled_time_repository.dart';
import 'package:barberschedule_client/features/home/infra/datasources/i_scheduled_time_datasource.dart';

import '../../domain/models/current_order_dto.dart';

class ScheduledTimeRepository implements IScheduledTimeRepository {
  ScheduledTimeRepository(
      {required IScheduledTimeDataSource scheduledTimeDataSource})
      : _scheduledTimeDataSource = scheduledTimeDataSource;
  final IScheduledTimeDataSource _scheduledTimeDataSource;
  @override
  Future<CurrentOrderDto?> getNextOrder(String userId) async {
    var queryParameter = GetNextOrderQueryParameter(userId: userId);
    var result = await _scheduledTimeDataSource.getNextOrder(queryParameter);
    if (result is SuccessResponseData) {
      return CurrentOrderDto.fromMap(result.data);
    } else {
      return null;
    }
  }
}
