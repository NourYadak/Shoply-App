part of '../terms_conditions_screen.dart';

class _TermsHeader extends StatelessWidget {
  const _TermsHeader();

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);

    return Column(
      children: [
        // أيقونة المستند العلوية
        Container(
          width: Responsive.width(isTablet ? 96 : 84),
          height: Responsive.width(isTablet ? 96 : 84),
          decoration: const BoxDecoration(
            color: Color(0xFFE8F5EE),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.description_outlined,
            size: Responsive.width(isTablet ? 48 : 42),
            color: const Color(0xFF218C61),
          ),
        ),

        SizedBox(height: Responsive.height(isTablet ? 20 : 16)),

        // العنوان الرئيسي
        Text(
          'Shopping with Shoply',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: Responsive.font(isTablet ? 26 : 24.5),
            fontWeight: FontWeight.bold,
            color: const Color(0xFF202820),
            letterSpacing: -0.3,
          ),
        ),

        SizedBox(height: Responsive.height(6)),

        // تاريخ آخر تحديث
        Text(
          'Last updated: October 16, 2026',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: Responsive.font(isTablet ? 15 : 13),
            color: Colors.grey.shade800,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
