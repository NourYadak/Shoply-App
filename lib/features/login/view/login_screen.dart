import 'package:flutter/material.dart';
import 'package:shoply_app/core/routes/app_pages.dart';
import 'package:shoply_app/core/utils/images/app_images.dart';
import 'package:shoply_app/core/utils/theme/app_colors.dart';
import 'package:shoply_app/core/utils/widgets/button/custom_button.dart';
import 'package:shoply_app/core/utils/widgets/button/custom_text_button_wrap.dart';
import 'package:shoply_app/core/utils/widgets/loading/custom_loading.dart';
import 'package:shoply_app/core/utils/widgets/textField/custom_textfield.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/features/login/view_model/cubit.dart';
import 'package:shoply_app/features/login/view_model/state.dart';
part 'widgets/login_header.dart';
part 'widgets/login_body.dart';
part 'widgets/login_footer.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            Navigator.pushReplacementNamed(context, AppPages.onBoardingScreen);
          } else if (state is LoginErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is LoginLoadingState) {
            CustomLoading.showDialogLoading(context: context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        _LoginHeader(),
                        SizedBox(height: 30),
                        _LoginBody(),
                        SizedBox(height: 30),
                        _LoginFooter(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
