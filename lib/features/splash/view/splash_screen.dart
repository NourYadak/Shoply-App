import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/routes/app_pages.dart';
import 'package:shoply_app/core/utils/images/app_images.dart';
import 'package:shoply_app/core/utils/widgets/responsive/responsive.dart';
import 'package:shoply_app/features/splash/view_model/cubit.dart';
import 'package:shoply_app/features/splash/view_model/state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);

    return BlocProvider(
      create: (context) => SplashCubit()..goNextPage(),
      child: Scaffold(
        body: BlocListener<SplashCubit, SplashState>(
          listener: (context, state) {
            if (state is SplashOnBoardPageState) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppPages.onBoardingScreen,
                (route) => false,
              );
            } else if (state is SplashLoginPageState) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppPages.loginScreen,
                (route) => false,
              );
            }
          },
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Responsive.width(24)),
              child: Image(
                image: AssetImage(AppImages.shoplySplashImage),
                width: Responsive.width(isTablet ? 400 : 300),
                height: Responsive.height(isTablet ? 400 : 300),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
