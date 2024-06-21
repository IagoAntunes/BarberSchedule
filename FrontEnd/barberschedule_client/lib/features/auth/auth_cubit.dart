import 'package:barberschedule_client/features/auth/auth_state.dart';
import 'package:barberschedule_client/services/database/key/shared_preferences_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<IAuthState> {
  final SharedPreferencesService _sharedPreferencesService;
  AuthCubit({required SharedPreferencesService sharedPreferencesService})
      : _sharedPreferencesService = sharedPreferencesService,
        super(
          AuthState(
            isAuthenticated: false,
          ),
        );

  void logout() {
    _sharedPreferencesService.setString('token', '');
    emit(AuthState(isAuthenticated: false));
  }

  void login() {
    emit(AuthState(isAuthenticated: true));
  }
}
