
part of '../signup_screen.dart';

class _SignupPassTextfield extends StatelessWidget {
  const _SignupPassTextfield();

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
          CustomTextField(
            validator: (password) {
              if (password?.isEmpty ?? true) {
                return 'Password is required';
              } else if (password!.length < 6) {
                return 'Password must be at least 6 characters';
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

          SizedBox(height: Responsive.height(12)),

          CustomTextField(
            validator: (confirmPassword) {
              if (confirmPassword?.isEmpty ?? true) {
                return 'Confirm Password is required';
              } else if (
                confirmPassword != cubit.passwordController.text
              ) {
                return 'Passwords do not match';
              }

              return null;
            },
            obscureText: true,
            controller: cubit.confirmPasswordController,
            hinText: 'Confirm Password',
            prefixIcon: Icon(
              Icons.lock_outline,
              size: Responsive.width(isTablet ? 30 : 26),
              color: Colors.grey.shade800,
            ),
          ),
        ],
      ),
    );
  }
}
