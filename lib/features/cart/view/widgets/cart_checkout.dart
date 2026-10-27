part of '../cart_screen.dart';

class _CartCheckout extends StatelessWidget {
  const _CartCheckout();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CartCubit>();
    final isTablet = Responsive.isTablet(context);

    return DraggableScrollableSheet(
      initialChildSize: isTablet ? 0.22 : 0.25,
      minChildSize: isTablet ? 0.18 : 0.2,
      maxChildSize: isTablet ? 0.40 : 0.48,
      builder: (context, scrollController) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.width(isTablet ? 28 : 16),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(Responsive.radius(28)),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: Responsive.width(10),
                spreadRadius: 2,
                offset: const Offset(0, -1),
              ),
            ],
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: Responsive.height(14)),
                Center(
                  child: Container(
                    height: Responsive.height(5),
                    width: Responsive.width(45),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(
                        Responsive.radius(20),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Responsive.height(22)),
                Row(
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(
                        fontSize: Responsive.font(isTablet ? 24 : 20),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(width: 130),
                    Flexible(
                      child: BlocBuilder<CartCubit, CartState>(
                        buildWhen: (previous, current) =>
                            current is CartUpdateQuantitySuccessState ||
                            current is CartSuccessState ||
                            current is CartDeleteProductSuccessState ||
                            current is CartCheckoutSuccessState,
                        builder: (context, state) {
                          return Text(
                            '\$ ${context.read<CartCubit>().subTotal.toStringAsFixed(2)}',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontSize: Responsive.font(isTablet ? 24 : 20),
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Responsive.height(isTablet ? 28 : 24)),
                CustomButton(
                  buttonText: 'Checkout',
                  onPressed: () {
                    cubit.checkOut(context: context);
                  },
                ),
                SizedBox(height: Responsive.height(12)),
              ],
            ),
          ),
        );
      },
    );
  }
}
