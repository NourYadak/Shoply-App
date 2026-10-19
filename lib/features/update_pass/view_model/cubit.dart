// lib/features/update_pass_screen.dart/view_model/cubit.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/model/update_pass/request_change_pass.dart';
import 'package:shoply_app/features/update_pass/repo/update_pass_repo.dart';
import 'package:shoply_app/features/update_pass/view_model/state.dart';

class UpdatePassCubit extends Cubit<UpdatePassState> {
  UpdatePassCubit() : super(UpdatePassInitState());

  final _updatePassRepo = UpdatePassRepo();

  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isCurrentPasswordObscure = true;
  bool isNewPasswordObscure = true;
  bool isConfirmPasswordObscure = true;

  void toggleCurrentPasswordVisibility() {
    isCurrentPasswordObscure = !isCurrentPasswordObscure;
    emit(UpdatePassVisibilityToggledState());
  }

  void toggleNewPasswordVisibility() {
    isNewPasswordObscure = !isNewPasswordObscure;
    emit(UpdatePassVisibilityToggledState());
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordObscure = !isConfirmPasswordObscure;
    emit(UpdatePassVisibilityToggledState());
  }

  Future<void> updatePassword() async {
    if (formKey.currentState?.validate() ?? false) {
      if (newPasswordController.text != confirmPasswordController.text) {
        emit(UpdatePassErrorState(errorMessage: 'New passwords do not match'));
        return;
      }

      emit(UpdatePassLoadingState());

      final result = await _updatePassRepo.updatePassword(
        requestChangePassword: RequestChangePassword(
          currentPassword: currentPasswordController.text,
          newPassword: newPasswordController.text,
        ),
      );

      result.fold(
        (errorMessage) {
          emit(UpdatePassErrorState(errorMessage: errorMessage));
        },
        (success) {
          emit(UpdatePassSuccessState());
        },
      );
    }
  }

  @override
  Future<void> close() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
