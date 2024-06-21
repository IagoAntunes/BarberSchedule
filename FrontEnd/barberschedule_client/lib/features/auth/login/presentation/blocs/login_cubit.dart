import 'package:barberschedule_client/features/auth/login/domain/repositories/i_login_client_repository.dart';
import 'package:barberschedule_client/features/auth/login/presentation/blocs/login_state.dart';
import 'package:barberschedule_client/services/database/key/shared_preferences_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<ILoginState> {
  final SharedPreferencesService _sharedPreferencesService;
  LoginCubit({
    required ILoginClientRepository repository,
    required SharedPreferencesService sharedPreferencesService,
  })  : _repository = repository,
        _sharedPreferencesService = sharedPreferencesService,
        super(IdleLoginState());

  final ILoginClientRepository _repository;

  void doLogin(String email, String password) async {
    emit(LoadingLoginState());
    emit(LoadingLoginListener());
    var result = await _repository.login(email, password);
    if (result.isSuccess) {
      _sharedPreferencesService.saveData('token', result.token);
      _sharedPreferencesService.saveData('userId', result.user!.id);
      emit(SuccessLoginListener());
    } else {
      emit(IdleLoginState());
      emit(FailureLoginListener());
    }
  }
}
