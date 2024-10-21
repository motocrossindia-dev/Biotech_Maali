import '../../import.dart';

class ProductTileWidget extends StatelessWidget {
  final String productTitle;
  final String productImage;
  final double rating;
  final double actualAmount;
  final double discountAmount;
  final bool home;
  final VoidCallback? addToFavouriteEvent;
  final VoidCallback? addToCartEvent;

  const ProductTileWidget(
      {required this.productTitle,
      required this.productImage,
      required this.actualAmount,
      required this.discountAmount,
      required this.rating,
      this.addToFavouriteEvent,
      this.addToCartEvent,
      required this.home,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 175,
      // height: 300,
      decoration: BoxDecoration(color: cAppBackround),
      child: Column(
        children: [
          home?
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0, top: 8),
                child: InkWell(
                  onTap: () {
      
                  },
                  child: SvgPicture.asset(
                      'assets/svg/icons/add_to_favourite_icon.svg'),
                ),
              )
            ],
          ):sizedBoxHeight08,
          Image.asset(productImage),
          sizedBoxHeight10,
          RatingBarWidget(
            rating: rating,
          ),
          sizedBoxHeight10,
          CommonTextWidget(
            title: productTitle,
            color: cProductTitle,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          sizedBoxHeight10,
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
              )
            ],
          ),
          sizedBoxHeight10,
          home?
          Padding(
            padding: const EdgeInsets.only(left: 1.0, right: 1),
            child: AddToCartButton(title: 'Add To Cart', event: () {}),
          ):sizedBoxHeight0
        ],
      ),
    );
  }
}
