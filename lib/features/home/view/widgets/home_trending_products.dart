part of '../home_screen.dart';

class _HomeTrendingProducts extends StatelessWidget {
  const _HomeTrendingProducts();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    final isTablet = Responsive.isTablet(context);

    return Column(
      children: [
        CustomViewAll(text: 'Trending Products', onTapViewAll: () {}),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: cubit.responseProducts.length,
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.width(12),
            vertical: Responsive.height(8),
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isTablet ? 3 : 2,
            mainAxisSpacing: Responsive.height(16),
            crossAxisSpacing: Responsive.width(16),
            mainAxisExtent: Responsive.height(isTablet ? 270 : 230),
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
                  Expanded(
                    child: Container(
                      width: double.infinity,
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
                  ),
                  SizedBox(height: Responsive.height(8)),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.width(8),
                    ),
                    child: Text(
                      productsData.name ?? '',
                      style: TextStyle(
                        fontSize: Responsive.font(16),
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: Responsive.height(4)),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.width(8),
                    ),
                    child: Text(
                      '\$ ${productsData.price}',
                      style: TextStyle(
                        fontSize: Responsive.font(18),
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
