part of '../orders_screen.dart';

class _OrdersBody extends StatelessWidget {
  const _OrdersBody();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OrdersCubit>();

    return ListView.separated(
      itemCount: cubit.filteredOrders.length,
      separatorBuilder: (context, index) => SizedBox(height: Responsive.height(12)),
      itemBuilder: (context, index) {
        return _OrderCard(order: cubit.filteredOrders[index]);
      },
    );
  }
}