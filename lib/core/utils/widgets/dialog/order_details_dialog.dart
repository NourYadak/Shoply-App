import 'package:flutter/material.dart';
import 'package:shoply_app/core/utils/theme/app_colors.dart';
import 'package:shoply_app/core/utils/widgets/responsive/responsive.dart';

class OrderDetailsDialog extends StatelessWidget {
  const OrderDetailsDialog({required this.order});

  final dynamic order;

  @override
  Widget build(BuildContext context) {
    final cart = order.cart;

    Color statusColor;
    if (order.status == 'approved') {
      statusColor = Colors.green;
    } else if (order.status == 'pending') {
      statusColor = Colors.orange;
    } else {
      statusColor = Colors.blue;
    }

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 380),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Order Details',
                      style: TextStyle(
                        fontSize: Responsive.font(19),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const Divider(height: 24),

              _detailRow('Order ID', order.id?.toString() ?? 'N/A'),
              _detailRow(
                'Status',
                order.status?.toString().toUpperCase() ?? 'PENDING',
                valueColor: statusColor,
              ),
              _detailRow(
                'Total',
                '\$${(order.subTotal ?? 0).toStringAsFixed(2)}',
                valueColor: Colors.green.shade800,
              ),

              const SizedBox(height: 18),
              const Text(
                'Products',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              if (cart != null && cart.isNotEmpty)
                ...cart.map<Widget>((product) {
                  final quantity = product.quantity ?? 1;
                  final price = product.price ?? 0;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.shopping_bag_outlined, size: 28),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                maxLines: 1,
                                product.name ?? 'Product',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    'Quantity: $quantity',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'quickSand',
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(width: 70),
                                  Text(
                                    '\$${(price * quantity).toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Text(
                                '\$${price.toStringAsFixed(2)}  each',
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                })
              else
                const Text('No products available.'),

              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Close'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: Responsive.font(15),
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: Responsive.font(16),
                fontWeight: FontWeight.w700,
                color: valueColor ?? Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
