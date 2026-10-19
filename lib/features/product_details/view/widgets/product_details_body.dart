
part of '../product_details_screen.dart';

class _ProductDetailsBody extends StatelessWidget {
  const _ProductDetailsBody({
    required this.responseProducts,
  });

  final ResponseProducts responseProducts;

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.width(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            responseProducts.name ?? '',
            softWrap: true,
            style: TextStyle(
              fontSize: Responsive.font(isTablet ? 26 : 22),
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: Responsive.height(5)),
          Text(
            '\$ ${responseProducts.price ?? ''}',
            softWrap: true,
            style: TextStyle(
              fontSize: Responsive.font(isTablet ? 36 : 32),
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(height: Responsive.height(20)),
          Text(
            responseProducts.description ?? '',
            softWrap: true,
            style: TextStyle(
              fontSize: Responsive.font(isTablet ? 20 : 18),
              fontWeight: FontWeight.w700,
              height: 1.5,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
