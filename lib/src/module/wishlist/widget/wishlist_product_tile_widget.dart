import 'package:cached_network_image/cached_network_image.dart';

import '../../../../import.dart';

class WishlistProductTileWidget extends StatelessWidget {
  final String productTitle;
  final String? productImage;
  final String tempImage;
  final double? rating;
  final String mrp;
  final String? sellingPrice;
  final bool home;
  final VoidCallback? addDeleteEvent;
  final VoidCallback? addToCartEvent;

  const WishlistProductTileWidget({
    required this.productTitle,
    this.productImage,
    required this.tempImage,
    required this.mrp,
    this.sellingPrice,
    this.rating,
    this.addDeleteEvent,
    this.addToCartEvent,
    required this.home,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const baseUrl = 'http://www.dev.back.biotechmaali.com:8000';

    return Container(
      width: 175,
      decoration: BoxDecoration(color: cAppBackround),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0, top: 8),
                child: InkWell(
                    onTap: addDeleteEvent, child: const Icon(Icons.delete_outline)),
              )
            ],
          ),
          sizedBoxHeight08,
          productImage != null
              ? SizedBox(
                  height: 150,
                  child: CachedNetworkImage(
                    imageUrl: '$baseUrl$productImage',
                    fit: BoxFit.fill,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) =>
                        _buildNoImagePlaceholder(),
                  ),
                )
              : _buildNoImagePlaceholder(),
          sizedBoxHeight10,
          RatingBarWidget(
            rating: rating ?? 0,
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
                title: '₹$sellingPrice',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: cProductRate,
              ),
              sizedBoxWidth5,
              CommonTextWidget(
                title: '₹$mrp',
                fontSize: 10,
                fontWeight: FontWeight.w300,
                color: cProductRateCrossed,
                lineThrough: TextDecoration.lineThrough,
              )
            ],
          ),
          sizedBoxHeight10,
          home
              ? Padding(
                  padding: const EdgeInsets.only(left: 1.0, right: 1),
                  child: BorderColoredButton(
                    title: 'Add To Cart',
                    height: 38,
                    event: addToCartEvent ?? () {},
                  ),
                )
              : sizedBoxHeight0
        ],
      ),
    );
  }

  Widget _buildNoImagePlaceholder() {
    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image_not_supported,
            color: Colors.red,
            size: 32,
          ),
          SizedBox(height: 8),
          Text(
            'No Image',
            style: TextStyle(
              color: Colors.red,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
