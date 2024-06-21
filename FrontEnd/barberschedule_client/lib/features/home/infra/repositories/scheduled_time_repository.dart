import 'package:barberschedule_client/core/response/base_service_response.dart';
import 'package:barberschedule_client/features/home/domain/queryParameters/get_next_order_query_parameter.dart';
import 'package:barberschedule_client/features/home/domain/repositories/i_scheduled_time_repository.dart';
import 'package:barberschedule_client/features/home/domain/request/schedule_time_request.dart';
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

  @override
  Future<ResponseDataObject> scheduleTime(
      String userId,
      String barberShopId,
      String dateTime,
      String paymentMethodId,
      double price,
      String status) async {
    var request = ScheduleTimeRequest(
      barberShopId: barberShopId,
      dateTime: dateTime,
      paymentMethodId: paymentMethodId,
      price: price,
      status: status,
      userId: userId,
    );
    var result = await _scheduledTimeDataSource.scheduleTime(request);
    return result;
  }
}
