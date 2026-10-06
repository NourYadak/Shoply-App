part of '../login_screen.dart';

class _LoginFooter extends StatelessWidget {
  const _LoginFooter();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CustomButton(
            buttonText: 'Login',
            onPressed: () {
              context.read<LoginCubit>().login(
                email: context.read<LoginCubit>().emailController.text.trim(),
                password: context
                    .read<LoginCubit>()
                    .passwordController
                    .text
                    .trim(),
              );
            },
          ),
          SizedBox(height: 30),
          CustomTextButtonWrap(
            text: 'Don\'t have an account?',
            textClick: ' Sign Up',
            onTap: () {
              Navigator.pushNamed(context, AppPages.signupScreen);
            },
          ),
        ],
      ),
    );
  }
}
