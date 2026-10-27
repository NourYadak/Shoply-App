import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/utils/theme/app_colors.dart';
import 'package:shoply_app/core/utils/widgets/button/custom_button.dart';
import 'package:shoply_app/core/utils/widgets/cached_image_network/custom_cached_image.dart';
import 'package:shoply_app/core/utils/widgets/dialog/custom_error.dart';
import 'package:shoply_app/core/utils/widgets/dialog/custom_success.dart';
import 'package:shoply_app/core/utils/widgets/empty_screen/empty_screen.dart';
import 'package:shoply_app/core/utils/widgets/loading/custom_loading.dart';
import 'package:shoply_app/core/utils/widgets/loading/custom_loading_data.dart';
import 'package:shoply_app/core/utils/widgets/refresh_indicator/custom_refresh_indicator.dart';
import 'package:shoply_app/core/utils/widgets/responsive/responsive.dart';
import 'package:shoply_app/features/cart/view_model/cubit.dart';
import 'package:shoply_app/features/cart/view_model/state.dart';

part 'widgets/cart_card.dart';
part 'widgets/cart_checkout.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);

    return BlocProvider(
      create: (context) => CartCubit()..getCart(),
      child: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartCheckoutLoadingState) {
            CustomLoading.showDialogLoading(context: context);
          } else if (state is CartCheckoutErrorState) {
            Navigator.pop(context);
            CustomDialogError.showProDialogError(
              context: context,
              title: 'Checkout',
              description: state.errorMessage,
              onPressed: () {
                Navigator.pop(context);
              },
            );
          } else if (state is CartCheckoutSuccessState) {
            Navigator.pop(context);
            CustomSuccessDialog.showProSuccessDialog(
              context: context,
              title: 'Checkout',
              description: 'Checkout Successfully.',
              onPressed: () {
                Navigator.pop(context);
              },
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<CartCubit>();

          if (state is CartLoadingState) {
            return const CustomLoadingData();
          } else if (state is CartErrorState) {
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
              await cubit.refreshCart();
            },
            child: cubit.responseCart.isEmpty
                ? const EmptyScreen(
                    emptyText: 'Your cart is empty.\n Start shopping!',
                  )
                : Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: isTablet ? 1000 : double.infinity,
                      ),
                      child: Stack(
                        children: [const _CartCard(), const _CartCheckout()],
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
