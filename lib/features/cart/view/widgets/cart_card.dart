part of '../cart_screen.dart';

class _CartCard extends StatelessWidget {
  const _CartCard();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CartCubit>();
    final isTablet = Responsive.isTablet(context);

    return ListView.separated(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.width(isTablet ? 20 : 8),
        vertical: Responsive.height(8),
      ),
      separatorBuilder: (context, index) {
        return SizedBox(height: Responsive.height(8));
      },
      itemCount: cubit.responseCart.length,
      itemBuilder: (context, index) {
        final cartData = cubit.responseCart[index];

        return Dismissible(
          key: ValueKey(cartData.id),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            cubit.deleteProduct(productId: cartData.id ?? '', context: context);
          },
          background: Container(
            margin: EdgeInsets.symmetric(vertical: Responsive.height(8)),
            padding: EdgeInsets.symmetric(horizontal: Responsive.width(20)),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(Responsive.radius(16)),
            ),
            alignment: AlignmentDirectional.centerEnd,
            child: Icon(
              Icons.delete_outline,
              color: Colors.white,
              size: Responsive.width(30),
            ),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: Responsive.height(10),
              horizontal: Responsive.width(8),
            ),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(Responsive.radius(16)),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(Responsive.radius(15)),
                  child: SizedBox(
                    width: Responsive.width(isTablet ? 130 : 95),
                    height: Responsive.height(isTablet ? 130 : 105),
                    child: CustomCachedImageNetwork(
                      image: cartData.images?.isNotEmpty == true
                          ? cartData.images!.first
                          : '',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: Responsive.width(12)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cartData.name ?? '',
                        style: TextStyle(
                          fontSize: Responsive.font(isTablet ? 20 : 16),
                          fontWeight: FontWeight.w800,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: Responsive.height(6)),
                      Text(
                        '\$ ${cartData.price}',
                        style: TextStyle(
                          fontSize: Responsive.font(isTablet ? 22 : 18),
                          fontWeight: FontWeight.w900,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: Responsive.height(12)),
                      Container(
                        height: Responsive.height(35),
                        constraints: BoxConstraints(
                          maxWidth: Responsive.width(isTablet ? 170 : 145),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(
                            Responsive.radius(12),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  cubit.decrementQuantity(index: index);
                                },
                                icon: Icon(
                                  Icons.remove,
                                  size: Responsive.width(20),
                                ),
                              ),
                            ),
                            VerticalDivider(
                              width: 1,
                              color: Colors.grey.shade300,
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  cartData.quantity.toString(),
                                  style: TextStyle(
                                    fontSize: Responsive.font(17),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            VerticalDivider(
                              width: 1,
                              color: Colors.grey.shade300,
                            ),
                            Expanded(
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  cubit.incrementQuantity(index: index);
                                },
                                icon: Icon(
                                  Icons.add,
                                  size: Responsive.width(20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: Responsive.width(4)),
                IconButton(
                  constraints: BoxConstraints(minWidth: Responsive.width(32)),
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    cubit.deleteProduct(
                      productId: cartData.id ?? '',
                      context: context,
                    );
                  },
                  icon: Icon(
                    Icons.delete_outline,
                    size: Responsive.width(24),
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
