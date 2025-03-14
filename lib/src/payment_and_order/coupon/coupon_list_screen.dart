// lib/screens/apply_coupon_screen.dart
import 'package:biotech_maali/src/payment_and_order/coupon/coupon_list_provider.dart';
import 'package:biotech_maali/src/payment_and_order/coupon/model/coupon_model.dart';
import 'package:biotech_maali/src/widgets/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApplyCouponScreen extends StatefulWidget {
  final double cartValue;
  const ApplyCouponScreen({required this.cartValue, super.key});

  @override
  State<ApplyCouponScreen> createState() => _ApplyCouponScreenState();
}

class _ApplyCouponScreenState extends State<ApplyCouponScreen> {
  final TextEditingController _couponController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final couponProvider =
          Provider.of<CouponProvider>(context, listen: false);
      couponProvider.fetchCoupons();
    });
  }

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  void _applyCoupon() async {
    if (_couponController.text.isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<CouponProvider>(context, listen: false)
          .applyCoupon(_couponController.text);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Coupon applied successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const CommonTextWidget(
          title: 'APPLY COUPON',
          fontSize: 16,
        ),
        elevation: 0,
      ),
      body: Consumer<CouponProvider>(
        builder: (context, couponProvider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: Colors.white,
                child: Text(
                  'Your cart: ₹${widget.cartValue.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: TextField(
                  controller: _couponController,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    hintText: 'Enter Coupon Code',
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    suffixIcon: TextButton(
                      onPressed: _isLoading ? null : _applyCoupon,
                      child: Text(
                        'APPLY',
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'More offers',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ),
              Expanded(
                child: couponProvider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : couponProvider.error != null
                        ? Center(child: Text(couponProvider.error!))
                        : ListView.builder(
                            itemCount: couponProvider.coupons.length,
                            itemBuilder: (context, index) {
                              return CouponCard(
                                coupon: couponProvider.coupons[index],
                                cartValue: widget.cartValue,
                                onApply: () {
                                  _couponController.text =
                                      couponProvider.coupons[index].code;
                                  _applyCoupon();
                                },
                              );
                            },
                          ),
              ),
              if (couponProvider.appliedCouponCode != null)
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.green[50],
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.green[700]),
                      const SizedBox(width: 8),
                      Text(
                        'Coupon ${couponProvider.appliedCouponCode} applied',
                        style: TextStyle(color: Colors.green[700]),
                      ),
                      const Spacer(),
                      Text(
                        '- ₹${couponProvider.discountAmount.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Colors.green[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              // Container(
              //   padding: const EdgeInsets.all(16),
              //   color: Colors.black,
              //   child: Center(
              //     child: TextButton(
              //       onPressed: () {
              //         // For development purposes, show Add-On Payment Offers
              //         ScaffoldMessenger.of(context).showSnackBar(
              //           const SnackBar(
              //               content: Text('View Add-On Payment Offers')),
              //         );
              //       },
              //       child: Row(
              //         mainAxisSize: MainAxisSize.min,
              //         children: [
              //           Icon(Icons.local_offer, color: Colors.orange[700]),
              //           const SizedBox(width: 8),
              //           const Text('View Add-On Payment Offers',
              //               style: TextStyle(color: Colors.white)),
              //           const SizedBox(width: 8),
              //           const Icon(Icons.keyboard_arrow_down,
              //               color: Colors.white),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ],
          );
        },
      ),
    );
  }
}

class CouponCard extends StatelessWidget {
  final Coupon coupon;
  final double cartValue;
  final VoidCallback onApply;

  const CouponCard({
    Key? key,
    required this.coupon,
    required this.cartValue,
    required this.onApply,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final minOrderValue = double.parse(coupon.minimumOrderValue);
    final remainingAmount = minOrderValue - cartValue;
    final canApply = remainingAmount <= 0;

    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          // Left side with discount percentage
          Container(
            width: 80,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
            child: Center(
              child: RotatedBox(
                quarterTurns: 3,
                child: Text(
                  coupon.discountType == 'PERCENTAGE'
                      ? '${coupon.discountValue}% OFF'
                      : 'FLAT OFF',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          // Right side with coupon details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    coupon.code,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (!canApply)
                    Text(
                      'Add ₹${remainingAmount.toStringAsFixed(0)} more to avail this offer',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  const SizedBox(height: 8),
                  Text(
                    coupon.discountType == 'PERCENTAGE'
                        ? 'Get ${coupon.discountValue}% off'
                        : 'Get Flat Rs.${coupon.discountValue} off',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(),
                  Text(
                    coupon.discountType == 'PERCENTAGE'
                        ? 'Use code ${coupon.code} & get ${coupon.discountValue}% off on orders above ₹${coupon.minimumOrderValue}. ${coupon.maxDiscountValue != null ? 'Maximum discount: ₹${coupon.maxDiscountValue}.' : ''}'
                        : 'Use code ${coupon.code} & get ₹${coupon.discountValue} off on orders above ₹${coupon.minimumOrderValue}',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '+ MORE',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          // Apply button
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextButton(
              onPressed: canApply ? onApply : null,
              child: Text(
                'APPLY',
                style: TextStyle(
                  color: canApply ? Colors.grey[500] : Colors.grey[300],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
