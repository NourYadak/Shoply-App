import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoply_app/core/model/login/response_login.dart';

class LoginUsecase {
  Future<Either<String, ResponseLogin>> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;

      if (user == null) {
        return Left("User not found");
      }

      if (!user.emailVerified) {
        await FirebaseAuth.instance.signOut();
        return Left(
          "Email not verified. Please verify your email before logging in.",
        );
      }

      final uid = user.uid;
      final userDoc = await FirebaseFirestore.instance
          .collection('User')
          .doc(uid)
          .get();

      if (!userDoc.exists) {
        return Left("User data not found");
      }

      final userData = ResponseLogin.fromJson(userDoc.data()!);

      return Right(userData);
    } on FirebaseAuthException catch (e) {
      return Left(e.message ?? 'Login failed');
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'Failed to get user data');
    }
  }
}
