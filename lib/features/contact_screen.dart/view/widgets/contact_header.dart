part of '../contact_screen.dart';

class _ContactHeader extends StatelessWidget {
  const _ContactHeader();

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);

    return Column(
      children: [
        Container(
          width: Responsive.width(isTablet ? 100 : 100),
          height: Responsive.width(isTablet ? 100 : 100),
          decoration: const BoxDecoration(
            color: const Color(0xFFE8F5EE),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.headset_mic_rounded,
            size: Responsive.width(isTablet ? 55 : 50),
            color: Color(0xFF218C61),
          ),
        ),

        SizedBox(height: Responsive.height(isTablet ? 22 : 18)),

        Text(
          'How can we help?',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: Responsive.font(isTablet ? 30 : 25),
            fontWeight: FontWeight.w800,
            color: const Color(0xFF202820),
          ),
        ),

        SizedBox(height: Responsive.height(8)),

        Text(
          "Send us a message, We're here for you.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: Responsive.font(isTablet ? 17 : 14),
            height: 1.6,
            color: Colors.grey.shade600,
          ),
        ),

        SizedBox(height: Responsive.height(isTablet ? 24 : 18)),

        Container(
          padding: EdgeInsets.all(Responsive.width(isTablet ? 18 : 14)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Responsive.radius(16)),
            border: Border.all(color: const Color(0xFFE4EAE5)),
          ),
          child: Row(
            children: [
              Container(
                width: Responsive.width(isTablet ? 50 : 44),
                height: Responsive.width(isTablet ? 50 : 33),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Responsive.radius(12)),
                ),
                child: Icon(
                  Icons.email_outlined,
                  color: const Color(0xFF218C61),
                  size: Responsive.width(isTablet ? 27 : 23),
                ),
              ),

              SizedBox(width: Responsive.width(12)),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email us directly',
                      style: TextStyle(
                        fontSize: Responsive.font(isTablet ? 14 : 12),
                        color: Colors.grey.shade600,
                      ),
                    ),

                    SizedBox(height: Responsive.height(4)),

                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'support@shoply.com',
                        style: TextStyle(
                          fontSize: Responsive.font(isTablet ? 16 : 14),
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF218C61),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
