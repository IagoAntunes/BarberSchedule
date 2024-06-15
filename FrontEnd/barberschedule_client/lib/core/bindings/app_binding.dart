import 'package:barberschedule_client/features/auth/auth_cubit.dart';
import 'package:barberschedule_client/features/auth/login/domain/repositories/i_login_client_repository.dart';
import 'package:barberschedule_client/features/auth/login/external/datasources/login_client_datasource.dart';
import 'package:barberschedule_client/features/auth/login/infra/datasources/i_login_client_datasource.dart';
import 'package:barberschedule_client/features/auth/login/infra/repositories/login_client_repository.dart';
import 'package:barberschedule_client/features/auth/login/presentation/blocs/login_cubit.dart';
import 'package:barberschedule_client/features/auth/register/domain/repositories/i_register_client_repository.dart';
import 'package:barberschedule_client/features/auth/register/external/datasource/register_client_datasource.dart';
import 'package:barberschedule_client/features/auth/register/infra/datasource/i_register_client_datasource.dart';
import 'package:barberschedule_client/features/auth/register/infra/repositories/register_client_repository.dart';
import 'package:barberschedule_client/features/auth/register/presentation/blocs/register_client_cubit.dart';
import 'package:barberschedule_client/services/database/key/shared_preferences_service.dart';
import 'package:barberschedule_client/services/http/http_service.dart';
import 'package:barberschedule_client/services/http/i_http_service.dart';
import 'package:get_it/get_it.dart';

class AppBindings {
  static Future<void> setupAppBindings() async {
    final getIt = GetIt.I;
    getIt.registerSingleton<SharedPreferencesService>(
      SharedPreferencesService.instance,
    );
    getIt.registerSingleton<IHttpService>(HttpServiceImp());
    getIt.registerSingleton<AuthCubit>(AuthCubit(sharedPreferences: getIt()));
    _loginBindings(getIt);
    _registerBindings(getIt);
  }

  static Future<void> _registerBindings(GetIt getIt) async {
    getIt.registerFactory<IRegisterClientDataSource>(
      () => RegisterClientDataSource(httpService: getIt()),
    );
    getIt.registerFactory<IRegisterClientRepository>(
      () => RegisterClientRepository(dataSource: getIt()),
    );
    getIt.registerFactory<RegisterCubit>(
        () => RegisterCubit(repository: getIt()));
  }

  static Future<void> _loginBindings(GetIt getIt) async {
    getIt.registerFactory<ILoginClientDataSource>(
      () => LoginClientDataSource(httpService: getIt()),
    );
    getIt.registerFactory<ILoginClientRepository>(
      () => LoginClientRepository(dataSource: getIt()),
    );
    getIt.registerFactory<LoginCubit>(
      () => LoginCubit(
        repository: getIt(),
        sharedPreferences: getIt(),
      ),
    );
  }
}
