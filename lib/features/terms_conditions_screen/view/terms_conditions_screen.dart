import 'package:flutter/material.dart';
import 'package:shoply_app/core/utils/widgets/responsive/responsive.dart';

part 'widgets/terms_header.dart';
part 'widgets/terms_section.dart';
part 'widgets/terms_footer.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);

    // أقسام الشروط والأحكام الخاصة بالتطبيق كما في الصورة
    final List<Map<String, dynamic>> termsSections = [
      {
        'number': '1',
        'icon': Icons.person_outline_rounded,
        'title': 'Using Your Account',
        'content':
            'Keep your account information accurate and your sign-in details secure.',
      },
      {
        'number': '2',
        'icon': Icons.payment_rounded,
        'title': 'Orders & Payments',
        'content':
            'Review prices, availability, and payment details before placing your order.',
      },
      {
        'number': '3',
        'icon': Icons.local_shipping_outlined,
        'title': 'Shipping & Delivery',
        'content':
            'Delivery estimates and charges are shown during checkout.',
      },
      {
        'number': '4',
        'icon': Icons.assignment_return_outlined,
        'title': 'Returns & Refunds',
        'content':
            'Review the return conditions provided with your order before requesting a return.',
      },
      {
        'number': '5',
        'icon': Icons.support_agent_rounded,
        'title': 'Contact Us',
        'content': 'For questions, visit Contact Us in the app.',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Terms & Conditions',
          style: TextStyle(
            fontSize: Responsive.font(isTablet ? 23 : 20),
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // محتوى الشروط والأحكام القابل للتمرير
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.width(isTablet ? 32 : 16),
                  vertical: Responsive.height(isTablet ? 20 : 12),
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: isTablet ? 600 : double.infinity,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // الهيدر الرئيسي
                        const _TermsHeader(),

                        SizedBox(height: Responsive.height(isTablet ? 30 : 22)),

                        // عرض بنود الشروط والأحكام داخل بطاقات مرتبة
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: termsSections.length,
                          separatorBuilder: (context, index) => SizedBox(
                            height: Responsive.height(isTablet ? 16 : 12),
                          ),
                          itemBuilder: (context, index) {
                            final section = termsSections[index];
                            return _TermsSection(
                              number: section['number']!,
                              icon: section['icon'] as IconData,
                              title: section['title']!,
                              content: section['content']!,
                            );
                          },
                        ),

                        SizedBox(height: Responsive.height(16)),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // الفوتر المثبت أسفل الشاشة مع الـ Divider الرمادي
            const _TermsFooter(),
          ],
        ),
      ),
    );
  }
}