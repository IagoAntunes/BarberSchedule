import 'package:barberschedule_client/features/barbershops/domain/repositories/i_barbershops_repository.dart';
import 'package:barberschedule_client/features/barbershops/presentation/states/barbershops_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BarberShopsCubit extends Cubit<IBarberShopsState> {
  BarberShopsCubit({required IBarberShopsRepository barberShopsRepository})
      : _barberShopsRepository = barberShopsRepository,
        super(IdleBarberShopsState());

  final IBarberShopsRepository _barberShopsRepository;

  void getBarberShops() async {
    emit(LoadingBarberShopsState());
    var result = await _barberShopsRepository.getBarberShops();
    if (result != null) {
      emit(SuccessBarberShopsState(list: result));
    } else {
      emit(FailureBarberShopsState());
    }
  }
}
