import 'package:biotech_maali/src/payment_and_order/order_history/model.dart/order_history_model.dart';
import 'package:biotech_maali/src/payment_and_order/order_history/order_history_provider.dart';
import 'package:biotech_maali/src/payment_and_order/order_history/order_history_shimmer.dart';
import 'package:biotech_maali/src/payment_and_order/order_history/widgets/invoice_download_popup.dart';
import 'package:biotech_maali/src/payment_and_order/order_history_detail/order_history_detail_provider.dart';
import 'package:biotech_maali/src/payment_and_order/order_history_detail/order_history_detail_screen.dart';
import 'package:biotech_maali/src/payment_and_order/order_tracking/order_tracking_screen.dart';
import 'package:biotech_maali/src/pdf_viewer/pdf_viewer.dart';

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
  final Color borderColor = const Color.fromARGB(255, 49, 42, 42);

  const OrderHistoryCard({required this.order, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: borderColor),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => _navigateToDetails(context),
        child: Column(
          children: [
            _buildHeader(),
            const Divider(height: 1),
            _buildBody(),
            const Divider(height: 1),
            _buildFooter(context, order),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order #${order.orderId}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Placed on ${_formatDate(order.date)}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          _buildStatusChip(order.status),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      padding: const EdgeInsets.all(12),
      color: Colors.grey[50],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total Amount',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '₹${order.grandTotal}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Payment Method',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    order.paymentMethod ?? 'Not defined',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Delivery Option: ${order.deliveryOption}',
                style: const TextStyle(fontSize: 13),
              ),
              Text(
                'Discount: ₹${order.totalDiscount.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context, OrderHistory order) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.person_outline, size: 16, color: Colors.grey),
              const SizedBox(width: 4),
              Text(
                order.customerName,
                style: const TextStyle(fontSize: 13),
              ),
            ],
          ),
          Row(
            children: [
              if (order.status.toLowerCase() != 'cancelled' &&
                  order.status.toLowerCase() != 'delivered') ...[
                OutlinedButton(
                  onPressed: () =>
                      _showCancelConfirmation(context, order.orderId),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                    minimumSize: const Size(0, 32),
                  ),
                  child: const Text(
                    'Cancel Order',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
                const SizedBox(width: 8),
              ],
              if (order.trackingId != "0") ...[
                OutlinedButton.icon(
                  onPressed: () async {
                    final orderHistoryProvider =
                        context.read<OrderHistoryDetailProvider>();
                    await orderHistoryProvider.fetchOrderDetails(order.id);

                    // Convert the tracking updates to the correct type
                    final trackingUpdates = (orderHistoryProvider
                                .orderDetails?.data.trackingUpdates ??
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
                        builder: (context) => DeliveryTrackingWidget(
                          trackingUpdates: trackingUpdates,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.local_shipping_outlined, size: 18),
                  label: const Text(
                    'Track',
                    style: TextStyle(fontSize: 13),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.blue,
                    side: const BorderSide(color: Colors.blue),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 0,
                    ),
                    minimumSize: const Size(0, 32),
                  ),
                ),
                const SizedBox(width: 8),
              ],
              IconButton(
                icon: const Icon(Icons.file_download_outlined),
                onPressed: () {
                  if (order.status == "DELIVERED") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PdfViewerScreen(
                          pdfUrl: "${EndUrl.pdfInvoiceUrl}${order.id}/",
                          title: order.orderId,
                        ),
                      ),
                    );
                  } else {
                    InvoiceDownloadPopup.showInvoiceBottomSheet(context);
                  }
                },
                tooltip: 'Download Invoice',
                iconSize: 20,
                constraints: const BoxConstraints(
                  minWidth: 32,
                  minHeight: 32,
                ),
                padding: EdgeInsets.zero,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _showCancelConfirmation(
      BuildContext context, String orderId) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cancel Order'),
          content: const Text('Are you sure you want to cancel this order?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );

    if (result == true) {
      final success =
          await context.read<OrderHistoryProvider>().cancelOrder(orderId);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              success
                  ? 'Order cancelled successfully'
                  : 'Failed to cancel order',
            ),
            backgroundColor: success ? Colors.green : Colors.red,
          ),
        );
      }
    }
  }

  void _navigateToDetails(BuildContext context) {
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

  Widget _buildStatusChip(String status) {
    Color chipColor;
    Color textColor;
    Color backgroundColor;

    switch (status.toLowerCase()) {
      case 'initiated':
        chipColor = Colors.blue;
        textColor = Colors.blue;
        backgroundColor = Colors.blue.withOpacity(0.1);
        break;
      case 'paid':
        chipColor = Colors.green;
        textColor = Colors.green;
        backgroundColor = Colors.green.withOpacity(0.1);
        break;
      case 'cancelled':
        chipColor = Colors.red;
        textColor = Colors.red;
        backgroundColor = Colors.red.withOpacity(0.1);
        break;
      default:
        chipColor = Colors.grey;
        textColor = Colors.grey;
        backgroundColor = Colors.grey.withOpacity(0.1);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: chipColor),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
