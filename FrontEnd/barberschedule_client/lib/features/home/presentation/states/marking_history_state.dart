import 'package:barberschedule_client/features/home/domain/models/order_model.dart';

abstract class IMarkingHistoryState {}

class IdleMarkingHistoryState extends IMarkingHistoryState {}

class LoadingMarkingHistoryState extends IMarkingHistoryState {}

class SuccessMarkingHistoryState extends IMarkingHistoryState {
  final List<OrderModel> markingHistory;

  SuccessMarkingHistoryState(this.markingHistory);
}

class FailureMarkingHistoryState extends IMarkingHistoryState {
  String message;
  FailureMarkingHistoryState(this.message);
}
