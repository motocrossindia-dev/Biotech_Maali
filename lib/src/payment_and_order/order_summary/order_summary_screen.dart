import 'package:biotech_maali/src/payment_and_order/choose_payment/choose_payment_screen.dart';

import '../../../import.dart';

class OrderSummaryScreen extends StatefulWidget {
  const OrderSummaryScreen({super.key});

  @override
  State<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  String selectedDeliveryOption = 'Standard(₹000.00)';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: orderSummaryBackground,
      appBar: AppBar(
        elevation: 4,
        shadowColor: Colors.black,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: const CommonTextWidget(
          title: 'Order Summary',
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          OrderTrackerTimeline(
                              currentStatus: OrderStatus.address),
                          sizedBoxHeight30,
                          DeliveryAddressWidget(),
                        ],
                      ),
                    ),
                  ),
                  sizedBoxHeight20,
                  Card(
                    color: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const CartItemsWidget(),
                          sizedBoxHeight05,
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              minimumSize: const Size(double.infinity, 45),
                              backgroundColor: Colors.white,
                              foregroundColor: cButtonGreen,
                              side: BorderSide(color: cButtonGreen),
                            ),
                            child: const CommonTextWidget(
                                title: 'Add More Products'),
                          ),
                          sizedBoxHeight10
                        ],
                      ),
                    ),
                  ),
                  sizedBoxHeight20,
                  const Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: DeliveryOptionsWidget(),
                    ),
                  ),
                  sizedBoxHeight20,
                  const Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CouponWidget(),
                    ),
                  ),
                  sizedBoxHeight20,
                  const Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: PriceDetailsWidget(),
                    ),
                  ),
                  sizedBoxHeight70,
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: 60,
              color: cWhiteColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
                      width: 160,
                      height: 48,
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonTextWidget(
                              title: '₹7999',
                              lineThrough: TextDecoration.lineThrough,
                              fontSize: 12,
                            ),
                            CommonTextWidget(
                              title: '₹5400',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            )
                          ],
                        ),
                      )),
                  SizedBox(
                    width: 160,
                    height: 48,
                    child: CustomizableButton(
                      title: 'PAYMENT',
                      event: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PaymentScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
