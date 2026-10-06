part of '../login_screen.dart';

class _LoginBody extends StatelessWidget {
  const _LoginBody();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CustomTextField(
            validator: (email) {
              if (email?.isEmpty ?? false) {
                return 'Email is required';
              }
              return null;
            },
            controller: context.read<LoginCubit>().emailController,
            hinText: 'Email',
            prefixIcon: Icon(
              Icons.email_outlined,
              size: 28,
              color: Colors.grey.shade800,
            ),
          ),
          SizedBox(height: 5),
          CustomTextField(
            validator: (password) {
              if (password?.isEmpty ?? false) {
                return 'Password is required';
              }
              return null;
            },
            obscureText: true,
            controller: context.read<LoginCubit>().passwordController,
            hinText: 'Password',
            prefixIcon: Icon(
              Icons.lock_outline,
              size: 28,
              color: Colors.grey.shade800,
            ),
          ),
          SizedBox(height: 5),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppPages.forgotPasswordScreen);
            },
            child: Align(
              alignment: AlignmentGeometry.centerRight,
              child: Text(
                'ForgotPassword?',
                style: TextStyle(
                  fontSize: 18,
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
