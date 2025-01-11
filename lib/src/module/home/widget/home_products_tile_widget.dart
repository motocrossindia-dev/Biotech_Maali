import 'package:biotech_maali/src/module/home/model/product_model.dart';

import '../../../../import.dart';

class HomeProductsTileWidget extends StatelessWidget {
  final String title;

  const HomeProductsTileWidget({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
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
              Consumer<HomeProvider>(
                builder: (context, provider, child) {
                  // final products = provider.featuredProducts;
                  List<ProductModel> products = [];
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductListScreen(
                            title: title,
                            products: products,
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
                List<ProductModel> products = [];
                if (title == "Featured") {
                  products = provider.featuredProducts;
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
                    // ignore: prefer_const_constructors
                    ProductModel productDetails = products[index];
                    return Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailsScreen(
                                    productId: productDetails.id),
                              ),
                            );
                          },
                          child: ProductTileWidget(
                            productTitle: productDetails.name,
                            productImage: productDetails.image,
                            tempImage: 'assets/png/products/sample_product.png',
                            discountAmount: productDetails.price,
                            actualAmount: productDetails.price,
                            rating: 4.5,
                            home: false,
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
}
