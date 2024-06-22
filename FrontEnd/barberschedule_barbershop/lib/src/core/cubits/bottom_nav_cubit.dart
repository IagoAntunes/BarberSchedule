import 'package:flutter_bloc/flutter_bloc.dart';

import '../states/bottom_nav_state.dart';

class BottomNavCubit extends Cubit<IBottomNavState> {
  BottomNavCubit() : super(IdleBottomNavState(currentIndex: 0));

  void changeIndex(int index) {
    emit(ChangeIndexBottomNavState(currentIndex: index));
  }
}
