import 'package:flutter/material.dart';
import 'package:shoply_app/core/utils/widgets/responsive/responsive.dart';

part 'widgets/privacy_header.dart';
part 'widgets/privacy_section.dart';
part 'widgets/privacy_footer.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);

    // قائمة أقسام سياسة الخصوصية مع أيقونة مخصصة لكل بند
    final List<Map<String, dynamic>> privacySections = [
      {
        'number': '1',
        'icon': Icons.folder_open_rounded,
        'title': 'Information We Collect',
        'content':
            'Account details, delivery addresses, and order information help us provide our services.',
      },
      {
        'number': '2',
        'icon': Icons.tune_rounded,
        'title': 'How We Use Information',
        'content':
            'We use information to manage your account, process orders, and respond to support requests.',
      },
      {
        'number': '3',
        'icon': Icons.share_outlined,
        'title': 'Sharing Information',
        'content':
            'Service providers may receive the information needed to complete your order.',
      },
      {
        'number': '4',
        'icon': Icons.manage_accounts_outlined,
        'title': 'Your Choices',
        'content':
            'You can update your profile or contact us about your information.',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Privacy Policy',
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
            // محتوى الصفحة القابل للتمرير
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
                        const _PrivacyHeader(),

                        SizedBox(height: Responsive.height(isTablet ? 30 : 22)),

                        // عرض النقاط كـ Cards متناسقة
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: privacySections.length,
                          separatorBuilder: (context, index) => SizedBox(
                            height: Responsive.height(isTablet ? 16 : 12),
                          ),
                          itemBuilder: (context, index) {
                            final section = privacySections[index];
                            return _PrivacySection(
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

            // الفوتر المثبت بأسفل الصفحة مع الـ Divider
            const _PrivacyFooter(),
          ],
        ),
      ),
    );
  }
}