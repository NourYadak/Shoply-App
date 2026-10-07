import 'package:shoply_app/core/model/login/response_login.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final ResponseLogin userData;

  LoginSuccessState(this.userData);
}

class LoginErrorState extends LoginState {
  final String message;

  LoginErrorState(this.message);
}
