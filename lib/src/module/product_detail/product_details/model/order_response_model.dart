class OrderResponseModel {
  final String message;
  final OrderData data;

  OrderResponseModel({
    required this.message,
    required this.data,
  });

  factory OrderResponseModel.fromJson(Map<String, dynamic> json) {
    return OrderResponseModel(
      message: json['message'] ?? '',
      data: OrderData.fromJson(json['data'] ?? {}),
    );
  }
}

class OrderData {
  final OrderDetails order;
  final List<OrderItem> orderItems;

  OrderData({
    required this.order,
    required this.orderItems,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      order: OrderDetails.fromJson(json['order'] ?? {}),
      orderItems: (json['order_items'] as List? ?? [])
          .map((item) => OrderItem.fromJson(item))
          .toList(),
    );
  }
}

class OrderDetails {
  final int id;
  final String orderId;
  final String date;
  final String customerName;
  final double totalPrice;
  final double totalDiscount;
  final double grandTotal;
  final String email;
  final String mobile;
  final String? address;
  final String trackingId;
  final String paymentMethod;
  final String deliveryOption;
  final String status;
  final int customerId;

  OrderDetails({
    required this.id,
    required this.orderId,
    required this.date,
    required this.customerName,
    required this.totalPrice,
    required this.totalDiscount,
    required this.grandTotal,
    required this.email,
    required this.mobile,
    this.address,
    required this.trackingId,
    required this.paymentMethod,
    required this.deliveryOption,
    required this.status,
    required this.customerId,
  });

  factory OrderDetails.fromJson(Map<String, dynamic> json) {
    return OrderDetails(
      id: json['id'] ?? 0,
      orderId: json['order_id'] ?? '',
      date: json['date'] ?? '',
      customerName: json['customer_name'] ?? '',
      totalPrice: (json['total_price'] ?? 0.0).toDouble(),
      totalDiscount: (json['total_discount'] ?? 0.0).toDouble(),
      grandTotal: (json['grand_total'] ?? 0.0).toDouble(),
      email: json['email'] ?? '',
      mobile: json['mobile'] ?? '',
      address: json['address'],
      trackingId: json['tracking_id']?.toString() ?? '0',
      paymentMethod: json['payment_method'] ?? 'Not defined',
      deliveryOption: json['delivery_option'] ?? 'Standard',
      status: json['status'] ?? 'Initiated',
      customerId: json['customer_id'] ?? 0,
    );
  }
}

class OrderItem {
  final int id;
  final String sku;
  final String image;
  final int quantity;
  final double price;
  final double salePrice;
  final double discount;
  final double total;
  final int orderId;
  final int productId;
  final String productName;

  OrderItem({
    required this.id,
    required this.sku,
    required this.image,
    required this.quantity,
    required this.price,
    required this.salePrice,
    required this.discount,
    required this.total,
    required this.orderId,
    required this.productId,
    required this.productName,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'] ?? 0,
      sku: json['sku'] ?? '',
      image: json['image'] ?? '',
      quantity: json['quantity'] ?? 0,
      price: (json['price'] ?? 0.0).toDouble(),
      salePrice: (json['sale_price'] ?? 0.0).toDouble(),
      discount: (json['discount'] ?? 0.0).toDouble(),
      total: (json['total'] ?? 0.0).toDouble(),
      orderId: json['order_id'] ?? 0,
      productId: json['product_id'] ?? 0,
      productName: json['product_name'] ?? '',
    );
  }
}
