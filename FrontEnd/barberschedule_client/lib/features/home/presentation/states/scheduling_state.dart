abstract class ISchedulingState {}

class IdleSchedulingState extends ISchedulingState {}

abstract class ISchedulingListener extends ISchedulingState {}

class SuccessSchedulingListener extends ISchedulingListener {}

class FailureSchedulingListener extends ISchedulingListener {}
