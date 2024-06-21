import '../models/current_order_dto.dart';

abstract class IScheduledTimeRepository {
  Future<CurrentOrderDto?> getNextOrder(String userId);
}
