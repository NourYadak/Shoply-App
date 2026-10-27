part of '../update_profile_screen.dart';

class _UpdateProfileFooter extends StatelessWidget {
  const _UpdateProfileFooter();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CustomButton(
        buttonText: 'Save Changes',
        onPressed: () {
          FocusScope.of(context).unfocus();
          context.read<UpdateProfileCubit>().updateProfile();
        },
      ),
    );
  }
}
