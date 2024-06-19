abstract class IAuthState {
  bool isAuthenticated;
  final String? user;

  IAuthState({required this.isAuthenticated, this.user});
}

class AuthState extends IAuthState {
  AuthState({required super.isAuthenticated, super.user});
}
