part of '../product_details_screen.dart';

class _ProductDetailsBody extends StatelessWidget {
  const _ProductDetailsBody({required this.responseProducts});

  final ResponseProducts responseProducts;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          responseProducts.name ?? '',
          style: TextStyle(
            fontFamily: 'quickSand',

            fontSize: width >= 600 ? 28 : 20,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).dividerColor,
            //height: 1.3,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          '\$${(responseProducts.price ?? 0).toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: width >= 600 ? 32 : 25,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        const SizedBox(height: 20),
        Divider(height: 1, color: Colors.grey.shade300),
        const SizedBox(height: 18),
        Text(
          'Product Description',
          style: TextStyle(
            fontFamily: 'quickSand',

            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).dividerColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          (responseProducts.description ?? '').trim().isEmpty
              ? 'No description available.'
              : responseProducts.description!,
          style: TextStyle(
            fontSize: width >= 600 ? 16 : 15,
            height: 1.65,
            fontWeight: FontWeight.w400,
            color: Theme.of(context).dividerColor,
          ),
        ),
      ],
    );
  }
}
