import 'package:biotech_maali/core/settings_provider/settings_provider.dart';
import 'package:biotech_maali/import.dart';
import 'package:biotech_maali/src/module/cart/cart_provider.dart';
import 'package:biotech_maali/src/module/wishlist/whishlist_provider.dart';
import 'package:biotech_maali/src/widgets/login_prompt_dialog.dart';
import 'product_search_provider.dart';

class ProductSearchView extends StatelessWidget {
  const ProductSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchBar(
              onChanged: (query) {
                if (query.isNotEmpty) {
                  context.read<ProductSearchProvider>().searchProducts(query);
                }
              },
            ),
          ),
          Expanded(
            child: Consumer<ProductSearchProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (provider.error.isNotEmpty) {
                  return Center(child: Text(provider.error));
                }
                return GridView.builder(
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.48,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemCount: provider.products.length,
                  itemBuilder: (context, index) {
                    final product = provider.products[index];
                    // bool isWishlistId = context
                    //     .watch<HomeProvider>()
                    //     .mainWishlistProductId
                    //     .contains(product.id);
                    return InkWell(
                      onTap: () {
                        context
                            .read<ProductDetailsProvider>()
                            .fetchProductDetails(product.id);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailsScreen(
                              productId: product.id,
                            ),
                          ),
                        );
                      },
                      child: ProductTileWidget(
                        tempImage: "",
                        productTitle: product.name,
                        productImage: product.image,
                        actualAmount: product.mrp.toString(),
                        home: true,
                        isWishlist: product.isWishlist,
                        isCart: product.isCart,
                        mainProdId: product.id,
                        discountAmount: product.sellingPrice.toString(),
                        rating: product.productRating.avgRating,
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
                          bool result = await wishlistProvider
                              .addOrRemoveWhishlistMainProduct(
                                  product.id, context);
                          if (result) {
                            provider.updateWishList(
                                product.isWishlist, product.id);
                          } else {
                            return;
                          }
                        },
                        addToCartEvent: product.isCart
                            ? () {
                                context
                                    .read<BottomNavProvider>()
                                    .updateIndex(3);
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BottomNavWidget(),
                                  ),
                                  (route) => false,
                                );
                              }
                            : () async {
                                final settingsProvider =
                                    context.read<SettingsProvider>();
                                bool isAuth = await settingsProvider
                                    .checkAccessTokenValidity(context);
                                if (!isAuth) {
                                  _showLoginDialog(context);
                                  return;
                                }
                                bool result = await context
                                    .read<CartProvider>()
                                    .addToCartMainProduct(
                                      product.id,
                                      product.isCart,
                                      context,
                                    );

                                if (result) {
                                  provider.updateCart(
                                    product.isCart,
                                    product.id,
                                    context,
                                  );
                                }
                              },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

//

void _showLoginDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const LoginPromptDialog();
    },
  );
}
