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
          .map((order) => OrderHistory.fromJson(order))
          .toList(),
    );
  }
}

class OrderHistory {
  final int id;
  final String orderId;
  final String date;
  final double totalPrice;
  final double totalDiscount;
  final String trackingId;
  final double grandTotal;
  final String? paymentMethod;
  final String customerName;
  final String deliveryOption;
  final String status;
  final String? razorpayOrderId;
  final DeliveryAddress? deliveryAddress;

  OrderHistory({
    required this.id,
    required this.orderId,
    required this.date,
    required this.totalPrice,
    required this.totalDiscount,
    required this.trackingId,
    required this.grandTotal,
    this.paymentMethod,
    required this.customerName,
    required this.deliveryOption,
    required this.status,
    this.razorpayOrderId,
    this.deliveryAddress,
  });

  factory OrderHistory.fromJson(Map<String, dynamic> json) {
    return OrderHistory(
      id: json['id'],
      orderId: json['order_id'],
      date: json['date'],
      totalPrice: json['total_price'].toDouble(),
      totalDiscount: json['total_discount'].toDouble(),
      trackingId: json['tracking_id'],
      grandTotal: json['grand_total'].toDouble(),
      paymentMethod: json['payment_method'],
      customerName: json['customer_name'],
      deliveryOption: json['delivery_option'],
      status: json['status'],
      razorpayOrderId: json['razorpay_order_id'],
      deliveryAddress: json['delivery_address'] != null
          ? DeliveryAddress.fromJson(json['delivery_address'])
          : null,
    );
  }
}

class DeliveryAddress {
  final String firstName;
  final String lastName;
  final String address;
  final String state;
  final String city;
  final int pincode;
  final String addressType;

  DeliveryAddress({
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.state,
    required this.city,
    required this.pincode,
    required this.addressType,
  });

  factory DeliveryAddress.fromJson(Map<String, dynamic> json) {
    return DeliveryAddress(
      firstName: json['first_name'],
      lastName: json['last_name'],
      address: json['address'],
      state: json['state'],
      city: json['city'],
      pincode: json['pincode'],
      addressType: json['address_type'],
    );
  }
}