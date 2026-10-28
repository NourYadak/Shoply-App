part of '../update_profile_screen.dart';

class _UpdateProfileHeader extends StatelessWidget {
  const _UpdateProfileHeader();

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<UpdateProfileCubit>();
    final isTablet = Responsive.isTablet(context);

    final avatarRadius = Responsive.width(isTablet ? 58 : 48);
    final cameraSize = Responsive.width(isTablet ? 38 : 34);

    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              padding: EdgeInsets.all(Responsive.width(4)),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primaryColor.withValues(alpha: 0.35),
                  width: 2,
                ),
              ),
              child: CircleAvatar(
                radius: avatarRadius,
                backgroundColor: Colors.grey.shade100,
                backgroundImage: cubit.image != null
                    ? FileImage(cubit.image!)
                    : const AssetImage(AppImages.profilePicture)
                          as ImageProvider,
              ),
            ),
            Material(
              color: AppColors.primaryColor,
              shape: const CircleBorder(),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: cubit.pickImage,
                child: SizedBox(
                  width: cameraSize,
                  height: cameraSize,
                  child: Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.white,
                    size: Responsive.width(19),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: Responsive.height(8)),
        Text(
          'Change profile photo',
          style: TextStyle(
            color: Theme.of(context).dividerColor,
            fontSize: Responsive.font(16),
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: Responsive.height(8)),
        Text(
          'Personal Information',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: Responsive.font(isTablet ? 24 : 21),
            fontWeight: FontWeight.w700,
            color: Theme.of(context).primaryColor,
          ),
        ),
        SizedBox(height: Responsive.height(7)),
        Text(
          'Keep your profile information up to date.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: Responsive.font(13),
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
