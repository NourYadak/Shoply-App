import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/utils/images/app_images.dart';
import 'package:shoply_app/features/onboarding/view_model/state.dart';
import 'package:shoply_app/core/local/local_storage.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(OnBoardingInitState());

  final pageController = PageController();
  int index = 0;

  final onBoardingImage = [
    AppImages.onboardImage1,
    AppImages.onboardImage2,
    AppImages.onboardImage3,
  ];

  final onBoardingTitle = [
    'Discover Amazing Products',
    'Shop Your Style',
    'Fast & Safe Delivery',
  ];

  final onBoardingDescription = [
    'Find everything you need in one place.',
    'Top brands, great prices and the latest trends.',
    'Get your orders delivered right to your doorstep.',
  ];

  void nextPageController() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  void skipOnBoarding() {
    pageController.animateToPage(
      2,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  void changeIndex({required int newIndex}) {
    index = newIndex;
    emit(OnBoardingChangeIndexState());
  }

  void setShowOnBoarding() async {
    await LocalStorage.instance.setShowOnboard(isShowOnboard: true);
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
