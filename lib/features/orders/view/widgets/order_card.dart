part of '../orders_screen.dart';

class _OrderCard extends StatelessWidget {
  final dynamic order; // استبدلها بـ ProductsOrder
  const _OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    // تحديد لون وحالة البادج بناءً على الـ status
    Color badgeColor;
    Color textColor;
    if (order.status == 'approved') {
      badgeColor = Colors.green.shade100;
      textColor = Colors.green.shade800;
    } else if (order.status == 'pending') {
      badgeColor = Colors.amber.shade100;
      textColor = Colors.amber.shade900;
    } else {
      badgeColor = Colors.blue.shade100;
      textColor = Colors.blue.shade800;
    }

    return Container(
      padding: EdgeInsets.all(Responsive.width(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order #${order.id?.substring(0, 5) ?? '1024'}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Responsive.font(16),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.width(12),
                  vertical: Responsive.height(4),
                ),
                decoration: BoxDecoration(
                  color: badgeColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  order.status?.toUpperCase() ?? 'PENDING',
                  style: TextStyle(
                    color: textColor,
                    fontSize: Responsive.font(12),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: Responsive.height(8)),
          Text(
            'Date: Oct 15, 2026',
            style: TextStyle(color: Colors.grey, fontSize: Responsive.font(12)),
          ),
          Divider(height: Responsive.height(16)),

          Row(
            children: [
              Container(
                width: Responsive.width(50),
                height: Responsive.height(50),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.shopping_bag_outlined),
              ),
              SizedBox(width: Responsive.width(12)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.cart != null && order.cart!.isNotEmpty
                        ? (order.cart![0].name ?? 'Product')
                        : 'Product Name',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Responsive.font(14),
                    ),
                  ),
                  SizedBox(height: Responsive.height(4)),
                  Text(
                    '\$${order.subTotal?.toStringAsFixed(2) ?? '0.0'}',
                    style: TextStyle(
                      color: Colors.green.shade800,
                      fontWeight: FontWeight.bold,
                      fontSize: Responsive.font(14),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: Responsive.height(16)),
          SizedBox(
            width: double.infinity,
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (dialogContext) {
                      return OrderDetailsDialog(order: order);
                    },
                  );
                },
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('View Details'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
