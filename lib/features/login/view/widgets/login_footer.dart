part of '../login_screen.dart';

class _LoginFooter extends StatelessWidget {
  const _LoginFooter();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomButton(buttonText: 'Login', onPressed: () {}),
        SizedBox(height: 50),
        CustomTextButtonWrap(
          text: 'Don\'t have an account?',
          textClick: ' Sign Up',
          onTap: () {
            Navigator.pushNamed(context, AppPages.signupScreen);
          },
        ),
      ],
    );
  }
}