import 'package:barberschedule_barbershop/src/features/auth/login/domain/models/payment_method_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/models/register_barbershop_model.dart';
import '../../domain/repositories/i_register_barbershop_repository.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<IRegisterState> {
  RegisterCubit({required IRegisterBarberShopRepository repository})
      : _repository = repository,
        super(IdleRegisterState());
  final IRegisterBarberShopRepository _repository;
  var barberShopModel = RegisterBarberShopModel.empty();

  List<PaymentMethodModel> listPaymentMethods = [];

  Future<void> registerBarberShop() async {
    emit(LoadingRegisterState());
    final result = await _repository.registerBarberShop(barberShopModel);
    if (result.isSuccess) {
      emit(SuccessRegisterState());
      emit(SuccessRegisterListener());
    } else {
      emit(FailureRegisterState());
    }
  }

  Future<void> getPaymentMethods() async {
    listPaymentMethods = await _repository.getPaymentMethods();
  }
}
