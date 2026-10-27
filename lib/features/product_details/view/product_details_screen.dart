import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/model/cart/cart.dart';
import 'package:shoply_app/core/model/products/response_products.dart';
import 'package:shoply_app/core/utils/theme/app_colors.dart';
import 'package:shoply_app/core/utils/widgets/appBar/app_bar.dart';
import 'package:shoply_app/core/utils/widgets/button/custom_button.dart';
import 'package:shoply_app/core/utils/widgets/cached_image_network/custom_cached_image.dart';
import 'package:shoply_app/core/utils/widgets/dialog/custom_error.dart';
import 'package:shoply_app/core/utils/widgets/dialog/custom_success.dart';
import 'package:shoply_app/core/utils/widgets/loading/custom_loading.dart';
import 'package:shoply_app/core/utils/widgets/smooth_indicator/custom_indicator.dart';
import 'package:shoply_app/features/product_details/view_model/cubit.dart';
import 'package:shoply_app/features/product_details/view_model/state.dart';

part 'widgets/product_details_header.dart';
part 'widgets/product_details_body.dart';
part 'widgets/product_details_footer.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.responseProducts});

  final ResponseProducts responseProducts;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ProductDetailsCubit()
            ..checkIfProductInFavorite(productId: responseProducts.id ?? ''),
      child: Builder(
        builder: (context) {
          final cubit = context.read<ProductDetailsCubit>();

          return Scaffold(
            backgroundColor: const Color(0xFFF8F8FA),
            appBar: CustomAppBar(
              actions: [
                BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
                  buildWhen: (previous, current) =>
                      current is ProductDetailsChangeFavoriteState ||
                      current is ProductDetailsFavoriteLoadingState ||
                      current is ProductDetailsFavoriteErrorState ||
                      current is ProductDetailsFavoriteSucessState,
                  builder: (context, state) {
                    return IconButton(
                      onPressed: () {
                        cubit.changeIsFavorite(
                          responseProducts: responseProducts,
                          context: context,
                        );
                      },
                      icon: Icon(
                        cubit.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                        size: 27,
                      ),
                    );
                  },
                ),
                const SizedBox(width: 8),
              ],
            ),

            body: BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
              listenWhen: (previous, current) =>
                  current is! ProductDetailsChangeQuantityState &&
                  current is! ProductDetailsChangeFavoriteState &&
                  current is! ProductDetailsFavoriteLoadingState &&
                  current is! ProductDetailsFavoriteSucessState,
              listener: (context, state) {
                if (state is ProductDetailsAddToCartLoadingState) {
                  CustomLoading.showDialogLoading(context: context);
                } else if (state is ProductDetailsAddToCartErrorState) {
                  Navigator.of(context, rootNavigator: true).pop();
                  CustomDialogError.showProDialogError(
                    context: context,
                    title: 'Add to Cart',
                    description: state.errorMessage,
                    onPressed: () => Navigator.pop(context),
                  );
                } else if (state is ProductDetailsAddToCartSuccessState) {
                  Navigator.of(context, rootNavigator: true).pop();
                  CustomSuccessDialog.showProSuccessDialog(
                    context: context,
                    title: 'Add to Cart',
                    description: 'Added to cart successfully.',
                    onPressed: () => Navigator.pop(context),
                  );
                }
              },
              builder: (context, state) {
                return LayoutBuilder(
                  builder: (context, constraints) {
                    final screenWidth = MediaQuery.sizeOf(context).width;
                    final horizontalPadding = screenWidth >= 600 ? 28.0 : 18.0;

                    return SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(
                        horizontalPadding,
                        16,
                        horizontalPadding,
                        24,
                      ),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 760),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _ProductDetailsHeader(
                                responseProducts: responseProducts,
                              ),
                              const SizedBox(height: 26),
                              _ProductDetailsBody(
                                responseProducts: responseProducts,
                              ),
                              const SizedBox(height: 24),
                              _ProductDetailsFooter(
                                responseProducts: responseProducts,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
