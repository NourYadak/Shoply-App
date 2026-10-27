import 'package:shoply_app/core/model/cart/cart.dart';

class ProductsOrder {
  String? id;
  final String? userUid;
  final String? fullName;
  final String? address;
  final double? subTotal;
  final String? status;
  final List<Cart>? cart;

  ProductsOrder({
    this.id,
    required this.userUid,
    required this.fullName,
    required this.address,
    required this.subTotal,
    required this.cart,
    required this.status,
  });
  factory ProductsOrder.fromJson(Map<String, dynamic> json) {
    return ProductsOrder(
      id: json['id'],
      userUid: json['userUid'],
      fullName: json['fullName'],
      address: json['address'],
      subTotal: (json['subTotal'] as num?)?.toDouble(),
      status: json['status'],
      cart: json['cart'] != null
          ? (json['cart'] as List).map((item) => Cart.fromJson(item)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userUid': userUid,
      'fullName': fullName,
      'address': address,
      'subTotal': subTotal,
      'status': status,
      'cart': cart?.map((cart) => cart.toJson()).toList(),
    };
  }
}
