import 'package:biotech_maali/src/payment_and_order/order_history.dart/model.dart/order_history_model.dart';
import 'package:biotech_maali/src/payment_and_order/order_history.dart/order_history_provider.dart';
import 'package:biotech_maali/src/payment_and_order/order_history_detail/order_history_detail_screen.dart';

import '../../../import.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrderHistoryProvider>().fetchOrderHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
      ),
      body: Consumer<OrderHistoryProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(child: Text(provider.error!));
          }

          final orders = provider.orderHistory?.data.orders ?? [];
          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return OrderHistoryCard(order: order);
            },
          );
        },
      ),
    );
  }
}

class OrderHistoryCard extends StatelessWidget {
  final OrderHistory order;

  const OrderHistoryCard({required this.order, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderHistoryDetailScreen(
                orderId: order.id,
                orderNumber: order.orderId,
                orderDate: order.date,
                grandTotal: order.grandTotal,
                paymentMethod: order.paymentMethod,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order #${order.orderId}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    order.status,
                    style: TextStyle(
                      color: order.status == 'Paid' ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text('Ordered on: ${order.date}'),
              Text('Total Amount: ₹${order.grandTotal}'),
              Text('Payment: ${order.paymentMethod ?? "Not defined"}'),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(
                    label: Text(order.deliveryStatus),
                    backgroundColor: Colors.blue[100],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.location_on),
                        onPressed: () {
                          // TODO: Implement order tracking
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.file_download),
                        onPressed: () {
                          // TODO: Implement invoice download
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
