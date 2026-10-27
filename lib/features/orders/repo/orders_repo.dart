import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:shoply_app/core/local/local_storage_user.dart';
import 'package:shoply_app/core/model/order/products_order.dart';

class OrdersRepo {
  Future<Either<String, List<ProductsOrder>>> getOrders() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('Order') 
          .where('userUid', isEqualTo: LocalStorageUser.instance.uid)
          .get();

      final List<ProductsOrder> orders = [];
      for (var doc in snapshot.docs) {
        final data = doc.data();
        data['id'] = doc.id;
        orders.add(ProductsOrder.fromJson(data)); 
      }

      return Right(orders);
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'An error occurred');
    }
  }
}