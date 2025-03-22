import 'package:biotech_maali/core/network/app_base_url.dart';
import 'package:biotech_maali/src/payment_and_order/order_history/model.dart/order_history_model.dart';
import 'package:biotech_maali/src/payment_and_order/order_history_detail/order_history_detail_shimmer.dart';
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
  final DeliveryAddress? deliveryAddress;
  final String customerName;
  final double totalPrice;
  final double totalDiscount;
  final String deliveryOption;

  const OrderHistoryDetailScreen({
    required this.orderId,
    required this.orderNumber,
    required this.orderDate,
    required this.grandTotal,
    this.paymentMethod,
    this.deliveryAddress,
    required this.customerName,
    required this.totalPrice,
    required this.totalDiscount,
    required this.deliveryOption,
    super.key,
  });

  @override
  State<OrderHistoryDetailScreen> createState() =>
      _OrderHistoryDetailScreenState();
}

class _OrderHistoryDetailScreenState extends State<OrderHistoryDetailScreen> {
  final Color borderColor = Colors.grey;

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
        title: Text('Order #${widget.orderNumber}',
            style: const TextStyle(fontWeight: FontWeight.bold)),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.file_download),
        //     onPressed: () {},
        //   ),
        // ],
      ),
      body: Consumer<OrderHistoryDetailProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: OrderHistoryDetailShimmer());
          }
          if (provider.error != null) {
            return Center(
                child: Text(provider.error!,
                    style: const TextStyle(color: Colors.red)));
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCard('Order Summary', _buildOrderSummaryContent()),
                _buildCard(
                    'Shipping Information', _buildShippingInformationContent()),
                _buildCard('Order Items', _buildOrderItemsList(provider)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCard(String title, Widget child) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
        side: BorderSide(color: borderColor, width: 1.5),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummaryContent() {
    return Column(
      children: [
        _buildInfoRow('Order Number', widget.orderNumber),
        _buildInfoRow('Order Date', widget.orderDate),
        _buildInfoRow('Payment Method', widget.paymentMethod ?? 'Not defined'),
        _buildInfoRow('Delivery Option', widget.deliveryOption),
        const Divider(),
        _buildInfoRow('Total Price', '₹${widget.totalPrice}'),
        _buildInfoRow('Discount', '- ₹${widget.totalDiscount}',
            valueColor: Colors.green),
        _buildInfoRow('Grand Total', '₹${widget.grandTotal}', isBold: true),
      ],
    );
  }

  Widget _buildShippingInformationContent() {
    return Column(
      children: [
        _buildInfoRow('Customer Name', widget.customerName),
        if (widget.deliveryAddress != null) ...[
          const Divider(),
          _buildInfoRow('Address', widget.deliveryAddress!.address),
          _buildInfoRow('City', widget.deliveryAddress!.city),
          _buildInfoRow('State', widget.deliveryAddress!.state),
          _buildInfoRow('Pincode', widget.deliveryAddress!.pincode.toString()),
        ] else
          const Center(
              child: Text('Delivery address not available',
                  style: TextStyle(
                      color: Colors.grey, fontStyle: FontStyle.italic))),
      ],
    );
  }

  Widget _buildOrderItemsList(OrderHistoryDetailProvider provider) {
    final orderItems = provider.orderDetails?.data.orderItems ?? [];
    return Column(
      children: orderItems.map((item) => _buildOrderItemCard(item)).toList(),
    );
  }

  Widget _buildOrderItemCard(OrderItem item) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
        side: BorderSide(color: borderColor, width: 1.5),
      ),
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                '${BaseUrl.baseUrlForImages}${item.image}',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 80,
                  height: 80,
                  color: Colors.grey[300],
                  child: const Icon(Icons.image_not_supported),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('SKU: ${item.sku}',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text('Quantity: ${item.quantity}'),
                  Text('Price: ₹${item.price}'),
                  if (item.discount > 0)
                    Text('Discount: ₹${item.discount}',
                        style: const TextStyle(color: Colors.green)),
                  const SizedBox(height: 4),
                  Text('Total: ₹${item.total}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value,
      {bool isBold = false, Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value,
              style: TextStyle(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                  color: valueColor)),
        ],
      ),
    );
  }
}
