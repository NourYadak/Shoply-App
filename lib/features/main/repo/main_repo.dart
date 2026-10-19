import 'package:dartz/dartz.dart';
import 'package:shoply_app/core/usecase/cart/cart_usecase.dart';
import 'package:shoply_app/core/usecase/logout/logout_usecase.dart';

class MainRepo {
  final _cartUsecase = CartUsecase();
  final _logoutUsecase = LogoutUsecase();

  Future<Either<String, bool>> logout() async {
    return _logoutUsecase.logout();
  }

  Future<Either<String, int>> getCartCount() async {
    return _cartUsecase.getCartCount();
  }
}