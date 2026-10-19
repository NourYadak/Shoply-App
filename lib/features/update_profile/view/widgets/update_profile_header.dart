part of '../update_profile_screen.dart';

class _UpdateProfileHeader extends StatelessWidget {
  const _UpdateProfileHeader();

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<UpdateProfileCubit>();
    final isTablet = Responsive.isTablet(context);

    final avatarRadius = Responsive.width(isTablet ? 75 : 55);
    final cameraSize = Responsive.width(isTablet ? 36 : 32);

    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: avatarRadius,
            backgroundColor: Colors.grey.shade300,
            backgroundImage: cubit.image != null
                ? FileImage(cubit.image!) as ImageProvider
                : const AssetImage(AppImages.profilePicture),
          ),
          GestureDetector(
            onTap: () => cubit.pickImage(),
            child: Container(
              height: cameraSize,
              width: cameraSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryColor,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: Icon(
                Icons.camera_alt_sharp,
                color: Colors.white,
                size: Responsive.width(isTablet ? 23 : 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
