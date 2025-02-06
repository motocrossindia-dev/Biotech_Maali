import 'dart:developer';

import 'package:biotech_maali/import.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class ChoosePaymentProvider extends ChangeNotifier {
  late Razorpay _razorpay;

  ChoosePaymentProvider() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Handle payment success
    log("Payment Success: ${response.paymentId} ${response.orderId} ${response.data.toString()}");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Handle payment error
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet
  }

  void checkout() async {
    final options = {
      "key": "rzp_test_zu1D9WznwNYRVG",
      "amount": 2000,
      "name": "Acme Corp.",
      "description": "Fine T-Shirt",
      "prefill": {
        "contact": "8907444333",
        "email": "",
      }
    };
  }
}
