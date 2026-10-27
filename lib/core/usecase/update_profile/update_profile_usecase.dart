import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:shoply_app/core/model/update_profile/request_update_profile.dart';

class UpdateProfileUsecase {
  Future<Either<String, bool>> updateProfile({
    required RequestUpdateProfile requestUpdateProfile,
    required File? image,
  }) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Left('User not logged in');
    }

    String? imageUrl;

    // Step 1: Upload the new image, if selected.
    if (image != null) {
      try {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('users_images')
            .child('${user.uid}.jpg');

        debugPrint('STEP 1: Uploading profile image');
        debugPrint('Bucket: ${storageRef.bucket}');
        debugPrint('Path: ${storageRef.fullPath}');
        debugPrint('Local image exists: ${await image.exists()}');

        final snapshot = await storageRef.putFile(image);

        debugPrint('Upload state: ${snapshot.state}');

        imageUrl = await snapshot.ref.getDownloadURL();

        debugPrint('STEP 1 SUCCESS: Download URL obtained');
      } on FirebaseException catch (e) {
        debugPrint('STEP 1 FAILED: ${e.code} | ${e.message}');
        return Left(
          'Image upload failed (${e.code}): ${e.message ?? "Unknown error"}',
        );
      } catch (e) {
        debugPrint('STEP 1 FAILED: $e');
        return Left('Image upload failed: $e');
      }
    }

    // Step 2: Update the user's Firestore document.
    try {
      final updateData = <String, dynamic>{
        'fullName': requestUpdateProfile.fullName,
        'userName': requestUpdateProfile.userName,
        'address': requestUpdateProfile.address,
      };

      if (imageUrl != null) {
        updateData['image'] = imageUrl;
      }

      debugPrint('STEP 2: Updating Firestore user/${user.uid}');

      await FirebaseFirestore.instance
          .collection('User')
          .doc(user.uid)
          .update(updateData);

      debugPrint('STEP 2 SUCCESS: Profile updated');

      return const Right(true);
    } on FirebaseException catch (e) {
      debugPrint('STEP 2 FAILED: ${e.code} | ${e.message}');
      return Left(
        'Profile update failed (${e.code}): ${e.message ?? "Unknown error"}',
      );
    } catch (e) {
      debugPrint('STEP 2 FAILED: $e');
      return Left('Profile update failed: $e');
    }
  }
}
