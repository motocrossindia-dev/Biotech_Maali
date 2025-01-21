import 'package:biotech_maali/src/module/cart/cart_provider.dart';
import 'package:biotech_maali/src/module/wishlist/whishlist_provider.dart';
import '../../import.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductTileWidget extends StatelessWidget {
  final String productTitle;
  final String? productImage;
  final String tempImage;
  final double? rating;
  final String actualAmount;
  final String? discountAmount;
  final bool home;
  final VoidCallback? addToFavouriteEvent;
  final VoidCallback? addToCartEvent;
  final bool isWishlist;
  final int? mainProdId;

  const ProductTileWidget({
    required this.productTitle,
    this.productImage,
    required this.tempImage,
    required this.actualAmount,
    this.discountAmount,
    this.rating,
    this.addToFavouriteEvent,
    this.addToCartEvent,
    required this.home,
    required this.isWishlist,
    this.mainProdId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final wishListProviderWatch = context.watch<WishlistProvider>();
    const baseUrl = BaseUrl.baseUrlForImages;

    return Container(
      width: 175,
      decoration: BoxDecoration(color: cAppBackround),
      child: Column(
        children: [
          home
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0, top: 8),
                      child: wishListProviderWatch.isProductLoading(mainProdId ??
                              0) // Check loading state for this specific product
                          ? Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: SizedBox(
                                    height: 26,
                                    width: 26,
                                    child: CircularProgressIndicator(
                                      backgroundColor: cButtonGreen,
                                      color: cButtonRed,
                                    ),
                                  ),
                                ),
                                sizedBoxHeight15
                              ],
                            )
                          : InkWell(
                              onTap: addToFavouriteEvent,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SvgPicture.asset(
                                  'assets/svg/icons/add_to_favourite_icon.svg',
                                  color: isWishlist ? Colors.red : Colors.black,
                                ),
                              ),
                            ),
                    )
                  ],
                )
              : sizedBoxHeight08,
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
                title: '₹$discountAmount',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: cProductRate,
              ),
              sizedBoxWidth5,
              CommonTextWidget(
                title: '₹$actualAmount',
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
                    event: addToCartEvent ??
                        () {
                          context
                              .read<CartProvider>()
                              .addToCartMainProduct(mainProdId!, context);
                        },
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
