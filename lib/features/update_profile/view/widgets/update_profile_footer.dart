part of '../update_profile_screen.dart';

class _UpdateProfileFooter extends StatelessWidget {
  const _UpdateProfileFooter();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UpdateProfileCubit>();
    final isTablet = Responsive.isTablet(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.width(isTablet ? 12 : 4),
      ),
      child: CustomButton(
        buttonText: 'Save Changes',
        onPressed: () {
          cubit.updateProfile();
        },
      ),
    );
  }
}
