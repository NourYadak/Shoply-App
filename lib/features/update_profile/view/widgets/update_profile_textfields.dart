
part of '../update_profile_screen.dart';

class _UpdateProfileTextfields extends StatelessWidget {
  const _UpdateProfileTextfields();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UpdateProfileCubit>();
    final isTablet = Responsive.isTablet(context);

    final labelStyle = TextStyle(
      fontSize: Responsive.font(13),
      fontWeight: FontWeight.w600,
      color: const Color(0xFF424750),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Container(
              width: Responsive.width(4),
              height: Responsive.height(23),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            SizedBox(width: Responsive.width(10)),
            Text(
              'Account Details',
              style: TextStyle(
                fontSize: Responsive.font(isTablet ? 18 : 16),
                fontWeight: FontWeight.w700,
                color: const Color(0xFF202124),
              ),
            ),
          ],
        ),
        SizedBox(height: Responsive.height(22)),

        Text('Full Name', style: labelStyle),
        SizedBox(height: Responsive.height(8)),
        CustomTextField(
          controller: cubit.fullNameController,
          hinText: 'Enter your full name',
          validator: (value) =>
              value?.trim().isEmpty ?? true
                  ? 'Full Name is required'
                  : null,
          prefixIcon: Icon(
            Icons.person_outline,
            color: Colors.grey.shade600,
          ),
        ),

        SizedBox(height: Responsive.height(18)),

        Text('Username', style: labelStyle),
        SizedBox(height: Responsive.height(8)),
        CustomTextField(
          controller: cubit.userNameController,
          hinText: 'Enter your username',
          validator: (value) =>
              value?.trim().isEmpty ?? true
                  ? 'Username is required'
                  : null,
          prefixIcon: Icon(
            Icons.alternate_email,
            color: Colors.grey.shade600,
          ),
        ),

        SizedBox(height: Responsive.height(18)),

        Text('Email Address', style: labelStyle),
        SizedBox(height: Responsive.height(8)),
        CustomTextField(
          controller: cubit.emailController,
          hinText: 'name@example.com',
          validator: (value) {
            if (value?.trim().isEmpty ?? true) {
              return 'Email is required';
            }
            if (!AppRegex.emailRegex.hasMatch(value!.trim())) {
              return 'Invalid email';
            }
            return null;
          },
          prefixIcon: Icon(
            Icons.email_outlined,
            color: Colors.grey.shade600,
          ),
        ),

        SizedBox(height: Responsive.height(18)),

        Text('Address', style: labelStyle),
        SizedBox(height: Responsive.height(8)),
        CustomTextField(
          controller: cubit.addressController,
          hinText: 'City, Country',
          validator: (value) =>
              value?.trim().isEmpty ?? true
                  ? 'Address is required'
                  : null,
          prefixIcon: Icon(
            Icons.location_on_outlined,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
