import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/model/cart/cart.dart';
import 'package:shoply_app/core/model/products/request_products.dart';
import 'package:shoply_app/core/model/products/response_products.dart';
import 'package:shoply_app/features/favorite/repo/favorite_repo.dart';
import 'package:shoply_app/features/favorite/view_model/state.dart';
import 'package:shoply_app/features/main/view_model/cubit.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitState());

  final _favouriteRepo = FavoriteRepo();

  final List<ResponseProducts> responseProducts = [];
  final Set<String> favoriteProductIds = {};

  bool isFavorite(String? productId) {
    if (productId == null) return false;
    return favoriteProductIds.contains(productId);
  }

  Future<void> refreshFavourite() async {
    responseProducts.clear();
    favoriteProductIds.clear();
    await getFavourite();
  }

  Future<void> getFavourite() async {
    emit(FavoriteLoadingState());

    final result = await _favouriteRepo.getFavourite();

    result.fold(
      (errorMessage) {
        emit(FavoriteErrorState(errorMessage: errorMessage));
      },
      (products) {
        responseProducts
          ..clear()
          ..addAll(products);

        favoriteProductIds
          ..clear()
          ..addAll(
            products
                .map((product) => product.id)
                .whereType<String>(),
          );

        emit(FavoriteSucessState());
      },
    );
  }

  Future<void> toggleFavorite({
    required RequestProducts requestProducts,
  }) async {
    final productId = requestProducts.id;

    if (productId == null || productId.isEmpty) {
      emit(
        FavoriteActionErrorState(
          errorMessage: 'Product ID is missing.',
        ),
      );
      return;
    }

    final wasFavorite = favoriteProductIds.contains(productId);

    emit(FavoriteActionLoadingState());

    final result = wasFavorite
        ? await _favouriteRepo.removeToFavourite(
            productId: productId,
          )
        : await _favouriteRepo.addToFavorite(
            requestProducts: requestProducts,
          );

    result.fold(
      (errorMessage) {
        emit(
          FavoriteActionErrorState(
            errorMessage: errorMessage,
          ),
        );
      },
      (_) {
        if (wasFavorite) {
          favoriteProductIds.remove(productId);
          responseProducts.removeWhere(
            (product) => product.id == productId,
          );
        } else {
          favoriteProductIds.add(productId);
        }

        emit(FavoriteActionSuccessState());
      },
    );
  }

  void removeProductFromFav({
    required String productId,
    required BuildContext context,
  }) {
    responseProducts.removeWhere(
      (product) => product.id == productId,
    );

    favoriteProductIds.remove(productId);

    context.read<MainCubit>().decrementFavouriteCount();

    _removeToFavourite(productId: productId);

    emit(FavoriteRemoveSucessState());
  }

  Future<void> _removeToFavourite({
    required String productId,
  }) async {
    await _favouriteRepo.removeToFavourite(
      productId: productId,
    );
  }

  Future<void> addToCart({
    required Cart requestCart,
    required BuildContext context,
  }) async {
    emit(FavoriteAddToCartLoadingState());

    final result = await _favouriteRepo.addToCart(
      requestCart: requestCart,
    );

    result.fold(
      (errorMessage) {
        emit(
          FavoriteAddToCartErrorState(
            errorMessage: errorMessage,
          ),
        );
      },
      (_) {
        context.read<MainCubit>().getCartCount();
        emit(FavoriteAddToCartSuccessState());
      },
    );
  }
}