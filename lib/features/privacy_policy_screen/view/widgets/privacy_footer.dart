part of '../privacy_policy_screen.dart';

class _PrivacyFooter extends StatelessWidget {
  const _PrivacyFooter();

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Divider رمادي خفيف بأسفل الصفحة فوق النصوص
        const Divider(height: 1, thickness: 1, color: Color(0xFFE4EAE5)),

        Container(
          width: double.infinity,
          color: Colors.white,
          padding: EdgeInsets.symmetric(
            vertical: Responsive.height(isTablet ? 14 : 10),
            horizontal: Responsive.width(16),
          ),
          child: Column(
            children: [
              // Text(
              //   'Made for better shopping ♥️',
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //     fontSize: Responsive.font(isTablet ? 14 : 12),
              //     color: Colors.grey.shade600,
              //     fontWeight: FontWeight.w500,
              //   ),
              // ),
              SizedBox(height: Responsive.height(4)),
              Text(
                'Sample policy for UI preview.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Responsive.font(isTablet ? 13 : 11),
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
