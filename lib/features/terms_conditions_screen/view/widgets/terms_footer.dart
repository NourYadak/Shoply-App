part of '../terms_conditions_screen.dart';

class _TermsFooter extends StatelessWidget {
  const _TermsFooter();

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Divider رمادي ناعم يفصل الفوتر
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
