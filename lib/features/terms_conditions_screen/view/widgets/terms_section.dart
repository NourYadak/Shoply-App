part of '../terms_conditions_screen.dart';

class _TermsSection extends StatelessWidget {
  final String number;
  final IconData icon;
  final String title;
  final String content;

  const _TermsSection({
    required this.number,
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);

    return Container(
      padding: EdgeInsets.all(Responsive.width(isTablet ? 18 : 14)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Responsive.radius(16)),
        border: Border.all(color: const Color(0xFFE4EAE5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // أيقونة توضيحية لكل بند
              Container(
                padding: EdgeInsets.all(Responsive.width(8)),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5EE),
                  borderRadius: BorderRadius.circular(Responsive.radius(10)),
                ),
                child: Icon(
                  icon,
                  size: Responsive.width(isTablet ? 22 : 18),
                  color: const Color(0xFF218C61),
                ),
              ),

              SizedBox(width: Responsive.width(16)),

              // عنوان البند مع الرقم
              Expanded(
                child: Text(
                  ' $title',
                  style: TextStyle(
                    fontSize: Responsive.font(isTablet ? 16 : 16),
                    fontWeight: FontWeight.w700,
                    color: const Color.fromARGB(255, 24, 108, 75),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: Responsive.height(10)),

          // نص البند
          Text(
            content,
            style: TextStyle(
              fontSize: Responsive.font(isTablet ? 14 : 13),
              height: 1.5,

              color: Colors.grey.shade900,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
