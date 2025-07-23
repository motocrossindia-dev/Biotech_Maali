import 'package:biotech_maali/src/payment_and_order/order_history/model.dart/order_history_model.dart';
import 'package:biotech_maali/src/payment_and_order/order_history/order_history_provider.dart';
import 'package:biotech_maali/src/payment_and_order/order_history/order_history_shimmer.dart';
import 'package:biotech_maali/src/payment_and_order/order_history_detail/order_history_detail_provider.dart';
import 'package:biotech_maali/src/payment_and_order/order_history_detail/order_history_detail_screen.dart';
import 'package:biotech_maali/src/payment_and_order/order_tracking/order_tracking_screen.dart';
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
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        context.read<BottomNavProvider>().updateIndex(0);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNavWidget(),
          ),
          (route) => false,
        );
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            'My Orders',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.black87),
        ),
        body: Consumer<OrderHistoryProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(child: OrderHistoryShimmer());
            }

            if (provider.error != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline,
                        size: 48, color: Colors.grey),
                    const SizedBox(height: 16),
                    Text(
                      provider.error!,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => provider.fetchOrderHistory(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            final orders = provider.orderHistory?.data.orders ?? [];
            if (orders.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/png/images/no_order_history.jpg', // Add this image
                      height: 220,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'No orders yet',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Start shopping to see your orders here',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<BottomNavProvider>().updateIndex(0);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BottomNavWidget(),
                          ),
                        );
                      },
                      child: const Text('Start Shopping'),
                    ),
                  ],
                ),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: orders.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final order = orders[index];
                return OrderHistoryCard(order: order);
              },
            );
          },
        ),
      ),
    );
  }
}

class OrderHistoryCard extends StatelessWidget {
  final OrderHistory order;
  static const Color themeColor = Color(0xFF749F09);

  const OrderHistoryCard({required this.order, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderHistoryDetailScreen(
              orderId: order.id,
              orderNumber: order.orderId,
              orderDate: order.date,
              grandTotal: order.grandTotal,
              paymentMethod: order.paymentMethod ?? 'Not defined',
              deliveryAddress: order.deliveryAddress,
              customerName: order.customerName,
              totalPrice: order.totalPrice,
              totalDiscount: order.totalDiscount,
              deliveryOption: order.deliveryOption,
              orderStatus: order.status,
            ),
          ),
        );
      },
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Status chip and date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      '${BaseUrl.baseUrlForImages}${order.productDetails?.productImage ?? ""}', // Example image URL
                      height: 100,
                      width: 160,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey.shade200,
                        height: 60,
                        width: 60,
                        child: const Icon(Icons.image_not_supported,
                            color: Colors.grey),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            children: [
                              _buildStatusChip(order.status),
                              // Text(
                              //   _formatDate(order.date),
                              //   style: TextStyle(
                              //     color: Colors.grey.shade500,
                              //     fontSize: 10,
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Action buttons
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if (order.trackingId != "0") ...[
                            ElevatedButton.icon(
                              onPressed: () async {
                                final orderHistoryProvider =
                                    context.read<OrderHistoryDetailProvider>();
                                await orderHistoryProvider
                                    .fetchOrderDetails(order.id);

                                final trackingUpdates = (orderHistoryProvider
                                            .orderDetails
                                            ?.data
                                            .trackingUpdates ??
                                        [])
                                    .map((update) => TrackingUpdate(
                                          status: update.status,
                                          timestamp: update.timestamp,
                                          notes: update.notes,
                                        ))
                                    .toList();

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DeliveryTrackingWidget(
                                      trackingUpdates: trackingUpdates,
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.local_shipping_outlined,
                                  size: 16),
                              label: const Text('Track'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: themeColor,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 1,
                                ),
                                textStyle: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                            ),
                            const SizedBox(width: 12),
                          ],
                        ],
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

  Widget _buildStatusChip(String status) {
    Color chipColor;
    Color backgroundColor;

    switch (status.toLowerCase()) {
      case 'initiated':
        chipColor = Colors.blue;
        backgroundColor = Colors.blue.withOpacity(0.1);
        break;
      case 'paid':
        chipColor = themeColor;
        backgroundColor = themeColor.withOpacity(0.1);
        break;
      case 'cancelled':
        chipColor = Colors.red;
        backgroundColor = Colors.red.withOpacity(0.1);
        break;
      case 'delivered':
        chipColor = Colors.green;
        backgroundColor = Colors.green.withOpacity(0.1);
        break;
      default:
        chipColor = Colors.grey;
        backgroundColor = Colors.grey.withOpacity(0.1);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: chipColor, width: 1),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: chipColor,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  String _formatDate(String date) {
    final DateTime orderDate = DateTime.parse(date);
    return '${orderDate.day} ${_getMonth(orderDate.month)} ${orderDate.year}';
  }

  String _getMonth(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }
}
