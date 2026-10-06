import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/regex/app_regex.dart';
import 'package:shoply_app/core/routes/app_pages.dart';
import 'package:shoply_app/core/utils/images/app_images.dart';
import 'package:shoply_app/core/utils/theme/app_colors.dart';
import 'package:shoply_app/core/utils/widgets/appBar/app_bar.dart';
import 'package:shoply_app/core/utils/widgets/button/custom_button.dart';
import 'package:shoply_app/core/utils/widgets/dialog/custom_error.dart';
import 'package:shoply_app/core/utils/widgets/dialog/custom_success.dart';
import 'package:shoply_app/core/utils/widgets/loading/custom_loading.dart';
import 'package:shoply_app/core/utils/widgets/button/custom_text_button_wrap.dart';
import 'package:shoply_app/core/utils/widgets/textField/custom_textfield.dart';
import 'package:shoply_app/features/signup/view_model/cubit.dart';
import 'package:shoply_app/features/signup/view_model/state.dart';
part 'widgets/signup_header.dart';
part 'widgets/signup_name_textfield.dart';
part 'widgets/signup_email_textfield.dart';
part 'widgets/signup_pass_textfield.dart';
part 'widgets/signup_footer.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(),
      child: Scaffold(
        appBar: CustomAppBar(title: 'Create Account'),
        body: BlocListener<SignupCubit, SignupState>(
          listener: (context, state) {
            if (state is SignupLoadingState) {
              CustomLoading.showDialogLoading(context: context);
            } else if (state is SignupErrorState) {
              Navigator.pop(context);
              CustomDialogError.showProDialogError(
                context: context,
                title: 'Sign Up Error',
                description: state.errorMessage,
                onPressed: () {
                  Navigator.pop(context);
                },
              );
            } else if (state is SignupSuccessState) {
              Navigator.pop(context);
              CustomSuccessDialog.showProSuccessDialog(
                context: context,
                title: 'Sign Up Success',
                description: state.successMessage,
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppPages.loginScreen,
                    (route) => false,
                  );
                },
              );
            }
          },
          child: Builder(
            builder: (context) {
              final cubit = context.read<SignupCubit>();
              return SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Center(
                      child: Form(
                        key: cubit.formKey,
                        child: Column(
                          children: [
                            _SignupHeader(),
                            SizedBox(height: 10),
                            _SignupNameTextfield(),
                            SizedBox(height: 10),
                            _SignupEmailAddressTextfield(),
                            SizedBox(height: 10),
                            _SignupPassTextfield(),
                            SizedBox(height: 25),
                            _SignupFooter(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
