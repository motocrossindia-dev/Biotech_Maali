import '../../../../import.dart';

class CartProductTile extends StatelessWidget {
  final String productTitle;
  final String productImage;
  final double rating;
  final double actualAmount;
  final double discountAmount;
  final bool home;
  final List<String>? plantVariants;

  const CartProductTile(
      {required this.productTitle,
      required this.productImage,
      required this.actualAmount,
      required this.discountAmount,
      required this.rating,
      required this.home,
      this.plantVariants,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 175,
      decoration: BoxDecoration(color: cAppBackround),
      child: Stack(
        children: [
          // Main content of the container
          Column(
            children: [
              Row(
                children: [
                  Image.asset(productImage),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CommonTextWidget(
                          title: productTitle,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        plantVariants != null
                            ? Wrap(
                                spacing: 1.0,
                                children: plantVariants?.map(
                                      (variant) {
                                        return Row(
                                          children: [
                                            CommonTextWidget(
                                              title: variant,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            const Text('/'),
                                          ],
                                        );
                                      },
                                    ).toList() ??
                                    [],
                              )
                            : sizedBoxHeight10,

                            
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CommonTextWidget(
                              title: '₹${discountAmount.toStringAsFixed(2)}',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: cProductRate,
                            ),
                            sizedBoxWidth5,
                            CommonTextWidget(
                              title: '₹${actualAmount.toStringAsFixed(2)}',
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                              color: cProductRateCrossed,
                              lineThrough: TextDecoration.lineThrough,
                            ),
                          ],
                        ),
                        sizedBoxHeight10,
                        const AddQuantityWidget(),
                        sizedBoxHeight10,
                        const CommonTextWidget(
                          title: 'Out of stock',
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Delete icon positioned in the upper-right corner
          Positioned(
            top: 8,
            right: 8,
            child: InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SvgPicture.asset('assets/svg/icons/delete_icon.svg'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
