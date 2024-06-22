abstract class ILoginState {}

abstract class ILoginListener extends ILoginState {}

class LoadingLoginListener extends ILoginListener {}

class SuccessLoginListener extends ILoginListener {}

class FailureLoginListener extends ILoginListener {}

class IdleLoginState extends ILoginState {}

class SuccessLoginState extends ILoginState {}

class FailureLoginState extends ILoginState {}

class LoadingLoginState extends ILoginState {}
