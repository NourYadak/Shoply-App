import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPassUsecase {
  Future<Either<String, bool>> forgotPassword({required String email}) async {
    try {
      final userQuery = await FirebaseFirestore.instance
          .collection('User')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (userQuery.docs.isEmpty) {
        return Left('User not found');
      }

      final actionCodeSettings = ActionCodeSettings(
        iOSBundleId: 'com.example.shoplyApp',
        androidPackageName: 'com.example.shoply_app',
        handleCodeInApp: true,
        url:
            'https://shoply-app-591a7.firebaseapp.com/__/auth/action?email=$email',
      );

      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,
        actionCodeSettings: actionCodeSettings,
      );

      return Right(true);
    } on FirebaseAuthException catch (e) {
      return Left(e.message ?? 'Failed to send password reset email');
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'Failed to check user data');
    }
  }
}
