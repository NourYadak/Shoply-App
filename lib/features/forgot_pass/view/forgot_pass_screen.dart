import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/regex/app_regex.dart';
import 'package:shoply_app/core/routes/app_pages.dart';
import 'package:shoply_app/core/usecase/forgot_password/usecase_forgotPass.dart';
import 'package:shoply_app/core/utils/theme/app_colors.dart';
import 'package:shoply_app/core/utils/widgets/appBar/app_bar.dart';
import 'package:shoply_app/core/utils/widgets/button/custom_button.dart';
import 'package:shoply_app/core/utils/widgets/button/custom_text_button.dart';
import 'package:shoply_app/core/utils/widgets/dialog/custom_error.dart';
import 'package:shoply_app/core/utils/widgets/dialog/custom_success.dart';
import 'package:shoply_app/core/utils/widgets/loading/custom_loading.dart';
import 'package:shoply_app/core/utils/widgets/textField/custom_textfield.dart';
import 'package:shoply_app/features/forgot_pass/view_model/cubit.dart';
import 'package:shoply_app/features/forgot_pass/view_model/state.dart';
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
        body: BlocListener<ForgotPassCubit, ForgotPassState>(
          listener: (context, state) {
            if (state is ForgotPassLoadingState) {
              CustomLoading.showDialogLoading(context: context);
            } else if (state is ForgotPassErrorState) {
              Navigator.pop(context);
              CustomDialogError.showProDialogError(
                context: context,
                title: 'Error: Email is not sent',
                description: state.message,
                onPressed: () {
                  Navigator.pop(context);
                },
              );
            } else if (state is ForgotPassSuccessState) {
              Navigator.pop(context);
              CustomSuccessDialog.showProSuccessDialog(
                context: context,
                title: 'Reset Email Sent Successfully',
                description: state.message,
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
              context.read<ForgotPassCubit>();
              return SafeArea(
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
              );
            },
          ),
        ),
      ),
    );
  }
}
