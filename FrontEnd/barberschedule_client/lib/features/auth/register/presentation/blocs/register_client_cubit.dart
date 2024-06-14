import 'package:barberschedule_client/features/auth/register/domain/models/register_client_model.dart';
import 'package:barberschedule_client/features/auth/register/presentation/blocs/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/i_register_client_repository.dart';

class RegisterCubit extends Cubit<IRegisterState> {
  RegisterCubit({required IRegisterClientRepository repository})
      : _repository = repository,
        super(IdleRegisterState());
  final IRegisterClientRepository _repository;
  var registerClientModel = RegisterClientModel.empty();

  Future<void> registerClient() async {
    emit(LoadingRegisterState());
    final result = await _repository.registerClient(registerClientModel);
    if (result.isSuccess) {
      emit(SuccessRegisterState());
      emit(SuccessRegisterListener());
    } else {
      emit(FailureRegisterState());
    }
  }
}
