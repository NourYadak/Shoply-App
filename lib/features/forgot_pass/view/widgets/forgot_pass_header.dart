part of '../forgot_pass_screen.dart';

class _ForgotPasswordHeader extends StatelessWidget {
  const _ForgotPasswordHeader();

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);
    final circleSize = Responsive.width(isTablet ? 180 : 140);

    return Padding(
      padding: EdgeInsets.all(Responsive.width(isTablet ? 12 : 8)),
      child: Column(
        children: [
          Container(
            height: circleSize,
            width: circleSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryColor.withValues(alpha: 0.15),
            ),
            child: Icon(
              Icons.lock,
              size: Responsive.width(isTablet ? 80 : 60),
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(height: Responsive.height(20)),
          Text(
            'Forgot Password?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Responsive.font(isTablet ? 32 : 26),
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: Responsive.height(12)),
          Text(
            'Enter your email and we\'ll send\nyour reset link.',
            style: TextStyle(
              fontSize: Responsive.font(isTablet ? 22 : 17),
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
