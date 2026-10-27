import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/model/cart/cart.dart';
import 'package:shoply_app/core/utils/widgets/button/custom_button.dart';
import 'package:shoply_app/core/utils/widgets/cached_image_network/custom_cached_image.dart';
import 'package:shoply_app/core/utils/widgets/dialog/custom_error.dart';
import 'package:shoply_app/core/utils/widgets/dialog/custom_success.dart';
import 'package:shoply_app/core/utils/widgets/empty_screen/empty_screen.dart';
import 'package:shoply_app/core/utils/widgets/loading/custom_loading.dart';
import 'package:shoply_app/core/utils/widgets/loading/custom_loading_data.dart';
import 'package:shoply_app/core/utils/widgets/refresh_indicator/custom_refresh_indicator.dart';
import 'package:shoply_app/core/utils/widgets/responsive/responsive.dart';
import 'package:shoply_app/features/favorite/view_model/cubit.dart';
import 'package:shoply_app/features/favorite/view_model/state.dart';

part 'widgets/favorite_grid.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);

    return BlocProvider(
      create: (context) => FavoriteCubit()..getFavourite(),
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<FavoriteCubit, FavoriteState>(
            listener: (context, state) {
              if (state is FavoriteAddToCartLoadingState) {
                CustomLoading.showDialogLoading(context: context);
              } else if (state is FavoriteAddToCartErrorState) {
                Navigator.pop(context);

                CustomDialogError.showProDialogError(
                  context: context,
                  title: 'Add to Cart',
                  description: state.errorMessage,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                );
              } else if (state is FavoriteAddToCartSuccessState) {
                Navigator.pop(context);

                CustomSuccessDialog.showProSuccessDialog(
                  context: context,
                  title: 'Add to Cart',
                  description: 'Added to cart successfully.',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                );
              }
            },
            builder: (context, state) {
              final cubit = context.read<FavoriteCubit>();

              if (state is FavoriteLoadingState) {
                return const Center(child: CustomLoadingData());
              }

              if (state is FavoriteErrorState) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.all(Responsive.width(16)),
                    child: Text(
                      state.errorMessage,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: Responsive.font(16)),
                    ),
                  ),
                );
              }

              return CustomRefreshIndicator(
                onRefresh: () async {
                  await cubit.refreshFavourite();
                },
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: isTablet ? 1100 : double.infinity,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Responsive.width(isTablet ? 24 : 8),
                        vertical: Responsive.height(8),
                      ),
                      child: cubit.responseProducts.isEmpty
                          ? EmptyScreen(
                              emptyText:
                                  'Your favourite is empty. Start shopping!',
                            )
                          : _FavoriteGrid(),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
