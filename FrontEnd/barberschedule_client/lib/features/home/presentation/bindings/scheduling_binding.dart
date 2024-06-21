import 'package:barberschedule_client/features/home/presentation/blocs/scheduling_cubit.dart';
import 'package:get_it/get_it.dart';

class SchedulingBinding {
  static Future<void> setupAppBindings() async {
    final getIt = GetIt.I;
    getIt.registerSingleton<SchedulingCubit>(SchedulingCubit(
      scheduledTimeRepository: getIt(),
      sharedPreferences: getIt(),
    ));
  }
}
