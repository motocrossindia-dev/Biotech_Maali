import 'package:biotech_maali/src/module/product_detail/product_details/model/recently_viewed_model.dart';

import '../../../../../import.dart';

class ProductListRecentlyViewedWidget extends StatelessWidget {
  final String title;

  const ProductListRecentlyViewedWidget({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductDetailsProvider>(
      builder: (context, provider, child) {
        List<RecentlyViewedProduct> recentlyViewedProducts =
            provider.recentlyViewedProductList;
        return Padding(
          padding: const EdgeInsets.only(
              left: 12, right: 12), // Add padding for better layout
          child: Column(
            children: [
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween, // Distributes space evenly
                children: [
                  CommonTextWidget(
                    title: title,
                    color: cHomeProductText,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              sizedBoxHeight40,
              SizedBox(
                height: 360,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    RecentlyViewedProduct productData =
                        recentlyViewedProducts[index];
                    return Row(
                      children: [
                        InkWell(
                          onTap: () {
                            context
                                .read<ProductDetailsProvider>()
                                .fetchProductDetails(productData.id);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailsScreen(
                                    productId: productData.id),
                              ),
                            );
                          },
                          child: ProductTileWidget(
                            mainProdId: productData.id,
                            productTitle: productData.name,
                            productImage: productData.image,
                            tempImage: 'assets/png/products/sample_product.png',
                            discountAmount: productData.mrp.toString(),
                            actualAmount: productData.price.toString(),
                            rating: productData.productRating.avgRating,
                            home: true,
                            isWishlist: productData.isWishlist,
                            isCart: productData.isCart,
                          ),
                        ),
                        sizedBoxWidth15
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
