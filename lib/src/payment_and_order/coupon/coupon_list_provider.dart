// lib/providers/coupon_provider.dart
import 'package:biotech_maali/src/payment_and_order/coupon/coupon_list_repository.dart';
import 'package:biotech_maali/src/payment_and_order/coupon/model/coupon_model.dart';
import 'package:flutter/material.dart';


class CouponProvider extends ChangeNotifier {
  final CouponRepository _repository = CouponRepository();
  
  List<Coupon> _coupons = [];
  bool _isLoading = false;
  String? _error;
  String? _appliedCouponCode;
  double _cartValue = 0.0;
  double _discountAmount = 0.0;



  List<Coupon> get coupons => _coupons;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get appliedCouponCode => _appliedCouponCode;
  double get cartValue => _cartValue;
  double get discountAmount => _discountAmount;
  double get finalAmount => _cartValue - _discountAmount;

  void setCartValue(double value) {
    _cartValue = value;
    notifyListeners();
  }

  Future<void> fetchCoupons() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _coupons = await _repository.getCoupons();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> applyCoupon(String code) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final success = await _repository.applyCoupon(code: code, cartValue: _cartValue);
      
      if (success) {
        _appliedCouponCode = code;
        _calculateDiscount();
      }
    } catch (e) {
      _error = e.toString();
      _appliedCouponCode = null;
      _discountAmount = 0;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void removeCoupon() {
    _appliedCouponCode = null;
    _discountAmount = 0;
    notifyListeners();
  }

  void _calculateDiscount() {
    if (_appliedCouponCode == null) {
      _discountAmount = 0;
      return;
    }

    final appliedCoupon = _coupons.firstWhere(
      (coupon) => coupon.code == _appliedCouponCode,
      orElse: () => throw Exception('Coupon not found'),
    );

    if (_cartValue < double.parse(appliedCoupon.minimumOrderValue)) {
      _discountAmount = 0;
      _appliedCouponCode = null;
      _error = 'Cart value too low for this coupon';
      return;
    }

    if (appliedCoupon.discountType == 'PERCENTAGE') {
      _discountAmount = _cartValue * double.parse(appliedCoupon.discountValue) / 100;
      
      if (appliedCoupon.maxDiscountValue != null) {
        final maxDiscount = double.parse(appliedCoupon.maxDiscountValue!);
        if (_discountAmount > maxDiscount) {
          _discountAmount = maxDiscount;
        }
      }
    } else {
      // FLAT discount
      _discountAmount = double.parse(appliedCoupon.discountValue);
    }
  }

  List<Coupon> getApplicableCoupons() {
    return _coupons.where((coupon) {
      final minOrderValue = double.parse(coupon.minimumOrderValue);
      return minOrderValue <= _cartValue && coupon.isValid();
    }).toList();
  }

  double getRemainingAmountForCoupon(Coupon coupon) {
    final minOrderValue = double.parse(coupon.minimumOrderValue);
    if (_cartValue >= minOrderValue) return 0;
    return minOrderValue - _cartValue;
  }
}