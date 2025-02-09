class OrderHistoryResponse {
  final String message;
  final OrderHistoryData data;

  OrderHistoryResponse({
    required this.message,
    required this.data,
  });

  factory OrderHistoryResponse.fromJson(Map<String, dynamic> json) {
    return OrderHistoryResponse(
      message: json['message'],
      data: OrderHistoryData.fromJson(json['data']),
    );
  }
}

class OrderHistoryData {
  final List<OrderHistory> orders;

  OrderHistoryData({required this.orders});

  factory OrderHistoryData.fromJson(Map<String, dynamic> json) {
    return OrderHistoryData(
      orders: (json['orders'] as List)
          .map((item) => OrderHistory.fromJson(item))
          .toList(),
    );
  }
}

class OrderHistory {
  final int id;
  final String orderId;
  final String date;
  final double grandTotal;
  final String? paymentMethod;
  // Additional fields with dummy data
  final String status;
  final String deliveryStatus;
  final String customerName;
  final String shippingAddress;
  final String? courierPartner;
  final String? trackingNumber;
  final String estimatedDelivery;
  final double? discount;
  final double? tax;
  final double? shippingCharge;

  OrderHistory({
    required this.id,
    required this.orderId,
    required this.date,
    required this.grandTotal,
    this.paymentMethod,
    this.status = 'Paid', // Default value
    this.deliveryStatus = 'Processing',
    this.customerName = 'John Doe',
    this.shippingAddress = 'Default Address',
    this.courierPartner,
    this.trackingNumber,
    this.estimatedDelivery = '2-3 Business Days',
    this.discount = 0.0,
    this.tax = 0.0,
    this.shippingCharge = 0.0,
  });

  factory OrderHistory.fromJson(Map<String, dynamic> json) {
    return OrderHistory(
      id: json['id'],
      orderId: json['order_id'],
      date: json['date'],
      grandTotal: json['grand_total'].toDouble(),
      paymentMethod: json['payment_method'],
    );
  }
}