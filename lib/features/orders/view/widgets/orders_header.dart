part of '../orders_screen.dart';

class _OrdersHeader extends StatelessWidget {
  const _OrdersHeader();

  @override
  Widget build(BuildContext context) {
    final tabs = ['All', 'Active', 'Completed'];

    return SizedBox(
      height: Responsive.height(40),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        separatorBuilder: (context, index) =>
            SizedBox(width: Responsive.width(12)),
        itemBuilder: (context, index) {
          return BlocBuilder<OrdersCubit, OrdersState>(
            builder: (context, state) {
              final tab = tabs[index];
              final cubit = context.read<OrdersCubit>();

              return GestureDetector(
                onTap: () => cubit.filterOrders(tab),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.width(24),
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: cubit.currentFilter == tab
                        ? Colors.green.shade800
                        : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    tab,
                    style: TextStyle(
                      color: cubit.currentFilter == tab
                          ? Colors.white
                          : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: Responsive.font(14),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
