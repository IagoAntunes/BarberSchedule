import 'package:barberschedule_client/features/barbershops/domain/repositories/i_barbershops_repository.dart';
import 'package:barberschedule_client/features/barbershops/external/datasource/barbershops_datasource.dart';
import 'package:barberschedule_client/features/barbershops/intra/datasource/i_barbershops_datasource.dart';
import 'package:barberschedule_client/features/barbershops/intra/repositories/barbershops_repository.dart';
import 'package:barberschedule_client/features/barbershops/presentation/blocs/barbershops_cubit.dart';
import 'package:get_it/get_it.dart';

class BarberShopsBindings {
  static Future<void> setupBindings() async {
    final getIt = GetIt.I;
    getIt.registerFactory<IBarberShopsDataSource>(
        () => BarbershopsDataSource(httpService: getIt()));
    getIt.registerFactory<IBarberShopsRepository>(
        () => BarberShopsRepository(barberShopsDataSource: getIt()));

    getIt.registerSingleton(BarberShopsCubit(barberShopsRepository: getIt()));
  }
}
