// lib/features/update_pass_screen.dart/repo/update_pass_repo.dart

import 'package:dartz/dartz.dart';
import 'package:shoply_app/core/model/update_pass/request_change_pass.dart';
import 'package:shoply_app/core/usecase/update_pass/update_pass_usecase.dart';

class UpdatePassRepo {
  final _updatePassUsecase = UpdatePassUsecase();

  Future<Either<String, bool>> updatePassword({
    required RequestChangePassword requestChangePassword,
  }) async {
    return await _updatePassUsecase.updatePassword(
      requestChangePassword: requestChangePassword,
    );
  }
}
