import 'package:barberschedule_client/features/auth/login/domain/repositories/i_login_client_repository.dart';
import 'package:barberschedule_client/features/auth/login/presentation/blocs/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<ILoginState> {
  LoginCubit({required ILoginClientRepository repository})
      : _repository = repository,
        super(IdleLoginState());

  final ILoginClientRepository _repository;

  void doLogin(String email, String password) async {
    emit(LoadingLoginState());
    emit(LoadingLoginListener());
    var result = await _repository.login(email, password);
    if (result.isSuccess) {
      emit(SuccessLoginListener());
    } else {
      emit(IdleLoginState());
      emit(FailureLoginListener());
    }
  }
}
