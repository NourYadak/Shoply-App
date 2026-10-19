
part of '../signup_screen.dart';

class _SignupFooter extends StatelessWidget {
  const _SignupFooter();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignupCubit>();
    final isTablet = Responsive.isTablet(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.width(isTablet ? 12 : 8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomButton(
            buttonText: 'Sign Up',
            onPressed: () {
              cubit.signup();
            },
          ),

          SizedBox(
            height: Responsive.height(isTablet ? 28 : 20),
          ),

          Center(
            child: CustomTextButtonWrap(
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
          ),
        ],
      ),
    );
  }
}
