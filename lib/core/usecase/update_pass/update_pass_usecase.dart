import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoply_app/core/helper/error_handle_helper.dart';
import 'package:shoply_app/core/model/update_pass/request_change_pass.dart';

class UpdatePassUsecase {
  Future<Either<String, bool>> updatePassword({
    required RequestChangePassword requestChangePassword,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null || user.email == null) {
        return const Left('User not logged in');
      }

      // 1. Re-authenticate user with current password
      final cred = EmailAuthProvider.credential(
        email: user.email!,
        password: requestChangePassword.currentPassword,
      );

      await user.reauthenticateWithCredential(cred);

      // 2. Update password to new password
      await user.updatePassword(requestChangePassword.newPassword);

      return const Right(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password' || e.code == 'invalid-credential') {
        return const Left('The Current Password is not correct.');
      }
      final error = ErrorHandleHelper.getCustomErrorMessage(e.code);
      return Left(error);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
