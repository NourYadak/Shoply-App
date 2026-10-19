
part of '../product_details_screen.dart';

class _ProductDetailsHeader extends StatelessWidget {
  const _ProductDetailsHeader({
    required this.responseProducts,
  });

  final ResponseProducts responseProducts;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductDetailsCubit>();
    final isTablet = Responsive.isTablet(context);

    return Column(
      children: [
        SizedBox(
          height: Responsive.height(isTablet ? 320 : 240),
          width: double.infinity,
          child: PageView.builder(
            controller: cubit.pageController,
            itemCount: responseProducts.images.length,
            itemBuilder: (context, index) {
              return CustomCachedImageNetwork(
                image: responseProducts.images[index],
              );
            },
          ),
        ),
        SizedBox(height: Responsive.height(16)),
        CustomSmoothIndicator(
          pageController: cubit.pageController,
          count: responseProducts.images.length,
        ),
      ],
    );
  }
}
