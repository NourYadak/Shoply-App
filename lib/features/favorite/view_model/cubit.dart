
import 'package:shoply_app/features/favorite/view_model/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitState());

  final Set<String> favoriteProducts = {};

  void changeFavouirte(String productId) {
    if (favoriteProducts.contains(productId)) {
      favoriteProducts.remove(productId);
    } else {
      favoriteProducts.add(productId);
    }

    emit(ProductChangeFavoriteState());
  }

  bool isFavorite(String productId) {
    return favoriteProducts.contains(productId);
  }
}
