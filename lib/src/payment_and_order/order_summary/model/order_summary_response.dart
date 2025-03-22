class OrderSummaryResponse {
  final String message;
  final OrderSummaryData data;

  OrderSummaryResponse({
    required this.message,
    required this.data,
  });

  factory OrderSummaryResponse.fromJson(Map<String, dynamic> json) {
    return OrderSummaryResponse(
      message: json['message'] ?? '',
      data: OrderSummaryData.fromJson(json['data'] ?? {}),
    );
  }
}

class OrderSummaryData {
  final OrderSummaryDetails order;
  final List<OrderItem> orderItems;

  OrderSummaryData({
    required this.order,
    required this.orderItems,
  });

  factory OrderSummaryData.fromJson(Map<String, dynamic> json) {
    return OrderSummaryData(
      order: OrderSummaryDetails.fromJson(json['order'] ?? {}),
      orderItems: (json['order_items'] as List?)
              ?.map((item) => OrderItem.fromJson(item))
              .toList() ??
          [],
    );
  }
}

class OrderSummaryDetails {
  final int id;
  final String orderId;
  final String customerName;
  final double totalPrice;
  final double totalDiscount;
  final double grandTotal;
  final String email;
  final String mobile;
  final String? trackingId;
  final String deliveryOption;
  final String status;
  final String? razorpayOrderId;
  final double couponDiscount;

  OrderSummaryDetails({
    required this.id,
    required this.orderId,
    required this.customerName,
    required this.totalPrice,
    required this.totalDiscount,
    required this.grandTotal,
    required this.email,
    required this.mobile,
    this.trackingId,
    required this.deliveryOption,
    required this.status,
    this.razorpayOrderId,
    required this.couponDiscount,
  });

  factory OrderSummaryDetails.fromJson(Map<String, dynamic> json) {
    return OrderSummaryDetails(
      id: json["id"] ?? 0,
      orderId: json['order_id'] ?? '',
      customerName: json['customer_name'] ?? '',
      totalPrice: (json['total_price'] ?? 0.0).toDouble(),
      totalDiscount: (json['total_discount'] ?? 0.0).toDouble(),
      grandTotal: (json['grand_total'] ?? 0.0).toDouble(),
      email: json['email'] ?? '',
      mobile: json['mobile'] ?? '',
      trackingId: json['tracking_id'],
      deliveryOption: json['delivery_option'] ?? '',
      status: json['status'] ?? '',
      razorpayOrderId: json['razorpay_order_id'],
      couponDiscount: (json['coupon_discount'] ?? 0.0).toDouble(),
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
  final String? hsnCode;
  final int orderId;
  final int productId;
  final String? comboOffer;
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
    this.hsnCode,
    required this.orderId,
    required this.productId,
    this.comboOffer,
    required this.productName,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'] ?? 0,
      sku: (json['sku'] ?? 0).toString(), // Convert int to String
      image: json['image'] ?? '',
      quantity: json['quantity'] ?? 0,
      price: (json['price'] ?? 0.0).toDouble(),
      salePrice: (json['sale_price'] ?? 0.0).toDouble(),
      discount: (json['discount'] ?? 0.0).toDouble(),
      total: (json['total'] ?? 0.0).toDouble(),
      hsnCode: json['hsn_code'],
      orderId: json['order_id'] ?? 0,
      productId: json['product_id'] ?? 0,
      comboOffer:
          (json['combo_offer'] ?? '').toString(), // Convert int to String
      productName: json['product_name'] ?? '',
    );
  }
}
