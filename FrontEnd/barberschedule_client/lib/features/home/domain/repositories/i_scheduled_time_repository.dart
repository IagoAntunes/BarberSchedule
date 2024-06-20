import 'package:barberschedule_client/features/home/domain/models/order_model.dart';

abstract class IScheduledTimeRepository {
  Future<OrderModel?> getNextOrder(String userId);
}
