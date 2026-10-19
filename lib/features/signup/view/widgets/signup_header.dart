
part of '../signup_screen.dart';

class _SignupHeader extends StatelessWidget {
  const _SignupHeader();

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);

    final avatarRadius = Responsive.width(isTablet ? 75 : 60);
    final cameraSize = Responsive.width(isTablet ? 36 : 30);

    return Padding(
      padding: EdgeInsets.all(
        Responsive.width(isTablet ? 16 : 8),
      ),
      child: Column(
        children: [
          Text(
            'Join us and start shopping',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Responsive.font(isTablet ? 22 : 18),
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),

          SizedBox(
            height: Responsive.height(isTablet ? 26 : 20),
          ),

          Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: avatarRadius,
                backgroundColor: Colors.grey.shade300,
                backgroundImage: AssetImage(
                  AppImages.profilePicture,
                ),
              ),

              Positioned(
                bottom: Responsive.height(5),
                right: Responsive.width(5),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: cameraSize,
                    width: cameraSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryColor,
                    ),
                    child: Icon(
                      Icons.camera_alt_sharp,
                      color: Colors.white,
                      size: Responsive.width(isTablet ? 23 : 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
