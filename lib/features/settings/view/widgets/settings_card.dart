part of '../settings_screen.dart';

class _SettingsCard extends StatelessWidget {
  const _SettingsCard();

  @override
  Widget build(BuildContext context) {


    return Column(
      children: [
        _SettingsTile(
          icon: Icons.person_2_outlined,
          title: 'Update Profile',
          onTap: () {
            Navigator.pushNamed(context, AppPages.updateProfileScreen);
          },
        ),
        SizedBox(height: Responsive.height(12)),

        _SettingsTile(
          icon: Icons.lock_outlined,
          title: 'Update Password',
          onTap: () {
            Navigator.pushNamed(context, AppPages.updatePassScreen);
          },
        ),
        SizedBox(height: Responsive.height(12)),

        _SettingsTile(
          icon: Icons.info_outline_rounded,
          title: 'About',
          onTap: () {
            Navigator.pushNamed(context, AppPages.aboutScreen);
          },
        ),

        SizedBox(height: Responsive.height(35)),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.width(16),
            vertical: Responsive.height(18),
          ),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,

            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            children: [
              Icon(icon, size: 25, color: AppColors.primaryColor),
              SizedBox(width: Responsive.width(14)),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: Responsive.font(16),
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 17,
                color: Colors.grey.shade500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
