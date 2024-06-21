abstract class IBottomNavState {
  int currentIndex;
  IBottomNavState({
    required this.currentIndex,
  });
}

class IdleBottomNavState extends IBottomNavState {
  IdleBottomNavState({required super.currentIndex});
}

class ChangeIndexBottomNavState extends IBottomNavState {
  ChangeIndexBottomNavState({required super.currentIndex});
}
