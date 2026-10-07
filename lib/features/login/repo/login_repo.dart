import 'package:dartz/dartz.dart';
import 'package:shoply_app/core/model/login/response_login.dart';
import 'package:shoply_app/core/usecase/login/usecase_login.dart';

class LoginRepo {
  final _loginUsecase = LoginUsecase();

  Future<Either<String, ResponseLogin>> login({
    required String password,
    required String email,
  }) async {
    return await _loginUsecase.login(password: password, email: email);
  }
}
