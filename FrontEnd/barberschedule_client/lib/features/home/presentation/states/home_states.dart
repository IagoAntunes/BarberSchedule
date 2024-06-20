import 'package:barberschedule_client/features/home/domain/models/order_model.dart';

abstract class IScheduledTimeState {}

class IdleScheduledTimeState extends IScheduledTimeState {}

class LoadingScheduledTimeState extends IScheduledTimeState {}

class SuccessScheduledTimeState extends IScheduledTimeState {
  final OrderModel? order;
  SuccessScheduledTimeState({
    required this.order,
  });
}

class FailureScheduledTimeState extends IScheduledTimeState {}
