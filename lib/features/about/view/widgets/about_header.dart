part of '../about_screen.dart';

class _AboutHeader extends StatelessWidget {
  const _AboutHeader();

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);

    return Padding(
      padding: EdgeInsets.all(Responsive.width(isTablet ? 12 : 8)),
      child: Column(
        children: [
          Image(
            image: AssetImage(AppImages.shoplySplashImage),
            height: Responsive.height(isTablet ? 250 : 190),
            width: double.infinity,
            fit: BoxFit.contain,
          ),
          SizedBox(height: Responsive.height(1)),
          Text(
            'Version 1.0.0',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Responsive.font(isTablet ? 22 : 17),
              fontWeight: FontWeight.w800,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: Responsive.height(30)),
          Text(
            'Your everyday shopping \n companion.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Responsive.font(isTablet ? 27 : 18),
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
