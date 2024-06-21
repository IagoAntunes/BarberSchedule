import 'package:get_it/get_it.dart';

import '../../../home/presentation/blocs/scheduled_time_cubit.dart';
import '../../domain/repositories/i_marking_history_repository.dart';
import '../../external/datasources/marking_history_datasource.dart';
import '../../infra/datasources/i_marking_history_datasource.dart';
import '../../infra/repositories/marking_history_repository.dart';
import '../blocs/marking_history_cubit.dart';

class MarkingHistoryBinding {
  static Future<void> setupBindings() async {
    final getIt = GetIt.I;

    getIt.registerFactory<IMarkingHistoryDataSource>(
        () => MarkingHistoryDataSource(httpService: getIt()));
    getIt.registerFactory<IMarkingHistoryRepository>(
        () => MarkingHistoryRepository(dataSource: getIt()));

    getIt.registerSingleton<ScheduledTimeCubit>(
      ScheduledTimeCubit(
        repository: getIt(),
        sharedPreferencesService: getIt(),
      ),
    );
    getIt.registerSingleton<MarkingHistoryCubit>(
      MarkingHistoryCubit(
        repository: getIt(),
        sharedPreferencesService: getIt(),
      ),
    );
  }
}
