import 'package:barberschedule_client/features/home/domain/repositories/i_scheduled_time_repository.dart';
import 'package:barberschedule_client/features/home/external/datasources/scheduled_time_datasource.dart';
import 'package:barberschedule_client/features/home/infra/datasources/i_scheduled_time_datasource.dart';
import 'package:get_it/get_it.dart';

import '../../infra/repositories/scheduled_time_repository.dart';

class HomeBindings {
  static Future<void> setupBindings() async {
    final getIt = GetIt.I;

    getIt.registerFactory<IScheduledTimeDataSource>(
        () => ScheduledTimeDataSource(httpService: getIt()));
    getIt.registerFactory<IScheduledTimeRepository>(
        () => ScheduledTimeRepository(scheduledTimeDataSource: getIt()));
  }
}
