import '../../../import.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CaroucelProductWidget(),
                sizedBoxHeight10,
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CommonTextWidget(
                        title: 'Peace Lily Plant',
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                      ),
                      sizedBoxHeight10,
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CommonTextWidget(
                            title: '₹499.00',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: cProductRate,
                          ),
                          sizedBoxWidth5,
                          CommonTextWidget(
                            title: '₹599.00',
                            fontSize: 10,
                            fontWeight: FontWeight.w300,
                            color: cProductRateCrossed,
                            lineThrough: TextDecoration.lineThrough,
                          ),
                          sizedBoxWidth10,
                          Container(
                            width: 69,
                            height: 22,
                            decoration: BoxDecoration(
                              color: cOffer,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Center(
                              child: CommonTextWidget(
                                title: '25% OFF',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                      sizedBoxHeight10,
                      const ProductDetailsRatingWidget(
                        rating: 3,
                      ),
                      sizedBoxHeight10,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CommonTextWidget(title: 'Select Plant Size'),
                          sizedBoxHeight05,
                          Row(
                            children: [
                              ProductSizeWidget(
                                name: 'Small',
                                event: () {},
                              ),
                              sizedBoxWidth10,
                              ProductSizeWidget(
                                name: 'Medium',
                                event: () {},
                              ),
                              sizedBoxWidth10,
                              ProductSizeWidget(
                                name: 'Large',
                                event: () {},
                              ),
                              sizedBoxWidth10,
                            ],
                          ),
                        ],
                      ),
                      sizedBoxHeight20,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CommonTextWidget(title: 'Select Plant Size'),
                          sizedBoxHeight05,
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: [
                              SizeIconWidget(
                                name: 'Pot',
                                event: () {},
                              ),
                              sizedBoxWidth10,
                              SizeIconWidget(
                                name: 'Roma',
                                event: () {},
                              ),
                              sizedBoxWidth10,
                              SizeIconWidget(
                                name: 'Roma',
                                event: () {},
                              ),
                              SizeIconWidget(
                                name: 'Roma',
                                event: () {},
                              ),
                              SizeIconWidget(
                                name: 'Roma',
                                event: () {},
                              ),
                              sizedBoxWidth10,
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                sizedBoxHeight20,
                const Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonTextWidget(
                          title: 'Color:',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        sizedBoxHeight05,
                        Row(
                          children: [
                            ColorContainerWidget(
                              color: Colors.deepPurpleAccent,
                              isSelected: true,
                            ),
                            sizedBoxWidth10,
                            ColorContainerWidget(
                              color: Colors.deepOrangeAccent,
                              isSelected: true,
                            ),
                            sizedBoxWidth10,
                            ColorContainerWidget(
                              color: Colors.blue,
                              isSelected: true,
                            ),
                            sizedBoxWidth10,
                            ColorContainerWidget(
                              color: Colors.purple,
                              isSelected: true,
                            ),
                            sizedBoxWidth10,
                            ColorContainerWidget(
                              color: Colors.teal,
                              isSelected: true,
                            ),
                          ],
                        ),
                        sizedBoxHeight20,
                        Row(
                          children: [
                            CommonTextWidget(title: 'Qty: '),
                            Padding(
                              padding: EdgeInsets.only(left: 15.0),
                              child: AddQuantityWidget(),
                            )
                          ],
                        ),
                        sizedBoxHeight20,
                        ProductListWidget(title: 'Add On'),
                        sizedBoxHeight40,
                        ProductDescription(),
                        sizedBoxHeight20,
                        ProductListWidget(title: 'Customers Also Bought'),
                        sizedBoxHeight20,
                        ProductListWidget(title: 'Recently Viewed'),
                        sizedBoxHeight20
                      ],
                    ),
                  ),
                ),
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
                    width: 183,
                    height: 48,
                    child: CustomizableBorderColoredButton(
                        title: 'BUY NOW', event: () {}),
                  ),
                  SizedBox(
                    width: 183,
                    height: 48,
                    child: CustomizableButton(
                      title: 'ADD TO CART',
                      event: () {},
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
