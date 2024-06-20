import 'package:barberschedule_client/features/home/domain/models/order_model.dart';

abstract class IMarkingHistoryRepository {
  Future<List<OrderModel>?> getMarkingHistory(String userId);
}
