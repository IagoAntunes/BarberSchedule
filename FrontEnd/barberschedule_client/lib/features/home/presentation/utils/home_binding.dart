import 'package:barberschedule_client/features/home/domain/repositories/i_scheduled_time_repository.dart';
import 'package:barberschedule_client/features/home/external/datasources/marking_history_datasource.dart';
import 'package:barberschedule_client/features/home/external/datasources/scheduled_time_datasource.dart';
import 'package:barberschedule_client/features/home/infra/datasources/i_marking_history_datasource.dart';
import 'package:barberschedule_client/features/home/infra/datasources/i_scheduled_time_datasource.dart';
import 'package:barberschedule_client/features/home/infra/repositories/marking_history_repository.dart';
import 'package:barberschedule_client/features/home/presentation/blocs/marking_history_cubit.dart';
import 'package:barberschedule_client/features/home/presentation/blocs/scheduled_time_cubit.dart';
import 'package:get_it/get_it.dart';

import '../../domain/repositories/i_marking_history_repository.dart';
import '../../infra/repositories/scheduled_time_repository.dart';

class HomeBindings {
  static Future<void> setupBindings() async {
    final getIt = GetIt.I;

    getIt.registerFactory<IScheduledTimeDataSource>(
        () => ScheduledTimeDataSource(httpService: getIt()));
    getIt.registerFactory<IScheduledTimeRepository>(
        () => ScheduledTimeRepository(scheduledTimeDataSource: getIt()));

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
