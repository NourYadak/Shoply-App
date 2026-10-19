part of '../login_screen.dart';

class _LoginHeader extends StatelessWidget {
  const _LoginHeader();

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);

    return Padding(
      padding: EdgeInsets.all(Responsive.width(isTablet ? 12 : 8)),
      child: Column(
        children: [
          Image(
            image: AssetImage(AppImages.shoplySplashImage),
            height: Responsive.height(isTablet ? 240 : 180),
            width: double.infinity,
            fit: BoxFit.contain,
          ),
          SizedBox(height: Responsive.height(12)),
          Text(
            'Welcome Back',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Responsive.font(isTablet ? 40 : 32),
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),
          SizedBox(height: Responsive.height(6)),
          Text(
            'Sign in to continue shopping',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Responsive.font(isTablet ? 22 : 17),
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
