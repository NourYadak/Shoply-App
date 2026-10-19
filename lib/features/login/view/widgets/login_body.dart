part of '../login_screen.dart';

class _LoginBody extends StatelessWidget {
  const _LoginBody();

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);
    final cubit = context.read<LoginCubit>();

    return Padding(
      padding: EdgeInsets.all(Responsive.width(isTablet ? 12 : 8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextField(
            validator: (email) {
              if (email?.isEmpty ?? false) {
                return 'Email is required';
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
          SizedBox(height: Responsive.height(12)),
          CustomTextField(
            validator: (password) {
              if (password?.isEmpty ?? false) {
                return 'Password is required';
              }
              return null;
            },
            obscureText: true,
            controller: cubit.passwordController,
            hinText: 'Password',
            prefixIcon: Icon(
              Icons.lock_outline,
              size: Responsive.width(isTablet ? 30 : 26),
              color: Colors.grey.shade800,
            ),
          ),
          SizedBox(height: Responsive.height(8)),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppPages.forgotPasswordScreen);
            },
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Forgot Password?',
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: Responsive.font(isTablet ? 19 : 16),
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
