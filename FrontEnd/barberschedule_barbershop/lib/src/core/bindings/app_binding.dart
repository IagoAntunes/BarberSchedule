import 'package:barberschedule_barbershop/src/features/auth/register/external/datasource/register_barbershop_datasource.dart';
import 'package:barberschedule_barbershop/src/features/auth/register/infra/datasource/i_register_barbershop_datasource.dart';
import 'package:barberschedule_barbershop/src/features/auth/register/infra/repositories/register_barbershop_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/auth_cubit.dart';
import '../../features/auth/login/domain/repositories/i_login_barbershop_repository.dart';
import '../../features/auth/login/external/datasources/login_barbershop_datasource.dart';
import '../../features/auth/login/infra/datasources/i_login_barbershop_datasource.dart';
import '../../features/auth/login/infra/repositories/login_barbershop_repository.dart';
import '../../features/auth/login/presentation/blocs/login_cubit.dart';
import '../../features/auth/register/domain/repositories/i_register_barbershop_repository.dart';

import '../../features/auth/register/presentation/blocs/register_barbershop_cubit.dart';
import '../../services/database/key/shared_preferences_service.dart';
import '../../services/http/http_service.dart';
import '../../services/http/i_http_service.dart';
import '../cubits/bottom_nav_cubit.dart';

class AppBindings {
  static Future<void> setupAppBindings() async {
    final getIt = GetIt.I;
    var prefs = await SharedPreferences.getInstance();
    getIt.registerSingleton<SharedPreferencesService>(
      SharedPreferencesService(preferences: prefs),
    );
    getIt.registerSingleton<IHttpService>(HttpServiceImp());
    getIt.registerSingleton<AuthCubit>(
        AuthCubit(sharedPreferencesService: getIt()));
    _loginBindings(getIt);
    _registerBindings(getIt);
  }

  static Future<void> _registerBindings(GetIt getIt) async {
    getIt.registerFactory<IRegisterBarberShopDataSource>(
      () => RegisterBarberShopDataSource(httpService: getIt()),
    );
    getIt.registerFactory<IRegisterBarberShopRepository>(
      () => RegisterBarberShopRepository(dataSource: getIt()),
    );
    getIt.registerFactory<RegisterCubit>(
        () => RegisterCubit(repository: getIt()));
  }

  static Future<void> _loginBindings(GetIt getIt) async {
    getIt.registerFactory<ILoginBarberShopDataSource>(
      () => LoginBarberShopDataSource(httpService: getIt()),
    );
    getIt.registerFactory<ILoginBarberShopRepository>(
      () => LoginBarberShopRepository(dataSource: getIt()),
    );
    getIt.registerFactory<LoginCubit>(
      () => LoginCubit(
        repository: getIt(),
        sharedPreferencesService: getIt(),
      ),
    );
    getIt.registerSingleton(BottomNavCubit());
  }
}
