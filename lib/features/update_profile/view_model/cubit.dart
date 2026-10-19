import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/helper/image_picker_helper.dart';
import 'package:shoply_app/core/model/update_profile/request_update_profile.dart';
import 'package:shoply_app/features/update_profile/repo/update_profile_repo.dart';
import 'package:shoply_app/features/update_profile/view_model/state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit() : super(UpdateProfileInitState());
  final _updateProfileRepo = UpdateProfileRepo();

  final fullNameController = TextEditingController();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  File? image;

  void pickImage() async {
    final imageFile = await ImagePickerHelper.pickImageGallery();
    if (imageFile != null) {
      image = File(imageFile.path);
      emit(UpdateProfilePickImageState());
    }
  }

  void deleteImage() {
    image = null;
    emit(UpdateProfileRemoveImageState());
  }

  Future<void> updateProfile() async {
    if (formKey.currentState?.validate() ?? false) {
      emit(UpdateProfileLoadingState());

      final result = await _updateProfileRepo.updateProfile(
        image: image,
        requestUpdateProfile: RequestUpdateProfile(
          email: emailController.text,
          fullName: fullNameController.text,
          userName: userNameController.text,
          address: addressController.text,
        ),
      );

      result.fold(
        (errorMessage) {
          emit(UpdateProfileErrorState(errorMessage: errorMessage));
        },
        (_) {
          emit(
            UpdateProfileSuccessState(
              successMessage: 'Profile Updated Successfully',
            ),
          );
        },
      );
    }
  }

  @override
  Future<void> close() {
    fullNameController.dispose();
    userNameController.dispose();
    emailController.dispose();
    addressController.dispose();
    return super.close();
  }
}
