import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/utils/widgets/empty_screen/empty_screen.dart';
import 'package:shoply_app/core/utils/widgets/loading/custom_loading_data.dart';
import 'package:shoply_app/core/utils/widgets/refresh_indicator/custom_refresh_indicator.dart';
import 'package:shoply_app/core/utils/widgets/responsive/responsive.dart';
import 'package:shoply_app/features/orders/view_model/cubit.dart';
import 'package:shoply_app/features/orders/view_model/state.dart';
import 'package:shoply_app/core/utils/widgets/dialog/order_details_dialog.dart';

part 'widgets/orders_header.dart';
part 'widgets/orders_body.dart';
part 'widgets/order_card.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);

    return BlocProvider(
      create: (context) => OrdersCubit()..getOrders(),
      child: Scaffold(
        appBar: AppBar(title: const Text('My Orders'), centerTitle: true),
        body: BlocBuilder<OrdersCubit, OrdersState>(
          builder: (context, state) {
            final cubit = context.read<OrdersCubit>();

            if (state is OrdersLoadingState) {
              return const CustomLoadingData();
            } else if (state is OrdersErrorState) {
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
                await cubit.refreshOrders();
              },
              child: Padding(
                padding: EdgeInsets.all(Responsive.width(16)),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: isTablet ? 1000 : double.infinity,
                    ),
                    child: Column(
                      children: [
                        const _OrdersHeader(),
                        SizedBox(height: Responsive.height(16)),
                        Expanded(
                          child: cubit.filteredOrders.isEmpty
                              ? const EmptyScreen(emptyText: 'No orders found!')
                              : const _OrdersBody(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
