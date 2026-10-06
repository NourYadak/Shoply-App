part of '../forgot_pass_screen.dart';

class _ForgotPasswordFooter extends StatelessWidget {
  const _ForgotPasswordFooter();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          validator: (email) {
            if (email?.isEmpty ?? false) {
              return 'Email is required';
            } else if (AppRegex.emailRegex.hasMatch(email ?? '') == false) {
              return 'Email is not valid';
            }
            return null;
          },
          controller: TextEditingController(),
          hinText: 'Email',
          prefixIcon: Icon(
            Icons.email_outlined,
            size: 28,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 35),
        CustomButton(buttonText: 'Send Reset Link', onPressed: () {}),
        SizedBox(height: 30),
        CustomTextButton(
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppPages.loginScreen,
              (route) => false,
            );
          },
          textButton: 'Back to Login',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}