import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/usecase/forgot_password/usecase_forgotPass.dart';
import 'package:shoply_app/features/forgot_pass/view_model/state.dart';

class ForgotPassCubit extends Cubit<ForgotPassState> {
  ForgotPassCubit(this._forgotPassUseCase) : super(ForgotPassInitialState());

  final ForgotPassUsecase _forgotPassUseCase;
  final emailController = TextEditingController();

  Future<void> forgotPassword() async {
    emit(ForgotPassLoadingState());
    final result = await _forgotPassUseCase.forgotPassword(
      email: emailController.text.trim(),
    );
    result.fold(
      (error) {
        emit(ForgotPassErrorState(error));
      },
      (_) {
        emit(ForgotPassSuccessState('Password reset email sent successfully.'));
      },
    );
  }

  @override
  Future<void> close() {
    emailController.dispose();
    return super.close();
  }
}
