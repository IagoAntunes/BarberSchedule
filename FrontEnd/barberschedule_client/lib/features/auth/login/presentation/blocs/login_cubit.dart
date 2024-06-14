import 'package:barberschedule_client/features/auth/login/presentation/blocs/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<ILoginState> {
  LoginCubit() : super(IdleLoginState());

  void doLogin() async {
    emit(LoadingLoginState());
    emit(LoadingLoginListener());
    await Future.delayed(const Duration(seconds: 3));
    emit(IdleLoginState());
    emit(FailureLoginListener());
  }
}
