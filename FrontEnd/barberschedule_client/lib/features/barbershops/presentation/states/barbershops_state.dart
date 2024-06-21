import 'package:barberschedule_client/features/home/domain/models/barbershop_model.dart';

abstract class IBarberShopsState {}

class IdleBarberShopsState extends IBarberShopsState {}

class LoadingBarberShopsState extends IBarberShopsState {}

class SuccessBarberShopsState extends IBarberShopsState {
  List<BarberShopModel> list;
  SuccessBarberShopsState({
    required this.list,
  });
}

class FailureBarberShopsState extends IBarberShopsState {}
