import 'package:barberschedule_client/features/home/domain/repositories/i_scheduled_time_repository.dart';
import 'package:barberschedule_client/features/home/presentation/states/home_states.dart';
import 'package:barberschedule_client/services/database/key/shared_preferences_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduledTimeCubit extends Cubit<IScheduledTimeState> {
  ScheduledTimeCubit(
      {required IScheduledTimeRepository repository,
      required SharedPreferencesService sharedPreferencesService})
      : _scheduledTimeRepository = repository,
        _sharedPreferencesService = sharedPreferencesService,
        super(IdleScheduledTimeState());

  final IScheduledTimeRepository _scheduledTimeRepository;
  final SharedPreferencesService _sharedPreferencesService;
  void getNextOrder() async {
    emit(LoadingScheduledTimeState());
    var userId = _sharedPreferencesService.getString('userId');
    final result = await _scheduledTimeRepository.getNextOrder(userId!);
    if (result != null) {
      emit(SuccessScheduledTimeState(order: result));
    } else {
      emit(FailureScheduledTimeState());
    }
  }
}
