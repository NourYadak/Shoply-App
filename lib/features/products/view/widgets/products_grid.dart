part of '../products_screen.dart';

class _ProductsGrid extends StatelessWidget {
  const _ProductsGrid();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductsCubit>();

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        final crossAxisCount = width >= 900
            ? 4
            : width >= 600
            ? 3
            : 2;

        final spacing = Responsive.width(12);

        final itemWidth =
            (width - (spacing * (crossAxisCount - 1))) / crossAxisCount;

        final imageHeight = itemWidth * 0.85;
        final itemHeight = imageHeight + Responsive.height(100);

        return GridView.builder(
          itemCount: cubit.responseProducts.length,
          padding: EdgeInsets.all(Responsive.width(12)),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisExtent: itemHeight,
            crossAxisSpacing: spacing,
            mainAxisSpacing: Responsive.height(16),
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
                  SizedBox(height: Responsive.height(8)),

                  // Product image + Favorite icon
                  SizedBox(
                    height: imageHeight,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: imageHeight,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              Responsive.radius(16),
                            ),
                            color: Colors.grey.shade200,
                          ),
                          child: CustomCachedImageNetwork(
                            image: productsData.images.isNotEmpty
                                ? productsData.images[0]
                                : '',
                            fit: BoxFit.contain,
                          ),
                        ),

                        // Favorite icon
                      ],
                    ),
                  ),

                  SizedBox(height: Responsive.height(8)),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.width(8),
                    ),
                    child: Text(
                      productsData.name ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: Responsive.font(16),
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  SizedBox(height: Responsive.height(4)),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.width(8),
                    ),
                    child: Text(
                      '\$ ${productsData.price}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: Responsive.font(18),
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
