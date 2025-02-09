class OrderHistoryDetailResponse {
  final String message;
  final OrderHistoryDetailData data;

  OrderHistoryDetailResponse({
    required this.message,
    required this.data,
  });

  factory OrderHistoryDetailResponse.fromJson(Map<String, dynamic> json) {
    return OrderHistoryDetailResponse(
      message: json['message'],
      data: OrderHistoryDetailData.fromJson(json['data']),
    );
  }
}

class OrderHistoryDetailData {
  final List<OrderItem> orderItems;

  OrderHistoryDetailData({required this.orderItems});

  factory OrderHistoryDetailData.fromJson(Map<String, dynamic> json) {
    return OrderHistoryDetailData(
      orderItems: (json['order_items'] as List)
          .map((item) => OrderItem.fromJson(item))
          .toList(),
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
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      sku: json['sku'],
      image: json['image'],
      quantity: json['quantity'],
      price: json['price'].toDouble(),
      salePrice: json['sale_price'].toDouble(),
      discount: json['discount'].toDouble(),
      total: json['total'].toDouble(),
      orderId: json['order_id'],
      productId: json['product_id'],
    );
  }
}