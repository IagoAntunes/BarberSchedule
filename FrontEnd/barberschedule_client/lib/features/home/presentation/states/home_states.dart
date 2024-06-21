import 'package:barberschedule_client/features/home/domain/models/current_order_dto.dart';

abstract class IScheduledTimeState {}

class IdleScheduledTimeState extends IScheduledTimeState {}

class LoadingScheduledTimeState extends IScheduledTimeState {}

class SuccessScheduledTimeState extends IScheduledTimeState {
  final CurrentOrderDto? order;
  SuccessScheduledTimeState({
    required this.order,
  });
}

class FailureScheduledTimeState extends IScheduledTimeState {}
