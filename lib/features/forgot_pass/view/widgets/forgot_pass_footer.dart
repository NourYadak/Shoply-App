
part of '../forgot_pass_screen.dart';

class _ForgotPasswordFooter extends StatelessWidget {
  const _ForgotPasswordFooter();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgotPassCubit>();
    final isTablet = Responsive.isTablet(context);

    return Padding(
      padding: EdgeInsets.all(Responsive.width(isTablet ? 12 : 8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextField(
            validator: (email) {
              if (email?.isEmpty ?? false) {
                return 'Email is required';
              } else if (!AppRegex.emailRegex.hasMatch(email ?? '')) {
                return 'Email is not valid';
              }
              return null;
            },
            controller: cubit.emailController,
            hinText: 'Email',
            prefixIcon: Icon(
              Icons.email_outlined,
              size: Responsive.width(isTablet ? 30 : 26),
              color: Colors.grey.shade800,
            ),
          ),
          SizedBox(height: Responsive.height(isTablet ? 40 : 28)),
          CustomButton(
            buttonText: 'Send Reset Link',
            onPressed: () {
              cubit.forgotPassword();
            },
          ),
          SizedBox(height: Responsive.height(isTablet ? 32 : 24)),
          Center(
            child: CustomTextButton(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppPages.loginScreen,
                  (route) => false,
                );
              },
              textButton: 'Back to Login',
              style: TextStyle(
                fontSize: Responsive.font(isTablet ? 22 : 18),
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
