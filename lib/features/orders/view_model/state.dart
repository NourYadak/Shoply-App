abstract class OrdersState {}

class OrdersInitState extends OrdersState {}

class OrdersLoadingState extends OrdersState {}

class OrdersSuccessState extends OrdersState {}

class OrdersErrorState extends OrdersState {
  final String errorMessage;
  OrdersErrorState({required this.errorMessage});
}

class OrdersFilterChangedState extends OrdersState {}
