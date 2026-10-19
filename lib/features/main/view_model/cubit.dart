import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/local/local_storage.dart';
import 'package:shoply_app/core/local/local_storage_user.dart';
import 'package:shoply_app/features/cart/view/cart_screen.dart';
import 'package:shoply_app/features/favorite/view/favorite_screen.dart';
import 'package:shoply_app/features/home/view/home_screen.dart';
import 'package:shoply_app/features/main/repo/main_repo.dart';
import 'package:shoply_app/features/main/view_model/state.dart';
import 'package:shoply_app/features/profile/view/profile_screen.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitState());
  final _mainRepo = MainRepo();
  int navBarIndex = 0;
  int cartCount = 0;

  List<Widget> page = [
    HomeScreen(),
    FavoriteScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  void changeNavBarIndex({required int index}) {
    navBarIndex = index;
    emit(MainChangeNavBarIndexState());
  }

  Future<void> getCartCount() async {
    final result = await _mainRepo.getCartCount();
    result.fold((_) {}, (cartCount) {
      this.cartCount = cartCount;
      emit(MainChangeCartCountState());
    });
  }

  Future<void> logout() async {
    LocalStorage.instance.setIsLogin(isLogin: false);
    LocalStorageUser.instance.clearUserData();
    await _mainRepo.logout();
  }

  void decrementCartCount() {
    cartCount--;
    emit(MainChangeCartCountState());
  }

  void removeCartCount() {
    cartCount = 0;
    emit(MainChangeCartCountState());
  }
}
