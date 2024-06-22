import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../services/database/key/shared_preferences_service.dart';
import '../../domain/repositories/i_login_barbershop_repository.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<ILoginState> {
  final SharedPreferencesService _sharedPreferencesService;
  LoginCubit({
    required ILoginBarberShopRepository repository,
    required SharedPreferencesService sharedPreferencesService,
  })  : _repository = repository,
        _sharedPreferencesService = sharedPreferencesService,
        super(IdleLoginState());

  final ILoginBarberShopRepository _repository;

  void doLogin(String email, String password) async {
    emit(LoadingLoginState());
    emit(LoadingLoginListener());
    var result = await _repository.login(email, password);
    if (result.isSuccess) {
      _sharedPreferencesService.saveData('token', result.token);
      _sharedPreferencesService.saveData('userId', result.barberShop!.id);
      emit(SuccessLoginListener());
    } else {
      emit(IdleLoginState());
      emit(FailureLoginListener());
    }
  }
}
