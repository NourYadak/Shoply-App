import 'package:dartz/dartz.dart';
import 'package:shoply_app/core/model/cart/cart.dart';
import 'package:shoply_app/core/model/products/request_products.dart';
import 'package:shoply_app/core/usecase/cart/cart_usecase.dart';
import 'package:shoply_app/core/usecase/favorite/favorite_usecase.dart';

class ProductDetailsRepo {
  final _cartUsecase = CartUsecase();
  final _favouriteUsecase = FavoriteUsecase();

  Future<Either<String, bool>> addToCart({required Cart requestCart}) async {
    return await _cartUsecase.addToCart(requestCart: requestCart);
  }

  Future<Either<String, bool>> addToFavourite({
    required RequestProducts requestProducts,
  }) async {
    return await _favouriteUsecase.addToFavorite(
      requestProducts: requestProducts,
    );
  }

  Future<Either<String, bool>> removeToFavourite({
    required String productId,
  }) async {
    return await _favouriteUsecase.removeToFavorite(productId: productId);
  }

  Future<Either<String, bool>> checkIfProductInFavourite({
    required String productId,
  }) async {
    return await _favouriteUsecase.checkIfProductInFavorite(
      productId: productId,
    );
  }
}
