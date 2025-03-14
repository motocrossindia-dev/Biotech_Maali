// lib/models/coupon.dart
class Coupon {
  final int id;
  final String code;
  final String discountType;
  final String discountValue;
  final String? maxDiscountValue;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final String minimumOrderValue;
  final bool isStackable;
  final String redemptionMessage;

  Coupon({
    required this.id,
    required this.code,
    required this.discountType,
    required this.discountValue,
    this.maxDiscountValue,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.minimumOrderValue,
    required this.isStackable,
    required this.redemptionMessage,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      id: json['id'],
      code: json['code'],
      discountType: json['discount_type'],
      discountValue: json['discount_value'],
      maxDiscountValue: json['max_discount_value'],
      description: json['description'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      minimumOrderValue: json['minimum_order_value'],
      isStackable: json['is_stackable'],
      redemptionMessage: json['redemption_message'] ?? '',
    );
  }

  // Helper methods for UI display
  String getDiscountText() {
    if (discountType == 'PERCENTAGE') {
      return '${discountValue}% OFF';
    } else {
      return 'FLAT ₹${discountValue} OFF';
    }
  }

  String getMinimumOrderText() {
    return 'on orders above ₹$minimumOrderValue';
  }

  String getMaxDiscountText() {
    if (maxDiscountValue != null) {
      return 'Maximum discount: ₹$maxDiscountValue';
    }
    return '';
  }

  bool isValid() {
    final now = DateTime.now();
    return now.isAfter(startDate) && now.isBefore(endDate);
  }
}

// lib/models/coupon_response.dart
class CouponResponse {
  final String message;
  final List<Coupon> coupons;

  CouponResponse({required this.message, required this.coupons});

  factory CouponResponse.fromJson(Map<String, dynamic> json) {
    return CouponResponse(
      message: json['message'],
      coupons: (json['coupons'] as List)
          .map((coupon) => Coupon.fromJson(coupon))
          .toList(),
    );
  }
}
