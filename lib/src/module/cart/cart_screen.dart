import '../../../import.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        shadowColor: Colors.black,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: const CommonTextWidget(
          title: 'Peace Lilly Plant',
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 40.0),
            child: Icon(Icons.search, size: 30),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(), // Disable scrolling of ListView
                  itemBuilder: (context, index) {
                    return const CartProductTile(
                      productTitle: 'Peace Lilly Plant',
                      productImage: 'assets/png/products/sample_product.png',
                      discountAmount: 499.00,
                      actualAmount: 599.00,
                      rating: 4.5,
                      home: true,
                      plantVariants: ['Small ', 'GrowPot ', 'Ivory '],
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: 5,
                ),
                Container(
                  height: 20,
                  width: double.infinity,
                  color: cAppBackround,
                ),
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sizedBoxHeight10,
                      CommonTextWidget(
                        title: 'Price Details',
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                      Divider(),
                      sizedBoxHeight20,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonTextWidget(
                            title: 'Price (5 Items)',
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                          CommonTextWidget(
                            title: '₹7899.00',
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                      sizedBoxHeight20,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonTextWidget(
                            title: 'Discount',
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                          CommonTextWidget(
                            title: '-₹266.00',
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.green,
                          ),
                        ],
                      ),
                      sizedBoxHeight20,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonTextWidget(
                            title: 'Delivery Charges',
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                          Row(
                            children: [
                              CommonTextWidget(
                                title: '₹80',
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                lineThrough: TextDecoration.lineThrough,
                              ),
                              CommonTextWidget(
                                title: ' Free',
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.green,
                              ),
                            ],
                          ),
                        ],
                      ),
                      sizedBoxHeight20,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonTextWidget(
                            title: 'Total Amount',
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          CommonTextWidget(
                            title: '-₹266.00',
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      sizedBoxHeight10,
                      Divider(
                        indent: mMargin_10,
                      )
                    ],
                  ),
                ),
                sizedBoxHeight25,
                const Center(
                  child: CommonTextWidget(
                    title: 'You will save ₹9811 on this order',
                    color: Colors.green,
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                  ),
                ),
                sizedBoxHeight25
              ],
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
                  SizedBox(
                    width: 170,
                    height: 48,
                    child: CustomizableBorderColoredButton(
                        title: 'CANCEL', event: () {}),
                  ),
                  SizedBox(
                    width: 170,
                    height: 48,
                    child: CustomizableButton(
                      title: 'PLACE ORDER',
                      event: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OrderSummaryScreen(),
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
