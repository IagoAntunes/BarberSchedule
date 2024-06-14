abstract class IRegisterState {}

abstract class IRegisterListener extends IRegisterState {}

class LoadingRegisterListener extends IRegisterListener {}

class SuccessRegisterListener extends IRegisterListener {}

class IdleRegisterState extends IRegisterState {}

class LoadingRegisterState extends IRegisterState {}

class FailureRegisterState extends IRegisterState {}

class SuccessRegisterState extends IRegisterState {}
