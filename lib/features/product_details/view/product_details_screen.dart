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
import 'package:shoply_app/core/utils/widgets/responsive/responsive.dart';
part 'widgets/product_details_header.dart';
part 'widgets/product_details_body.dart';
part 'widgets/product_details_footer.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.responseProducts});
  final ResponseProducts responseProducts;
  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);
    return BlocProvider(
      create: (context) => ProductDetailsCubit(),
      child: Scaffold(
        appBar: CustomAppBar(),
        body: BlocListener<ProductDetailsCubit, ProductDetailsState>(
          listenWhen: (previous, current) {
            return current is! ProductDetailsChangeQuantityState;
          },
          listener: (context, state) {
            if (state is ProductDetailsAddToCartLoadingState) {
              CustomLoading.showDialogLoading(context: context);
            } else if (state is ProductDetailsAddToCartErrorState) {
              Navigator.pop(context);
              CustomDialogError.showProDialogError(
                context: context,
                title: 'Add to Cart',
                description: state.errorMessage,
                onPressed: () {
                  Navigator.pop(context);
                },
              );
            } else if (state is ProductDetailsAddToCartSuccessState) {
              Navigator.pop(context);
              CustomSuccessDialog.showProSuccessDialog(
                context: context,
                title: 'Add to Cart',
                description: 'Add to cart successfuly.',
                onPressed: () {
                  Navigator.pop(context);
                },
              );
            }
          },
          child: SingleChildScrollView(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: isTablet ? 900 : double.infinity,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.width(isTablet ? 24 : 16),
                    vertical: Responsive.height(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _ProductDetailsHeader(responseProducts: responseProducts),
                      SizedBox(height: Responsive.height(24)),
                      _ProductDetailsBody(responseProducts: responseProducts),
                      SizedBox(height: Responsive.height(24)),
                      _ProductDetailsFooter(responseProducts: responseProducts),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
