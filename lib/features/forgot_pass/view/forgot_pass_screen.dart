import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/regex/app_regex.dart';
import 'package:shoply_app/core/routes/app_pages.dart';
import 'package:shoply_app/core/usecase/forgot_password/usecase_forgotPass.dart';
import 'package:shoply_app/core/utils/theme/app_colors.dart';
import 'package:shoply_app/core/utils/widgets/appBar/app_bar.dart';
import 'package:shoply_app/core/utils/widgets/button/custom_button.dart';
import 'package:shoply_app/core/utils/widgets/button/custom_text_button.dart';
import 'package:shoply_app/core/utils/widgets/textField/custom_textfield.dart';
import 'package:shoply_app/features/forgot_pass/view_model/cubit.dart';
part 'widgets/forgot_pass_header.dart';
part 'widgets/forgot_pass_footer.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPassCubit(ForgotPassUsecase()),
      child: Scaffold(
        appBar: CustomAppBar(title: ''),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: Column(
                  children: [
                    _ForgotPasswordHeader(),
                    SizedBox(height: 30),
                    _ForgotPasswordFooter(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
