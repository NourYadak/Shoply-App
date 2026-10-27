part of '../product_details_screen.dart';

class _ProductDetailsHeader extends StatelessWidget {
  const _ProductDetailsHeader({required this.responseProducts});

  final ResponseProducts responseProducts;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductDetailsCubit>();
    final width = MediaQuery.sizeOf(context).width;

    final imageHeight = width >= 900
        ? 380.0
        : width >= 600
        ? 320.0
        : 250.0;

    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          SizedBox(
            height: imageHeight,
            child: responseProducts.images.isEmpty
                ? Center(
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      size: 54,
                      color: Colors.grey.shade400,
                    ),
                  )
                : PageView.builder(
                    controller: cubit.pageController,
                    itemCount: responseProducts.images.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: CustomCachedImageNetwork(
                          fit: BoxFit.contain,
                          image: responseProducts.images[index],
                        ),
                      );
                    },
                  ),
          ),
          if (responseProducts.images.length > 1) ...[
            //const SizedBox(height: 10),
            CustomSmoothIndicator(
              pageController: cubit.pageController,
              count: responseProducts.images.length,
            ),
          ],
        ],
      ),
    );
  }
}
