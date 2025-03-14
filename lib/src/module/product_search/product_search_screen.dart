import 'package:biotech_maali/core/settings_provider/settings_provider.dart';
import 'package:biotech_maali/import.dart';
import 'package:biotech_maali/src/module/wishlist/whishlist_provider.dart';
import 'package:biotech_maali/src/widgets/login_prompt_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'product_search_provider.dart';
import 'model/product_search_model.dart';

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
                if (query.length >= 1) {
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
                    return ProductTileWidget(
                      tempImage: "",
                      productTitle: product.name,
                      productImage: product.image,
                      actualAmount: product.mrp.toString(),
                      home: true,
                      isWishlist: false,
                      isCart: false,
                      mainProdId: product.id,
                      discountAmount: product.price.toString(),
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
                        wishlistProvider.addOrRemoveWhishlistMainProduct(
                            product.id, context);
                      },
                      // addToCartEvent: () {},
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

class SearchBar extends StatelessWidget {
  final Function(String) onChanged;

  const SearchBar({Key? key, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search products...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onChanged: onChanged,
    );
  }
}

class ProductCard extends StatelessWidget {
  final ProductSearchModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.network(
              '${BaseUrl.baseUrlForImages}${product.image}',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '₹${product.price}',
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void _showLoginDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const LoginPromptDialog();
    },
  );
}
