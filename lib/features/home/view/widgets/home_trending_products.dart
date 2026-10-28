part of '../home_screen.dart';

class _HomeTrendingProducts extends StatelessWidget {
  const _HomeTrendingProducts();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomViewAll(text: 'Trending Products', onTapViewAll: () {}),

        SizedBox(height: Responsive.height(12)),

        LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;

            // Number of columns based on available width
            final crossAxisCount = width >= 1000
                ? 4
                : width >= 650
                ? 3
                : 2;

            final horizontalSpacing = Responsive.width(12);
            final verticalSpacing = Responsive.height(12);
            final horizontalPadding = Responsive.width(8);

            final itemWidth =
                (width -
                    (horizontalPadding * 2) -
                    (horizontalSpacing * (crossAxisCount - 1))) /
                crossAxisCount;

            final imageHeight = itemWidth * 0.85;

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: Responsive.height(8),
              ),
              itemCount: cubit.responseProducts.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisExtent: imageHeight + Responsive.height(95),
                crossAxisSpacing: horizontalSpacing,
                mainAxisSpacing: verticalSpacing,
              ),
              itemBuilder: (context, index) {
                final productsData = cubit.responseProducts[index];

                return GestureDetector(
                  onTap: () {
                    final mainCubit = context.read<MainCubit>();

                    Navigator.pushNamed(
                      context,
                      AppPages.productsDetailsScreen,
                      arguments: {
                        'responseProducts': productsData,
                        'mainCubit': mainCubit,
                      },
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product image
                      Container(
                        width: double.infinity,
                        height: imageHeight,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            Responsive.radius(16),
                          ),
                          color: Theme.of(context).disabledColor,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            Responsive.radius(16),
                          ),
                          child: productsData.images.isNotEmpty
                              ? CustomCachedImageNetwork(
                                  fit: BoxFit.contain,
                                  image: productsData.images.first,
                                )
                              : const Center(
                                  child: Icon(
                                    Icons.image_not_supported_outlined,
                                  ),
                                ),
                        ),
                      ),

                      SizedBox(height: Responsive.height(8)),

                      // Product name
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Responsive.width(8),
                        ),
                        child: Text(
                          productsData.name ?? '',

                          style: TextStyle(
                            fontSize: Responsive.font(16),
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).dividerColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      SizedBox(height: Responsive.height(5)),

                      // Product price
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Responsive.width(8),
                        ),
                        child: Text(
                          '\$ ${(productsData.price ?? 0).toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: Responsive.font(18),
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).dividerColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
