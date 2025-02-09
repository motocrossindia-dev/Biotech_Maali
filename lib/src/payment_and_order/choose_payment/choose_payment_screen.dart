import 'dart:developer';

import 'package:biotech_maali/src/payment_and_order/choose_payment/choose_payment_provider.dart';
import 'package:biotech_maali/src/payment_and_order/order_summary/model/order_summary_response.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../import.dart';

class PaymentScreen extends StatefulWidget {
  final OrderSummaryResponse orderSummaryResponse;
  const PaymentScreen({required this.orderSummaryResponse, super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  // late Razorpay _razorpay;

  // @override
  // void initState() {
  //   super.initState();
  //   _razorpay = Razorpay();
  //   _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
  //   _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  //   _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  // }

  // @override
  // void dispose() {
  //   _razorpay.clear();
  //   super.dispose();
  // }

  // void _handlePaymentSuccess(PaymentSuccessResponse response) {
  //   // Handle payment success
  //   log("Payment Success: ${response.paymentId} ${response.orderId} ${response.data.toString()}");
  // }

  // void _handlePaymentError(PaymentFailureResponse response) {
  //   // Handle payment error
  // }

  // void _handleExternalWallet(ExternalWalletResponse response) {
  //   // Handle external wallet
  // }

  // void checkout() async {
  //   final options = {
  //     "key": "rzp_test_zu1D9WznwNYRVG",
  //     "amount": 2000,
  //     "name": "Acme Corp.",
  //     "description": "Fine T-Shirt",
  //     "prefill": {
  //       "contact": "8907444333",
  //       "email": "test@razprpay.com",
  //     }
  //   };

  //   try {
  //     _razorpay.open(options);
  //   } catch (e) {
  //     log("Razorpay Error: ${e.toString()}");
  //     debugPrint(e.toString());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  const Text(
                    'Select Payment Method',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            const OrderTrackerTimeline(currentStatus: OrderStatus.payment),

            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Total Amount',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Price Details
                      _buildPriceRow('Price (3 items)', '₹7899.00'),
                      _buildPriceRow('Discount', '-₹266.00', isGreen: true),
                      _buildPriceRow('Delivery Charges', 'Free',
                          originalPrice: '₹80', isGreen: true),
                      _buildPriceRow('Secured Packaging Fee', '₹198'),

                      const Divider(height: 32),

                      // Total
                      _buildPriceRow('Total Amount', '₹7899.00', isBold: true),

                      // Savings
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'You will save ₹9,811 on this order',
                          style: TextStyle(
                            color: Colors.green[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      // Payment Options
                      const SizedBox(height: 20),
                      _buildPaymentOption(
                        'Redeem Cashback',
                        '-₹799.00',
                        isCheckbox: true,
                      ),
                      _buildPaymentOption(
                        'Razorpay Secure (UPI, Cards, Wallets, NetBanking)',
                        '',
                        showPaymentIcons: true,
                      ),
                      _buildPaymentOption(
                          'Cash on Delivery/Pay on Delivery', ''),
                    ],
                  ),
                ),
              ),
            ),

            // Bottom Buttons

            Container(
              width: double.infinity,
              height: 60,
              color: cWhiteColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 160,
                    height: 48,
                    child: CustomizableBorderColoredButton(
                      title: 'CANCEL',
                      event: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 160,
                    height: 48,
                    child: CustomizableButton(
                      title: 'PROCEED',
                      event: () async {
                        context.read<ChoosePaymentProvider>().initiatePayment(
                            context, widget.orderSummaryResponse);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, String amount,
      {bool isGreen = false, String? originalPrice, bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Row(
            children: [
              if (originalPrice != null)
                Text(
                  originalPrice,
                  style: const TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey,
                  ),
                ),
              const SizedBox(width: 4),
              Text(
                amount,
                style: TextStyle(
                  color: isGreen ? Colors.green[600] : null,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(String label, String amount,
      {bool isCheckbox = false, bool showPaymentIcons = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          if (isCheckbox)
            Checkbox(value: false, onChanged: (value) {})
          else
            Radio(value: false, groupValue: true, onChanged: (value) {}),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label),
                if (showPaymentIcons)
                  Row(
                    children: [
                      // Payment method icons would go here
                      // You'll need to add actual payment method icons
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/png/payment_icon/upi.png",
                              height: 40,
                              width: 40,
                            ),
                            const SizedBox(width: 8),
                            Image.asset(
                              "assets/png/payment_icon/visa.png",
                              height: 44,
                              width: 44,
                            ),
                            const SizedBox(width: 8),
                            Image.asset(
                              "assets/png/payment_icon/master_card.png",
                              height: 40,
                              width: 40,
                            ),
                            const SizedBox(width: 8),
                            Image.asset(
                              "assets/png/payment_icon/rupay.png",
                              height: 54,
                              width: 54,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          if (amount.isNotEmpty)
            Text(
              amount,
              style: TextStyle(
                color: Colors.green[600],
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      ),
    );
  }
}
