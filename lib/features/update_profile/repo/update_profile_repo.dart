import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:shoply_app/core/model/update_profile/request_update_profile.dart';
import 'package:shoply_app/core/usecase/update_profile/update_profile_usecase.dart';

class UpdateProfileRepo {
  final _updateProfileUsecase = UpdateProfileUsecase();

  Future<Either<String, bool>> updateProfile({
    required RequestUpdateProfile requestUpdateProfile,
    required File? image,
  }) async {
    return await _updateProfileUsecase.updateProfile(
      requestUpdateProfile: requestUpdateProfile,
      image: image,
    );
  }
}
