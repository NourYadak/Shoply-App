
part of '../signup_screen.dart';

class _SignupEmailAddressTextfield extends StatelessWidget {
  const _SignupEmailAddressTextfield();

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
            validator: (email) {
              if (email?.trim().isEmpty ?? true) {
                return 'Email is required';
              } else if (!AppRegex.emailRegex.hasMatch(email!.trim())) {
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

          SizedBox(height: Responsive.height(12)),

          CustomTextField(
            validator: (address) {
              if (address?.trim().isEmpty ?? true) {
                return 'Address is required';
              }
              return null;
            },
            controller: cubit.addressController,
            hinText: 'Address',
            prefixIcon: Icon(
              Icons.location_on_outlined,
              size: Responsive.width(isTablet ? 30 : 26),
              color: Colors.grey.shade800,
            ),
          ),
        ],
      ),
    );
  }
}
