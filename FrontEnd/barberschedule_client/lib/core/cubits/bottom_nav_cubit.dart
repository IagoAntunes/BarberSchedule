import 'package:barberschedule_client/core/states/bottom_nav_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavCubit extends Cubit<IBottomNavState> {
  BottomNavCubit() : super(IdleBottomNavState(currentIndex: 0));

  void changeIndex(int index) {
    emit(ChangeIndexBottomNavState(currentIndex: index));
  }
}
