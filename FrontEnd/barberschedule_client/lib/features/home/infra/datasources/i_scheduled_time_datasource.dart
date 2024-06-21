import 'package:barberschedule_client/core/response/base_service_response.dart';

import '../../domain/queryParameters/get_next_order_query_parameter.dart';
import '../../domain/request/schedule_time_request.dart';

abstract class IScheduledTimeDataSource {
  Future<ResponseDataObject> getNextOrder(
    GetNextOrderQueryParameter queryParameter,
  );

  Future<ResponseDataObject> scheduleTime(
    ScheduleTimeRequest request,
  );
}
