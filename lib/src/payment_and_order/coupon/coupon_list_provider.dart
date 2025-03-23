import 'dart:developer';

import 'package:biotech_maali/src/payment_and_order/coupon/coupon_list_repository.dart';
import 'package:biotech_maali/src/payment_and_order/order_summary/model/order_response_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../import.dart';

class CouponProvider extends ChangeNotifier {
  final CouponRepository _repository = CouponRepository();

  List _coupons = [];
  bool _isLoading = false;
  String? _error;
  String? _appliedCouponCode;
  double _cartValue = 0.0;
  double _discountAmount = 0.0;
  bool _isCouponApplied = false; // New flag to track coupon application status

  List get coupons => _coupons;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get appliedCouponCode => _appliedCouponCode;
  double get cartValue => _cartValue;
  double get discountAmount => _discountAmount;
  double get finalAmount => _cartValue - _discountAmount;
  bool get isCouponApplied => _isCouponApplied; // Getter for the new flag

  void setCartValue(double value) {
    _cartValue = value;
    notifyListeners();
  }

  Future fetchCoupons(String orderId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    log("orderid : $orderId");

    try {
      _coupons = await _repository.getCoupons(orderId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<OrderData ?> applyCoupon(String couponId, String orderId, String couponCode,
      BuildContext context) async {
    _isLoading = true;
    _error = null;
    _isCouponApplied = false; // Reset the flag at the start
    notifyListeners();

    try {
      final result =
          await _repository.applyCoupon(couponId: couponId, orderId: orderId);

      if (result != null && result.success == true) {
        _appliedCouponCode = couponCode;
        _isCouponApplied = true; // Set flag to true on success
        _discountAmount = result.discountAmount!;
        
        Fluttertoast.showToast(msg: "Coupon applied successfully");
        _isLoading = false;
        notifyListeners();
        return result;
      } else {
        // This might not be reached since repository throws exceptions on failure
        _appliedCouponCode = null;
        _discountAmount = 0;
        _isLoading = false;
        notifyListeners();
        return null;
      }
    } catch (e) {
      log("Coupon application error: ${e.toString()}");
      Fluttertoast.showToast(msg: e.toString());
      _appliedCouponCode = null;
      _discountAmount = 0;
      _isLoading = false;
      notifyListeners();
      return null;
    }
  }

  void removeCoupon() {
    _appliedCouponCode = null;
    _discountAmount = 0;
    _isCouponApplied = false; // Reset flag when coupon is removed
    notifyListeners();
  }

}
