import 'package:barberschedule_client/core/response/base_service_response.dart';

import '../models/current_order_dto.dart';

abstract class IScheduledTimeRepository {
  Future<CurrentOrderDto?> getNextOrder(String userId);
  Future<ResponseDataObject> scheduleTime(
    String userId,
    String barberShopId,
    String dateTime,
    String paymentMethodId,
    double price,
    String status,
  );
}
