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
  final bool? success;
  final double? discountAmount;
  final double? newTotal;
  final String? couponCode;
  final String? redemptionMessage;

  OrderData({
    required this.order,
    required this.orderItems,
    this.success,
    this.discountAmount,
    this.newTotal,
    this.couponCode,
    this.redemptionMessage,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      order: OrderDetails.fromJson(json['order'] ?? {}),
      orderItems: (json['order_items'] as List? ?? [])
          .map((item) => OrderItem.fromJson(item))
          .toList(),
      success: json['success'],
      discountAmount: (json['discount_amount'] ?? 0.0).toDouble(),
      newTotal: (json['new_total'] ?? 0.0).toDouble(),
      couponCode: json['coupon_code'],
      redemptionMessage: json['redemption_message'],
    );
  }
}

class OrderDetails {
  final int id;
  final String orderId;
  final String date;
  final String customerName;
  final String email;
  final String mobile;
  final double totalPrice;
  final double totalDiscount;
  final double grandTotal;
  final String? trackingId;
  final String deliveryOption;
  final String? paymentMethod;
  final String status;
  final String? razorpayOrderId;
  final bool isComboPurchase;
  final bool couponApplied;
  final double couponDiscount;
  final int customerId;
  final dynamic
      appliedCoupon; // Changed to dynamic to handle both String and int

  OrderDetails({
    required this.id,
    required this.orderId,
    required this.date,
    required this.customerName,
    required this.email,
    required this.mobile,
    required this.totalPrice,
    required this.totalDiscount,
    required this.grandTotal,
    this.trackingId,
    required this.deliveryOption,
    this.paymentMethod,
    required this.status,
    this.razorpayOrderId,
    required this.isComboPurchase,
    required this.couponApplied,
    required this.couponDiscount,
    required this.customerId,
    this.appliedCoupon,
  });

  factory OrderDetails.fromJson(Map<String, dynamic> json) {
    return OrderDetails(
      id: json['id'] ?? 0,
      orderId: json['order_id'] ?? '',
      date: json['date'] ?? '',
      customerName: json['customer_name'] ?? '',
      email: json['email'] ?? '',
      mobile: json['mobile'] ?? '',
      totalPrice: (json['total_price'] ?? 0.0).toDouble(),
      totalDiscount: (json['total_discount'] ?? 0.0).toDouble(),
      grandTotal: (json['grand_total'] ?? 0.0).toDouble(),
      trackingId: json['tracking_id'],
      deliveryOption: json['delivery_option'] ?? 'Standard',
      paymentMethod: json['payment_method'],
      status: json['status'] ?? 'Initiated',
      razorpayOrderId: json['razorpay_order_id'],
      isComboPurchase: json['is_combo_purchase'] ?? false,
      couponApplied: json['coupon_applied'] ?? false,
      couponDiscount: (json['coupon_discount'] ?? 0.0).toDouble(),
      customerId: json['customer_id'] ?? 0,
      appliedCoupon: json['applied_coupon'],
    );
  }
}

class OrderItem {
  final int id;
  final dynamic sku; // Changed to dynamic to handle both int and String
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
      sku: json['sku'] ?? '',
      image: json['image'] ?? '',
      quantity: json['quantity'] ?? 0,
      price: (json['price'] ?? 0.0).toDouble(),
      salePrice: (json['sale_price'] ?? 0.0).toDouble(),
      discount: (json['discount'] ?? 0.0).toDouble(),
      total: (json['total'] ?? 0.0).toDouble(),
      hsnCode: json['hsn_code']?.toString(),
      orderId: json['order_id'] ?? 0,
      productId: json['product_id'] ?? 0,
      comboOffer: json['combo_offer']?.toString(),
      productName: json['product_name'] ?? '',
    );
  }
}
