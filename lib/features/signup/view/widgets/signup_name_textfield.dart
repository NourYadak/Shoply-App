
part of '../signup_screen.dart';

class _SignupNameTextfield extends StatelessWidget {
  const _SignupNameTextfield();

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
            validator: (fullName) {
              if (fullName?.trim().isEmpty ?? true) {
                return 'Full Name is required';
              }
              return null;
            },
            controller: cubit.fullNameController,
            hinText: 'Full Name',
            prefixIcon: Icon(
              Icons.person_outlined,
              size: Responsive.width(isTablet ? 30 : 26),
              color: Colors.grey.shade800,
            ),
          ),

          SizedBox(height: Responsive.height(12)),

          CustomTextField(
            validator: (userName) {
              if (userName?.trim().isEmpty ?? true) {
                return 'Username is required';
              }
              return null;
            },
            controller: cubit.userNameController,
            hinText: 'Username',
            prefixIcon: Icon(
              Icons.person_outlined,
              size: Responsive.width(isTablet ? 30 : 26),
              color: Colors.grey.shade800,
            ),
          ),
        ],
      ),
    );
  }
}
