part of '../about_screen.dart';

class _AboutCard extends StatelessWidget {
  const _AboutCard();

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);

    return Column(
      children: [
        _AboutTile(
          icon: Icons.mail_outline,
          title: 'Contact Us',
          onTap: () {
            Navigator.pushNamed(context, AppPages.contactScreen);
          },
        ),
        SizedBox(height: Responsive.height(12)),

        _AboutTile(
          icon: Icons.description_outlined,
          title: 'Privacy Policy',
          onTap: () {
            Navigator.pushNamed(context, AppPages.privacyScreen);
          },
        ),
        SizedBox(height: Responsive.height(12)),

        _AboutTile(
          icon: Icons.info_outline,
          title: 'Terms & Conditions',
          onTap: () {
            Navigator.pushNamed(context, AppPages.termsConditionsScreen);
          },
        ),

        SizedBox(height: Responsive.height(35)),

        Text(
          'Made for better shopping ♥',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: Responsive.font(isTablet ? 16 : 14),
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade500,
          ),
        ),
      ],
    );
  }
}

class _AboutTile extends StatelessWidget {
  const _AboutTile({
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
      color: Theme.of(context).cardColor,
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
            color: Theme.of(context).cardColor,

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
                    color: Theme.of(context).dividerColor,
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
