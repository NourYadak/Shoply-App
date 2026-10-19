import 'package:flutter/material.dart';
import 'package:shoply_app/core/routes/app_pages.dart';

import 'package:shoply_app/core/utils/images/app_images.dart';
import 'package:shoply_app/core/utils/theme/app_colors.dart';

import 'package:shoply_app/core/utils/widgets/responsive/responsive.dart';

part 'widgets/about_header.dart';
part 'widgets/about_card.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isTablet ? 520 : double.infinity,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.width(isTablet ? 32 : 16),
                  vertical: Responsive.height(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: Responsive.height(8)),
                    const _AboutHeader(),
                    SizedBox(height: Responsive.height(isTablet ? 40 : 30)),
                    const _AboutCard(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
