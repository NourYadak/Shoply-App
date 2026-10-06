import 'package:dartz/dartz.dart';
import 'package:shoply_app/core/model/signup/request_signup.dart';
import 'package:shoply_app/core/usecase/signup/usecase_signup.dart';

class SignupRepo {
  final _signupUsecase = SignupUsecase();

  Future<Either<String, bool>> signup({
    required String password,
    required RequestSignup requestSingup,
  }) async {
    return await _signupUsecase.signup(
      password: password,
      requestSignup: requestSingup,
    );
  }
}