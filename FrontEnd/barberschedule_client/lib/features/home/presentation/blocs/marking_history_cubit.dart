import 'package:barberschedule_client/features/home/domain/repositories/i_marking_history_repository.dart';
import 'package:barberschedule_client/features/home/presentation/states/marking_history_state.dart';
import 'package:barberschedule_client/services/database/key/shared_preferences_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MarkingHistoryCubit extends Cubit<IMarkingHistoryState> {
  MarkingHistoryCubit(
      {required IMarkingHistoryRepository repository,
      required SharedPreferencesService sharedPreferencesService})
      : _markingHistoryRepository = repository,
        _sharedPreferencesService = sharedPreferencesService,
        super(IdleMarkingHistoryState());
  final SharedPreferencesService _sharedPreferencesService;
  final IMarkingHistoryRepository _markingHistoryRepository;

  Future<void> getMarkingHistory() async {
    emit(LoadingMarkingHistoryState());
    await Future.delayed(const Duration(seconds: 3));
    var userId = _sharedPreferencesService.getString('userId');
    final result = await _markingHistoryRepository.getMarkingHistory(userId!);
    if (result != null) {
      emit(SuccessMarkingHistoryState(result));
    } else {
      emit(FailureMarkingHistoryState("Erro"));
    }
  }
}
