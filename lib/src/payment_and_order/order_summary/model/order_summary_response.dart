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
  final OrderSummaryDetails orders;

  OrderSummaryData({required this.orders});

  factory OrderSummaryData.fromJson(Map<String, dynamic> json) {
    return OrderSummaryData(
      orders: OrderSummaryDetails.fromJson(json['orders'] ?? {}),
    );
  }
}

class OrderSummaryDetails {
  final int id;
  final double totalPrice;
  final double totalDiscount;
  final double grandTotal;

  OrderSummaryDetails({
    required this.id,
    required this.totalPrice,
    required this.totalDiscount,
    required this.grandTotal,
  });

  factory OrderSummaryDetails.fromJson(Map<String, dynamic> json) {
    return OrderSummaryDetails(
      id: json['id'] ?? 0,
      totalPrice: (json['total_price'] ?? 0.0).toDouble(),
      totalDiscount: (json['total_discount'] ?? 0.0).toDouble(),
      grandTotal: (json['grand_total'] ?? 0.0).toDouble(),
    );
  }
}