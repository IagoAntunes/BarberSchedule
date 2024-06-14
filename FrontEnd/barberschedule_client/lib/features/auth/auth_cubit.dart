import 'package:barberschedule_client/features/auth/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<IAuthState> {
  AuthCubit()
      : super(
          AuthState(
            isAuthenticated: TEste.hasToken(),
          ),
        );
}

class TEste {
  static bool hasToken() {
    Future.delayed(Duration(seconds: 3));
    return true;
  }
}
