import 'package:flutter/material.dart';
import 'package:shoply_app/core/regex/app_regex.dart';
import 'package:shoply_app/core/routes/app_pages.dart';
import 'package:shoply_app/core/utils/theme/app_colors.dart';
import 'package:shoply_app/core/utils/widgets/appBar/app_bar.dart';
import 'package:shoply_app/core/utils/widgets/button/custom_button.dart';
import 'package:shoply_app/core/utils/widgets/button/custom_text_button.dart';
import 'package:shoply_app/core/utils/widgets/textField/custom_textfield.dart';
part 'widgets/forgot_pass_header.dart';
part 'widgets/forgot_pass_footer.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: ''),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Column(
                children: [
                  _ForgotPasswordHeader(),
                  SizedBox(height: 40),
                  _ForgotPasswordFooter(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
