import 'package:barberschedule_client/features/auth/auth_state.dart';
import 'package:barberschedule_client/services/database/key/shared_preferences_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<IAuthState> {
  final SharedPreferencesService _sharedPreferences;
  AuthCubit({required SharedPreferencesService sharedPreferences})
      : _sharedPreferences = sharedPreferences,
        super(
          AuthState(
            isAuthenticated: false,
          ),
        );

  void logout() {
    _sharedPreferences.setString('token', '');
    emit(AuthState(isAuthenticated: false));
  }

  void login() {
    emit(AuthState(isAuthenticated: true));
  }
}
