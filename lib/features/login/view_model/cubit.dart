import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/features/login/view_model/state.dart';
import 'package:shoply_app/core/usecase/login/usecase_login.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  final LoginUsecase loginUsecase = LoginUsecase();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoadingState());

    final result = await loginUsecase.login(email: email, password: password);

    result.fold(
      (error) {
        emit(LoginErrorState(error));
      },
      (userData) {
        emit(LoginSuccessState());
      },
    );
  }
  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
