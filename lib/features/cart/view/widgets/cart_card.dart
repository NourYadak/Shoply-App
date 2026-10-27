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
            width: Responsive.width(isTablet ? 400 : 380),
            padding: EdgeInsets.symmetric(
              vertical: Responsive.height(10),
              horizontal: Responsive.width(10),
            ),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(Responsive.radius(20)),
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
                      BlocBuilder<CartCubit, CartState>(
                        buildWhen: (previous, current) =>
                            current is CartUpdateQuantitySuccessState,
                        builder: (context, state) {
                          return Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _CartQuantityButton(
                                  icon: Icons.remove_rounded,
                                  onTap: () {
                                    cubit.decrementQuantity(index: index);
                                  },
                                ),
                                SizedBox(
                                  width: Responsive.width(44),
                                  child: Center(
                                    child: Text(
                                      '${cubit.responseCart[index].quantity ?? 1}',
                                      style: TextStyle(
                                        fontSize: Responsive.font(17),
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                _CartQuantityButton(
                                  icon: Icons.add_rounded,
                                  onTap: () {
                                    cubit.incrementQuantity(index: index);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
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

class _CartQuantityButton extends StatelessWidget {
  const _CartQuantityButton({required this.icon, required this.onTap});

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
          width: Responsive.width(30),
          height: Responsive.height(36),
          child: Icon(
            icon,
            size: Responsive.width(19),
            color: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
