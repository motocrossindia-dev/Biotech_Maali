import 'dart:developer';

import 'package:biotech_maali/import.dart';
import 'package:biotech_maali/src/payment_and_order/choose_payment/choose_payment_repository.dart';
import 'package:biotech_maali/src/payment_and_order/choose_payment/widgets/payment_success_popup.dart';
import 'package:biotech_maali/src/payment_and_order/order_summary/model/order_summary_response.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class ChoosePaymentProvider extends ChangeNotifier {
  final ChoosePaymentRepository _repository = ChoosePaymentRepository();
  late Razorpay _razorpay;
  bool _isLoading = false;
  String _error = '';
  OrderSummaryResponse? _orderSummaryResponse;

  bool get isLoading => _isLoading;
  String get error => _error;
  BuildContext context;
  int? orderId;

  ChoosePaymentProvider(this.context) {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void setOrderSummary(OrderSummaryResponse response) {
    _orderSummaryResponse = response;
    notifyListeners();
  }

  Future<void> initiatePayment(
      BuildContext context, OrderSummaryResponse response) async {
    log("order summary response : ${response.toString()}");

    _orderSummaryResponse = response;
    try {
      _isLoading = true;
      _error = '';
      notifyListeners();

      if (_orderSummaryResponse == null) {
        throw Exception('Order details not found');
      }

      final response = await _repository.proceedToPayment(
        orderId: _orderSummaryResponse!.data.order.id,
        paymentMethod: 'UPI',
      );

      log(response["order_id"].toString());
      log(response["razorpay_order"]['id'].toString());

      orderId = response["order_id"];

      final options = {
        "key": "rzp_test_zu1D9WznwNYRVG",
        "amount": (_orderSummaryResponse!.data.order.grandTotal * 100).toInt(),
        "name": "Biotech Maali",
        "description": "Order #${_orderSummaryResponse!.data.order.orderId}",
        "order_id": response["razorpay_order"]['id'],
        "prefill": {
          "contact": "8907444333",
          "email": "customer@email.com",
        },
        "notes": {
          "order_id": _orderSummaryResponse!.data.order.orderId.toString(),
        },
        "theme": {"color": "#4CAF50"}
      };

      _razorpay.open(options);
    } catch (e) {
      _error = e.toString();
      Fluttertoast.showToast(
        msg: _error,
        backgroundColor: Colors.red,
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    try {
      await _repository.verifyPayment(
        razorpayPaymentId: response.paymentId,
        razorpayOrderId: response.orderId,
        razorpaySignature: response.signature,
        orderId: orderId,
        paymentMethod: 'UPI',
      );

      if (navigatorKey.currentContext != null) {
        // Show success dialog
        showDialog(
          context: navigatorKey.currentContext!,
          barrierDismissible: false,
          builder: (context) => const PaymentSuccessPopup(),
        );
      } else {
        log("Navigator context is null");
        throw Exception("Navigation failed - context is null");
      }
    } catch (e) {
      _error = e.toString();
      log("Error in payment success handler: ${e.toString()}");
      Fluttertoast.showToast(
        msg: "Payment verified but navigation failed. Please restart the app.",
        backgroundColor: Colors.orange,
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    _error = response.message ?? 'Payment failed';
    log("Response : ${_error.toString()}");
    Fluttertoast.showToast(
      msg: _error,
      backgroundColor: Colors.red,
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
      msg: "External Wallet Selected: ${response.walletName}",
      backgroundColor: Colors.green,
    );
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }
}
