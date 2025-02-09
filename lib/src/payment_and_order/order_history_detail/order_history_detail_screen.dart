import 'package:biotech_maali/core/network/app_base_url.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'order_history_detail_provider.dart';
import 'model/order_history_detail_model.dart';

class OrderHistoryDetailScreen extends StatefulWidget {
  final int orderId;
  final String orderNumber;
  final String orderDate;
  final double grandTotal;
  final String? paymentMethod;

  const OrderHistoryDetailScreen({
    required this.orderId,
    required this.orderNumber,
    required this.orderDate,
    required this.grandTotal,
    this.paymentMethod,
    super.key,
  });

  @override
  State<OrderHistoryDetailScreen> createState() =>
      _OrderHistoryDetailScreenState();
}

class _OrderHistoryDetailScreenState extends State<OrderHistoryDetailScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<OrderHistoryDetailProvider>()
        .fetchOrderDetails(widget.orderId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order #${widget.orderNumber}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.file_download),
            onPressed: () {
              // TODO: Implement invoice download
            },
          ),
        ],
      ),
      body: Consumer<OrderHistoryDetailProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(child: Text(provider.error!));
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildOrderSummaryCard(),
                _buildShippingInformationCard(),
                _buildOrderItemsList(provider),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildOrderSummaryCard() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildInfoRow('Order Date', widget.orderDate),
            _buildInfoRow(
                'Payment Method', widget.paymentMethod ?? 'Not defined'),
            _buildInfoRow('Order Status', 'Processing'),
            const Divider(),
            _buildInfoRow('Total Amount', '₹${widget.grandTotal}',
                isBold: true),
          ],
        ),
      ),
    );
  }

  Widget _buildShippingInformationCard() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Shipping Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildInfoRow('Name', 'John Doe'),
            _buildInfoRow('Address', '123 Main St, City, State'),
            _buildInfoRow('Phone', '+1234567890'),
            const Divider(),
            _buildInfoRow('Delivery Status', 'Out for Delivery'),
            _buildInfoRow('Expected Delivery', '2-3 Business Days'),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItemsList(OrderHistoryDetailProvider provider) {
    final orderItems = provider.orderDetails?.data.orderItems ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Order Items',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: orderItems.length,
          itemBuilder: (context, index) {
            return _buildOrderItemCard(orderItems[index]);
          },
        ),
      ],
    );
  }

  Widget _buildOrderItemCard(OrderItem item) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                '${BaseUrl.baseUrlForImages}${item.image}',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image_not_supported),
                  );
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SKU: ${item.sku}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text('Quantity: ${item.quantity}'),
                  Text('Price: ₹${item.price}'),
                  if (item.discount > 0)
                    Text(
                      'Discount: ₹${item.discount}',
                      style: const TextStyle(color: Colors.green),
                    ),
                  const SizedBox(height: 8),
                  Text(
                    'Total: ₹${item.total}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
