import 'package:dartz/dartz.dart';
import 'package:shoply_app/core/model/cart/cart.dart';
import 'package:shoply_app/core/model/products/request_products.dart';
import 'package:shoply_app/core/model/products/response_products.dart';
import 'package:shoply_app/core/usecase/cart/cart_usecase.dart';
import 'package:shoply_app/core/usecase/favorite/favorite_usecase.dart';

class FavoriteRepo {
  final _favouriteUsecase = FavoriteUsecase();
  final _cartUsecase = CartUsecase();

  Future<Either<String, bool>> addToFavorite({
    required RequestProducts requestProducts,
  }) async {
    return _favouriteUsecase.addToFavorite(
      requestProducts: requestProducts,
    );
  }

  Future<Either<String, bool>> addToCart({
    required Cart requestCart,
  }) async {
    return _cartUsecase.addToCart(requestCart: requestCart);
  }

  Future<Either<String, List<ResponseProducts>>> getFavourite() async {
    return _favouriteUsecase.getFavorite();
  }

  Future<Either<String, bool>> removeToFavourite({
    required String productId,
  }) async {
    return _favouriteUsecase.removeToFavorite(
      productId: productId,
    );
  }
}