import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:shoply_app/core/local/local_storage_user.dart';
import 'package:shoply_app/core/model/login/response_login.dart';
import 'package:shoply_app/core/model/update_profile/request_update_profile.dart';
import 'package:shoply_app/core/service/upload_image_service.dart';

class UpdateProfileUsecase {
  Future<String?> _uploadImage({required File? image}) async {
    if (image != null) {
      final imageUrl = await UploadImageService.uplaodImage(imageFile: image);
      return imageUrl;
    } else {
      return null;
    }
  }

  Future<Either<String, bool>> updateProfile({
    required RequestUpdateProfile requestUpdateProfile,
    required File? image,
  }) async {
    try {
      final imageURL = await _uploadImage(image: image);
      await FirebaseFirestore.instance
          .collection('User')
          .doc(LocalStorageUser.instance.uid)
          .update({
            'address': requestUpdateProfile.address,
            'email': requestUpdateProfile.email,
            'fullName': requestUpdateProfile.fullName,
            'profileImage': imageURL,
            'userName': requestUpdateProfile.userName,
          });
      await LocalStorageUser.instance.setUserData(
        responseLogin: ResponseLogin(
          email: requestUpdateProfile.email,
          fullName: requestUpdateProfile.fullName,
          userName: requestUpdateProfile.userName,
          address: requestUpdateProfile.address,
          uid: LocalStorageUser.instance.uid,
          profileImage: imageURL,
        ),
      );
      LocalStorageUser.instance.setUserinfo(
        responseLogin: ResponseLogin(
          email: requestUpdateProfile.email,
          fullName: requestUpdateProfile.fullName,
          userName: requestUpdateProfile.userName,
          address: requestUpdateProfile.address,
          uid: LocalStorageUser.instance.uid,
          profileImage: imageURL,
        ),
      );
      return right(true);
    } on FirebaseAuthException catch (e) {
      return left(e.message ?? '');
    }
  }
}
