import 'package:dartz/dartz.dart';
import 'package:shoply_app/core/usecase/forgot_password/usecase_forgotPass.dart';

class ForgotPassRepo {
  final _forgotPassUsecase = ForgotPasswordUsecase();

  Future<Either<String, String>> forgotPassword({required String email}) async {
    return await _forgotPassUsecase.forgotPassword(email: email);
  }
}
