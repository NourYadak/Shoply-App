part of '../update_profile_screen.dart';

class _UpdateProfileTextfields extends StatelessWidget {
  const _UpdateProfileTextfields();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UpdateProfileCubit>();
    final isTablet = Responsive.isTablet(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.width(isTablet ? 12 : 4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Full Name',
            style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
          ),
          SizedBox(height: Responsive.height(6)),
          CustomTextField(
            validator: (value) =>
                value?.trim().isEmpty ?? true ? 'Full Name is required' : null,
            controller: cubit.fullNameController,
            hinText: 'Mohammad',
            prefixIcon: Icon(
              Icons.person_outlined,
              color: Colors.grey.shade800,
            ),
          ),
          SizedBox(height: Responsive.height(14)),

          const Text(
            'Username',
            style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
          ),
          SizedBox(height: Responsive.height(6)),
          CustomTextField(
            validator: (value) =>
                value?.trim().isEmpty ?? true ? 'Username is required' : null,
            controller: cubit.userNameController,
            hinText: 'mohammad',
            prefixIcon: Icon(
              Icons.person_outlined,
              color: Colors.grey.shade800,
            ),
          ),
          SizedBox(height: Responsive.height(14)),

          const Text(
            'Email',
            style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
          ),
          SizedBox(height: Responsive.height(6)),
          CustomTextField(
            validator: (value) {
              if (value?.trim().isEmpty ?? true) return 'Email is required';
              if (!AppRegex.emailRegex.hasMatch(value!.trim()))
                return 'Invalid email';
              return null;
            },
            controller: cubit.emailController,
            hinText: 'mohammad@example.com',
            prefixIcon: Icon(Icons.email_outlined, color: Colors.grey.shade800),
          ),
          SizedBox(height: Responsive.height(14)),

          const Text(
            'Address',
            style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
          ),
          SizedBox(height: Responsive.height(6)),
          CustomTextField(
            validator: (value) =>
                value?.trim().isEmpty ?? true ? 'Address is required' : null,
            controller: cubit.addressController,
            hinText: 'Amman, Jordan',
            prefixIcon: Icon(
              Icons.location_on_outlined,
              color: Colors.grey.shade800,
            ),
          ),
        ],
      ),
    );
  }
}
