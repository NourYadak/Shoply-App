import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shoply_app/core/model/products/response_products.dart';
import 'package:shoply_app/core/routes/app_pages.dart';
import 'package:shoply_app/core/utils/widgets/cached_image_network/custom_cached_image.dart';
import 'package:shoply_app/core/utils/widgets/responsive/responsive.dart';

import 'package:shoply_app/features/favorite/view_model/cubit.dart';
import 'package:shoply_app/features/favorite/view_model/state.dart';
import 'package:shoply_app/features/main/view_model/cubit.dart';

class FavoriteProductsCard extends StatelessWidget {
  const FavoriteProductsCard({
    super.key,
    required this.product,
    required this.imageHeight,
  });

  final ResponseProducts product;
  final double imageHeight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final mainCubit = context.read<MainCubit>();

        Navigator.pushNamed(
          context,
          AppPages.productsDetailsScreen,
          arguments: {'responseProducts': product, 'mainCubit': mainCubit},
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: Responsive.height(8)),
          SizedBox(
            height: imageHeight,
            width: double.infinity,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        Responsive.radius(16),
                      ),
                      color: Colors.grey.shade200,
                    ),
                    child: CustomCachedImageNetwork(
                      image: product.images.isNotEmpty ? product.images[0] : '',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: BlocBuilder<FavoriteCubit, FavoriteState>(
                    builder: (context, state) {
                      final cubit = context.read<FavoriteCubit>();

                      final isFavorite = cubit.isFavorite(product.id ?? '');

                      return IconButton(
                        onPressed: () {
                          cubit.changeFavouirte(product.id ?? '');
                        },
                        icon: Icon(
                          isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border_outlined,
                          size: 25,
                          color: Colors.red,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: Responsive.height(8)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Responsive.width(8)),
            child: Text(
              product.name ?? '',
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
            padding: EdgeInsets.symmetric(horizontal: Responsive.width(8)),
            child: Text(
              '\$ ${product.price}',
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
  }
}
