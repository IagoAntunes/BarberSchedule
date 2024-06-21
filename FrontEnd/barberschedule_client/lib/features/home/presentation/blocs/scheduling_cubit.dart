import 'package:barberschedule_client/core/response/base_service_response.dart';
import 'package:barberschedule_client/features/home/domain/repositories/i_scheduled_time_repository.dart';
import 'package:barberschedule_client/features/home/presentation/states/scheduling_state.dart';
import 'package:barberschedule_client/services/database/key/shared_preferences_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SchedulingCubit extends Cubit<ISchedulingState> {
  SchedulingCubit(
      {required IScheduledTimeRepository scheduledTimeRepository,
      required SharedPreferencesService sharedPreferences})
      : _scheduledTimeRepository = scheduledTimeRepository,
        _sharedPreferencesService = sharedPreferences,
        super(IdleSchedulingState());

  final IScheduledTimeRepository _scheduledTimeRepository;
  final SharedPreferencesService _sharedPreferencesService;

  void scheduler(
    String barberShopId,
    double price,
    String selectedTime,
    DateTime datetime,
    String idPaymentMethod,
  ) async {
    emit(SuccessSchedulingListener());
    var userId = await _sharedPreferencesService.getData('userId');

    List<String> timeParts = selectedTime.split(':');
    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1]);

    DateTime scheduledTime = DateTime(
      datetime.year,
      datetime.month,
      datetime.day,
      hour,
      minute,
    );
    final result = await _scheduledTimeRepository.scheduleTime(
      userId,
      barberShopId,
      scheduledTime.toString(),
      idPaymentMethod,
      price,
      'waiting',
    );
    if (result is SuccessResponseData) {
      emit(SuccessSchedulingListener());
    } else {
      emit(FailureSchedulingListener());
    }
  }
}
