import 'dart:developer';

import 'package:biotech_maali/import.dart';
import 'package:biotech_maali/src/module/account/wallet/wallet_provider.dart';
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

  bool isWalletCheckbox = false;
  double? actualWalletBalance;
  bool isOnlineRadioButton = true;
  double _walletBalence = 0.0;
  bool get isLoading => _isLoading;
  String get error => _error;
  BuildContext context;
  int? orderId;

  void handleOnlinePaymentOption(bool value) {
    isOnlineRadioButton = !value;
    log("value : $value");
    notifyListeners();
  }

  void handleWalletBalance(double value) {
    actualWalletBalance = value;
    log("wallet balance : $actualWalletBalance");
    notifyListeners();
  }

  void handleCashOnDeliveryPayment(bool value) {
    isOnlineRadioButton = value;
    log("value : $value");
    notifyListeners();
  }

  void handleWalletCheckbox(bool value, double? walletBalence) {
    isWalletCheckbox = value;
    if (walletBalence != null) {
      _walletBalence = walletBalence;
    } else {
      _walletBalence = 0.0;
    }

    log("wallet balance : $_walletBalence");
    notifyListeners();
  }

  ChoosePaymentProvider(this.context) {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  // void setOrderSummary(OrderSummaryResponse response) {
  //   _orderSummaryResponse = response;
  //   notifyListeners();
  // }

  void checkPaymentMethod(
      OrderSummaryResponse orderSummaryResponse, BuildContext context) {
    log("order summary response : ${orderSummaryResponse.data.order.grandTotal}");
    _orderSummaryResponse = orderSummaryResponse;
    if (actualWalletBalance! < 0 && isWalletCheckbox) {
      initiatePayment(context, orderSummaryResponse,
          isWallet: isWalletCheckbox);
    } else if (actualWalletBalance! >= 0 && isWalletCheckbox) {
      initiatePayment(context, orderSummaryResponse,
          isWallet: isWalletCheckbox);
    } else {
      initiatePayment(context, orderSummaryResponse);
    }
  }

  Future<void> initiatePayment(
      BuildContext context, OrderSummaryResponse orderSummaryResponse,
      {bool isWallet = false}) async {
    log("order summary response : ${orderSummaryResponse.data.order.grandTotal}");

    _orderSummaryResponse = orderSummaryResponse;

    double amoutToPay = orderSummaryResponse.data.order.grandTotal;
    if (isWallet) {
      if (actualWalletBalance! >= 0) {
        try {
          final response = await _repository.proceedToPayment(
            orderId: _orderSummaryResponse!.data.order.id,
            paymentMethod: 'Wallet',
          );
          showDialog(
            context: navigatorKey.currentContext!,
            barrierDismissible: false,
            builder: (context) => const PaymentSuccessPopup(),
          );
          return;
        } catch (e) {
          Fluttertoast.showToast(
            msg: "Error in proceeding to payment",
            backgroundColor: Colors.red,
          );
          return;
        }
      }

      amoutToPay = actualWalletBalance!.abs();
      log("amount to pay : $amoutToPay");
    }

    try {
      _isLoading = true;
      _error = '';
      notifyListeners();

      if (_orderSummaryResponse == null) {
        throw Exception('Order details not found');
      }

      final response = await _repository.proceedToPayment(
        orderId: _orderSummaryResponse!.data.order.id,
        paymentMethod: isWallet ? 'Wallet' : 'UPI',
      );

      log(response["order_id"].toString());
      log(response["razorpay_order"]['id'].toString());

      orderId = response["order_id"];

      final options = {
        "key": "rzp_test_zu1D9WznwNYRVG",
        "amount": (amoutToPay * 100).toInt(),
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
      // isWalletCheckbox = false;
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
        // Use post-frame callback to update wallet
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.read<WalletProvider>().fetchWalletDetails();
        });

        isWalletCheckbox = false;
        notifyListeners();

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
      msg: "Payment failed press proceed to continue",
      toastLength: Toast.LENGTH_LONG,
      textColor: Colors.red,
      backgroundColor: Colors.white,
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
