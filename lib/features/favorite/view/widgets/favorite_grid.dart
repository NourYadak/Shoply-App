part of '../favorite_screen.dart';

class _FavoriteGrid extends StatelessWidget {
  const _FavoriteGrid();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FavoriteCubit>();

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        // Responsive number of columns
        final crossAxisCount = width >= 1000
            ? 4
            : width >= 650
            ? 3
            : 2;

        final horizontalSpacing = Responsive.width(12);
        final verticalSpacing = Responsive.height(12);
        final horizontalPadding = Responsive.width(4);

        final itemWidth =
            (width -
                (horizontalPadding * 2) -
                (horizontalSpacing * (crossAxisCount - 1))) /
            crossAxisCount;

        final imageHeight = itemWidth * 0.85;

        return GridView.builder(
          itemCount: cubit.responseProducts.length,
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: Responsive.height(8),
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: horizontalSpacing,
            mainAxisSpacing: verticalSpacing,
            mainAxisExtent: imageHeight + Responsive.height(155),
          ),
          itemBuilder: (context, index) {
            final favouriteData = cubit.responseProducts[index];

            return Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Responsive.radius(16)),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product image and remove button
                  SizedBox(
                    width: double.infinity,
                    height: imageHeight,
                    child: Container(
                      color: Colors.grey.shade100,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          favouriteData.images.isNotEmpty
                              ? CustomCachedImageNetwork(
                                  fit: BoxFit.contain,
                                  image: favouriteData.images.first,
                                )
                              : const Center(
                                  child: Icon(
                                    Icons.image_not_supported_outlined,
                                  ),
                                ),

                          Positioned(
                            top: Responsive.height(6),
                            right: Responsive.width(6),
                            child: Material(
                              color: Colors.white.withValues(alpha: 0.9),
                              shape: const CircleBorder(),
                              child: InkWell(
                                customBorder: const CircleBorder(),
                                onTap: () {
                                  final productId = favouriteData.id;

                                  if (productId != null &&
                                      productId.isNotEmpty) {
                                    cubit.removeProductFromFav(
                                      context: context,
                                      productId: productId,
                                    );
                                  }
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(Responsive.width(6)),
                                  child: Icon(
                                    Icons.favorite,
                                    size: Responsive.width(22),
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Product information
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        Responsive.width(8),
                        Responsive.height(8),
                        Responsive.width(8),
                        Responsive.height(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            favouriteData.name ?? '',
                            style: TextStyle(
                              fontSize: Responsive.font(15),
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),

                          SizedBox(height: Responsive.height(4)),

                          Text(
                            '\$ ${(favouriteData.price ?? 0).toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: Responsive.font(17),
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),

                          const Spacer(),

                          SizedBox(
                            width: double.infinity,
                            child: CustomButton(
                              radius: Responsive.radius(12),
                              height: Responsive.height(44),
                              style: TextStyle(
                                fontSize: Responsive.font(14),
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                              ),
                              buttonText: 'Add to Cart',
                              onPressed: () {
                                cubit.addToCart(
                                  requestCart: Cart(
                                    id: favouriteData.id,
                                    name: favouriteData.name,
                                    price: favouriteData.price,
                                    quantity: 1,
                                    images: favouriteData.images,
                                  ),
                                  context: context,
                                );
                              },
                            ),
                          ),
                        ],
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
