import 'package:barberschedule_client/core/response/base_service_response.dart';
import 'package:barberschedule_client/features/home/domain/models/order_model.dart';

import '../../domain/queryParameters/get_orders_by_userid_query_parameter.dart';
import '../../domain/repositories/i_marking_history_repository.dart';
import '../datasources/i_marking_history_datasource.dart';

class MarkingHistoryRepository implements IMarkingHistoryRepository {
  MarkingHistoryRepository({required IMarkingHistoryDataSource dataSource})
      : _dataSource = dataSource;
  final IMarkingHistoryDataSource _dataSource;

  @override
  Future<List<OrderModel>?> getMarkingHistory(String userId) async {
    final result = await _dataSource
        .getMarkingHistory(GetOrdersByUserIdQueryParameter(userId: userId));

    if (result is SuccessResponseData) {
      List<OrderModel> orders = [];
      for (var item in result.data['data'] as List) {
        orders.add(OrderModel.fromMap(item));
      }
      return orders;
    } else {
      return null;
    }
  }
}
