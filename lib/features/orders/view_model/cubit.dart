import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/model/order/products_order.dart';
import 'package:shoply_app/features/orders/repo/orders_repo.dart';
import 'package:shoply_app/features/orders/view_model/state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersInitState());

  final _ordersRepo = OrdersRepo();
  List<ProductsOrder> allOrders = [];
  List<ProductsOrder> filteredOrders = [];
  String currentFilter = 'All'; // All, Active, Completed

  Future<void> getOrders() async {
    emit(OrdersLoadingState());
    final result = await _ordersRepo.getOrders();
    result.fold(
      (errorMessage) => emit(OrdersErrorState(errorMessage: errorMessage)),
      (orders) {
        allOrders = orders;
        filterOrders(currentFilter);
        emit(OrdersSuccessState());
      },
    );
  }

  void filterOrders(String status) {
    currentFilter = status;
    if (status == 'All') {
      filteredOrders = allOrders;
    } else if (status == 'Active') {
      // تعديل الحالات النشطة حسب النظام لديك (مثل pending, approved)
      filteredOrders = allOrders
          .where(
            (order) => order.status == 'pending' || order.status == 'approved',
          )
          .toList();
    } else if (status == 'Completed') {
      filteredOrders = allOrders
          .where(
            (order) =>
                order.status == 'delivered' || order.status == 'completed',
          )
          .toList();
    }
    emit(OrdersFilterChangedState());
  }

  Future<void> refreshOrders() async {
    await getOrders();
  }
}
