import '../../../../core/response/base_service_response.dart';
import '../../../marking_history/domain/queryParameters/get_orders_by_userid_query_parameter.dart';

abstract class IMarkingHistoryDataSource {
  Future<ResponseDataObject> getMarkingHistory(
      GetOrdersByUserIdQueryParameter queryParameter);
}
