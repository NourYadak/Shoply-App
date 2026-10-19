import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shoply_app/core/utils/widgets/appBar/app_bar.dart';
import 'package:shoply_app/core/utils/widgets/loading/custom_loading_data.dart';
import 'package:shoply_app/core/utils/widgets/responsive/responsive.dart';

import 'package:shoply_app/features/favorite/view_model/cubit.dart';
import 'package:shoply_app/features/favorite/view_model/state.dart';
import 'package:shoply_app/features/products/view_model/cubit.dart';
import 'package:shoply_app/features/products/view_model/state.dart';

import 'widgets/favorite_products_card.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductsCubit()..getProducts(categoryId: 'all'),
      child: Scaffold(
        appBar: const CustomAppBar(titleText: 'Favorite Products'),
        body: BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, productsState) {
            final productsCubit = context.read<ProductsCubit>();

            if (productsState is ProductsLoadingState) {
              return CustomLoadingData();
            }

            if (productsState is ProductsErrorState) {
              return Center(
                child: Text(
                  productsState.errorMessage,
                  textAlign: TextAlign.center,
                ),
              );
            }

            return BlocBuilder<FavoriteCubit, FavoriteState>(
              builder: (context, favoriteState) {
                final favoriteCubit = context.read<FavoriteCubit>();

                final favoriteProducts = productsCubit.responseProducts.where((
                  product,
                ) {
                  final productId = product.id;

                  return productId != null &&
                      favoriteCubit.isFavorite(productId);
                }).toList();

                if (favoriteProducts.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.favorite_border,
                          size: 70,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No favorite products yet',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                }

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
                        (width -
                            Responsive.width(24) -
                            spacing * (crossAxisCount - 1)) /
                        crossAxisCount;

                    final imageHeight = itemWidth * 0.85;
                    final itemHeight = imageHeight + Responsive.height(100);

                    return Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1100),
                        child: GridView.builder(
                          padding: EdgeInsets.all(Responsive.width(12)),
                          itemCount: favoriteProducts.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                mainAxisExtent: itemHeight,
                                crossAxisSpacing: spacing,
                                mainAxisSpacing: Responsive.height(16),
                              ),
                          itemBuilder: (context, index) {
                            final product = favoriteProducts[index];

                            return FavoriteProductsCard(
                              key: ValueKey(product.id),
                              product: product,
                              imageHeight: imageHeight,
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
