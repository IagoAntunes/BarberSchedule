import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/database/key/shared_preferences_service.dart';
import 'auth_state.dart';

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
