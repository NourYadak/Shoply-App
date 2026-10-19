
part of '../product_details_screen.dart';

class _ProductDetailsFooter extends StatelessWidget {
  const _ProductDetailsFooter({
    required this.responseProducts,
  });

  final ResponseProducts responseProducts;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductDetailsCubit>();
    final isTablet = Responsive.isTablet(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: Responsive.width(16),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.width(10),
          ),
          height: Responsive.height(52),
          width: Responsive.width(isTablet ? 220 : 190),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade300,
              width: 1,
            ),
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(
              Responsive.radius(16),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: IconButton(
                  onPressed: cubit.decrementQuantity,
                  icon: const Icon(Icons.remove),
                  iconSize: Responsive.width(25),
                  padding: EdgeInsets.zero,
                ),
              ),
              VerticalDivider(
                color: Colors.grey.shade300,
                width: Responsive.width(1),
              ),
              Expanded(
                child: Center(
                  child: BlocBuilder<
                      ProductDetailsCubit,
                      ProductDetailsState>(
                    buildWhen: (previous, current) =>
                        current is ProductDetailsChangeQuantityState,
                    builder: (context, state) {
                      return Text(
                        cubit.quantity.toString(),
                        style: TextStyle(
                          fontSize: Responsive.font(19),
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      );
                    },
                  ),
                ),
              ),
              VerticalDivider(
                color: Colors.grey.shade300,
                width: Responsive.width(1),
              ),
              Expanded(
                child: IconButton(
                  onPressed: cubit.incrementQuantity,
                  icon: const Icon(Icons.add),
                  iconSize: Responsive.width(25),
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: Responsive.height(28)),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.width(16),
          ),
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
    );
  }
}
