import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shoply_app/core/model/signup/request_signup.dart';
import 'package:shoply_app/core/model/update_profile/request_update_profile.dart'; // يمكنك استخدام نفس الـ Request أو إنشاء واحد جديد

class UpdateProfileUsecase {
  Future<Either<String, bool>> updateProfile({
    required RequestUpdateProfile requestUpdateProfile,
    required File? image,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return const Left('User not logged in');
      }

      String imageUrl = '';

      // رفع الصورة الجديدة إن وجدت إلى Firebase Storage
      if (image != null) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('users_images')
            .child('${user.uid}.jpg');

        await storageRef.putFile(image);
        imageUrl = await storageRef.getDownloadURL();
      }

      // تجهيز البيانات للتحديث في Firestore
      final Map<String, dynamic> updateData = {
        'fullName': requestUpdateProfile.fullName,
        'userName': requestUpdateProfile.userName,
        'address': requestUpdateProfile.address,
      };

      if (imageUrl.isNotEmpty) {
        updateData['image'] = imageUrl; // تأكد من اسم الحقل حسب قاعدتك
      }

      await FirebaseFirestore.instance
          .collection('User')
          .doc(user.uid)
          .update(updateData);

      return const Right(true);
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'An error occurred');
    } catch (e) {
      return Left(e.toString());
    }
  }
}
