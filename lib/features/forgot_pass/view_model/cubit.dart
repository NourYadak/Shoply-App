import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/features/forgot_pass/repo/forgotpass_repo.dart';
import 'package:shoply_app/features/forgot_pass/view_model/state.dart';

class ForgotPassCubit extends Cubit<ForgotPassState> {
  ForgotPassCubit() : super(ForgotPassInitialState());
  final _forgotPassRepo = ForgotPassRepo();
  final emailController = TextEditingController();
  final fromKey = GlobalKey<FormState>();

  Future<void> forgotPassword() async {
    emit(ForgotPassLoadingState());
    final result = await _forgotPassRepo.forgotPassword(
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
