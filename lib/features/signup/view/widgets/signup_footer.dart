part of '../signup_screen.dart';

class _SignupFooter extends StatelessWidget {
  const _SignupFooter();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignupCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          CustomButton(
            buttonText: 'Sign Up',
            onPressed: () {
              cubit.signup();
            },
          ),
          SizedBox(height: 20),
          CustomTextButtonWrap(
            text: 'Already have an account?',
            textClick: ' Login',
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppPages.loginScreen,
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
