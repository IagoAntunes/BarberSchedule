import '../models/order_model.dart';

class GetOrdersByUserIdResponse {
  final List<OrderModel> orders;

  GetOrdersByUserIdResponse({required this.orders});
}
