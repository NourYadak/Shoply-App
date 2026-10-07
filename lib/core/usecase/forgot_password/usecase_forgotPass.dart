import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordUsecase {
  Future<Either<String, String>> forgotPassword({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      return Right('Password reset link has been sent to your email.');
    } on FirebaseAuthException catch (e) {
      return Left(e.message ?? 'Failed to send password reset email.');
    } catch (e) {
      return Left('Something went wrong. Please try again.');
    }
  }
}
