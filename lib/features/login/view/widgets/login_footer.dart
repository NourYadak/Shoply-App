
part of '../login_screen.dart';

class _LoginFooter extends StatelessWidget {
  const _LoginFooter();

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);

    return Padding(
      padding: EdgeInsets.all(Responsive.width(isTablet ? 12 : 8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomButton(
            buttonText: 'Login',
            onPressed: () {
              context.read<LoginCubit>().login();
            },
          ),
          SizedBox(height: Responsive.height(isTablet ? 36 : 24)),
          Center(
            child: CustomTextButtonWrap(
              text: 'Don\'t have an account?',
              textClick: ' Sign Up',
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppPages.signupScreen,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
