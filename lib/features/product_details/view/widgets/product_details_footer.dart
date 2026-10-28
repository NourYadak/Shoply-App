part of '../product_details_screen.dart';

class _ProductDetailsFooter extends StatelessWidget {
  const _ProductDetailsFooter({required this.responseProducts});

  final ResponseProducts responseProducts;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductDetailsCubit>();

    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(18, 14, 18, 14),
        decoration: BoxDecoration(
          color: Theme.of(context).disabledColor,
          border: Border(top: BorderSide(color: Colors.grey.shade200)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 12,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Quantity selector
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Quantity',
                            style: TextStyle(
                              fontFamily: 'quickSand',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).dividerColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _QuantityControlButton(
                            icon: Icons.remove_rounded,
                            onTap: cubit.decrementQuantity,
                          ),
                          SizedBox(
                            width: 44,
                            child:
                                BlocBuilder<
                                  ProductDetailsCubit,
                                  ProductDetailsState
                                >(
                                  buildWhen: (previous, current) =>
                                      current
                                          is ProductDetailsChangeQuantityState,
                                  builder: (context, state) {
                                    return Text(
                                      '${cubit.quantity}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).dividerColor,
                                      ),
                                    );
                                  },
                                ),
                          ),
                          _QuantityControlButton(
                            icon: Icons.add_rounded,
                            onTap: cubit.incrementQuantity,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // Total price and Add to Cart
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total price',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 3),
                          BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
                            buildWhen: (previous, current) =>
                                current is ProductDetailsChangeQuantityState,
                            builder: (context, state) {
                              final total =
                                  (responseProducts.price ?? 0) *
                                  cubit.quantity;

                              return FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '\$${total.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      flex: 2,
                      child: CustomButton(
                        buttonText: 'Add to Cart',
                        onPressed: () {
                          cubit.addToCart(
                            context: context,
                            requestCart: Cart(
                              id: responseProducts.id,
                              name: responseProducts.name,
                              price: responseProducts.price,
                              quantity: cubit.quantity,
                              images: responseProducts.images,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _QuantityControlButton extends StatelessWidget {
  const _QuantityControlButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 36,
          height: 36,
          child: Icon(icon, size: 19, color: AppColors.primaryColor),
        ),
      ),
    );
  }
}
