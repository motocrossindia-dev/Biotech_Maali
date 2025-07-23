import 'package:biotech_maali/core/settings_provider/settings_provider.dart';
import 'package:biotech_maali/src/module/home/model/home_product_model.dart';
import 'package:biotech_maali/src/module/wishlist/whishlist_provider.dart';
import 'package:biotech_maali/src/widgets/login_prompt_dialog.dart';
import '../../../../import.dart';

class HomeProductsTileWidget extends StatelessWidget {
  final String title;

  const HomeProductsTileWidget({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonTextWidget(
                title: title,
                color: cHomeProductText,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
              Consumer<HomeProvider>(
                builder: (context, provider, child) {
                  List<HomeProductModel> products = [];
                  if (title == "Featured") {
                    products = provider.featuredProducts;
                  } else if (title == "Latest") {
                    products = provider.trendingProducts;
                  } else if (title == "Bestseller") {
                    products = provider.bestSellerProducts;
                  } else if (title == "Seasonal Collection") {
                    products = provider.seasonalProducts;
                  }

                  return CustomizableButton(
                    title: 'View All',
                    event: () {
                      // context.read<HomeProvider>().fetchWishlistProductId();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeProductListScreen(
                            title: title,
                          ),
                        ),
                      );
                    },
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  );
                },
              )
            ],
          ),
          sizedBoxHeight40,
          SizedBox(
            height: 280,
            child: Consumer<HomeProvider>(
              builder: (context, provider, child) {
                List<HomeProductModel> products = [];
                if (title == "Featured") {
                  products = provider.allProducts;
                } else if (title == "Latest") {
                  products = provider.trendingProducts;
                } else if (title == "Bestseller") {
                  products = provider.bestSellerProducts;
                } else if (title == "Seasonal Collection") {
                  products = provider.seasonalProducts;
                }
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    HomeProductModel productDetails = products[index];

                    // bool isWishlistId = provider.mainWishlistProductId
                    //     .contains(productDetails.id);

                    return Row(
                      children: [
                        InkWell(
                          onTap: () {
                            context
                                .read<ProductDetailsProvider>()
                                .fetchProductDetails(productDetails.id);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailsScreen(
                                  productId: productDetails.id,
                                ),
                              ),
                            );
                          },
                          child: ProductTileWidget(
                            productTitle: productDetails.name,
                            productImage: productDetails.image,
                            tempImage: 'assets/png/products/sample_product.png',
                            discountAmount:
                                productDetails.sellingPrice.toString(),
                            actualAmount: productDetails.mrp.toString(),
                            rating: productDetails.productRating.avgRating,
                            home: false,
                            isWishlist: productDetails.isWishlist,
                            isCart: productDetails.isCart,
                            addToFavouriteEvent: () async {
                              final settingsProvider =
                                  context.read<SettingsProvider>();
                              bool isAuth = await settingsProvider
                                  .checkAccessTokenValidity(context);

                              if (!isAuth) {
                                _showLoginDialog(context);
                                return;
                              }
                              final wishlistProvider =
                                  context.read<WishlistProvider>();
                              wishlistProvider.addOrRemoveWhishlistMainProduct(
                                  productDetails.id, context);
                            },
                            mainProdId: productDetails.id,
                          ),
                        ),
                        sizedBoxWidth15
                      ],
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void _showLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const LoginPromptDialog();
      },
    );
  }
}
