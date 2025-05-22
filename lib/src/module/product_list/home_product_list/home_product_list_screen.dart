import 'package:biotech_maali/core/settings_provider/settings_provider.dart';
import 'package:biotech_maali/src/module/home/model/home_product_model.dart';
import 'package:biotech_maali/src/module/product_search/product_search_screen.dart';
import 'package:biotech_maali/src/module/wishlist/wishlist_screen.dart';
import 'package:biotech_maali/src/widgets/login_prompt_dialog.dart';
import 'package:biotech_maali/src/module/product_list/product_list_shimmer.dart';

import '../../../../import.dart';

class HomeProductListScreen extends StatefulWidget {
  final String title;
  final List<HomeProductModel> products;
  const HomeProductListScreen(
      {required this.title, required this.products, super.key});

  @override
  State<HomeProductListScreen> createState() => _HomeProductListScreenState();
}

class _HomeProductListScreenState extends State<HomeProductListScreen> {
  // String _selectedOption = 'Default';
  bool _isLoading = true;

  // final List<String> _sortOptions = [
  //   'Default',
  //   'Relevance',
  //   'Just Launched',
  //   'Best Selling',
  //   'Price High To Low',
  //   'Price Low To High',
  //   'Alphabetically A-Z',
  //   'Alphabetically Z-A',
  // ];

  @override
  void initState() {
    super.initState();

    _loadData();
  }

  Future<void> _loadData() async {
    // await Future.delayed(const Duration(milliseconds: 50));
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        shadowColor: Colors.black,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: CommonTextWidget(
          title: widget.title,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProductSearchView(),
                ),
              );
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 40.0),
              child: Icon(Icons.search, size: 30),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? const ProductListShimmer()
          : SingleChildScrollView(
              child: Consumer<HomeProvider>(
                builder: (context, provider, child) {
                  return Column(
                    children: [
                      const CustomBannerWidget(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: widget.products.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15.0,
                            mainAxisSpacing: 15.0,
                            childAspectRatio: 0.48,
                          ),
                          itemBuilder: (context, index) {
                            HomeProductModel productDetails =
                                widget.products[index];

                            return InkWell(
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
                                mainProdId: productDetails.id,
                                productTitle: productDetails.name,
                                productImage: productDetails.image,
                                tempImage:
                                    'assets/png/products/sample_product.png',
                                discountAmount:
                                    productDetails.sellingPrice.toString(),
                                actualAmount: productDetails.mrp.toString(),
                                rating: productDetails.productRating.avgRating,
                                home: true,
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
                                      context.read<HomeProvider>();
                                  wishlistProvider.addOrRemoveToWishlist(
                                    productDetails.id,
                                    productDetails.isWishlist,
                                    context,
                                  );
                                },
                                addToCartEvent: productDetails.isCart
                                    ? () {
                                        context
                                            .read<BottomNavProvider>()
                                            .updateIndex(3);
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                BottomNavWidget(),
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
                                        context
                                            .read<HomeProvider>()
                                            .addToCartMainProduct(
                                              productDetails.id,
                                              productDetails.isCart,
                                              context,
                                            );
                                      },
                              ),
                            );
                          },
                        ),
                      ),
                      sizedBoxHeight70,
                    ],
                  );
                },
              ),
            ),
      // bottomNavigationBar: Container(
      //   width: double.infinity,
      //   height: 60,
      //   color: cWhiteColor,
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //     children: [
      //       Material(
      //         color: Colors.transparent,
      //         child: SizedBox(
      //           height: 55,
      //           child: InkWell(
      //             borderRadius: BorderRadius.circular(
      //                 8), // Round corners for the ripple effect
      //             splashColor: cButtonGreen
      //                 .withOpacity(0.3), // Color of the ripple effect
      //             highlightColor: cButtonGreen.withOpacity(0.1),
      //             onTap: () {
      //               log('message');
      //               // _showFilterDropdown(context);
      //               _showSortByOverlay(context);
      //             },

      //             child: Padding(
      //               padding: const EdgeInsets.only(left: 8.0, right: 8),
      //               child: Row(
      //                 children: [
      //                   SvgPicture.asset('assets/svg/icons/sort_icon.svg'),
      //                   sizedBoxWidth10,
      //                   const CommonTextWidget(
      //                     title: 'SORT BY',
      //                     fontSize: 18,
      //                     fontWeight: FontWeight.w400,
      //                   )
      //                 ],
      //               ),
      //             ),
      //           ),
      //         ),
      //       ),
      //       Material(
      //         color: Colors.transparent,
      //         child: SizedBox(
      //           height: 55,
      //           child: InkWell(
      //             borderRadius: BorderRadius.circular(
      //                 8), // Round corners for the ripple effect
      //             splashColor: cButtonGreen.withOpacity(0.3),
      //             highlightColor: cButtonGreen.withOpacity(0.1),
      //             onTap: () {
      //               log('message');
      //               Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                   builder: (context) => FilterScreen(type: widget.title),
      //                 ),
      //               );
      //             },

      //             child: Padding(
      //               padding: const EdgeInsets.only(left: 8.0, right: 8),
      //               child: Row(
      //                 children: [
      //                   SvgPicture.asset('assets/svg/icons/filter_icon.svg'),
      //                   sizedBoxWidth10,
      //                   const CommonTextWidget(
      //                     title: 'FILTER',
      //                     fontSize: 18,
      //                     fontWeight: FontWeight.w400,
      //                   )
      //                 ],
      //               ),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  // void _showSortByOverlay(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     backgroundColor: Colors.transparent,
  //     builder: (context) {
  //       return StatefulBuilder(
  //         builder: (BuildContext context, StateSetter setState) {
  //           return GestureDetector(
  //             onTap: () => Navigator.of(context).pop(),
  //             child: Container(
  //               decoration: const BoxDecoration(
  //                 color: Colors.white,
  //                 borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //               ),
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   Padding(
  //                     padding: const EdgeInsets.symmetric(vertical: 16.0),
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         const SizedBox.shrink(), // Empty space for left side
  //                         const CommonTextWidget(
  //                           title: 'Sort By',
  //                           fontSize: 20,
  //                           fontWeight: FontWeight.bold,
  //                           color: Colors.black,
  //                         ),
  //                         IconButton(
  //                           icon: const Icon(Icons.close),
  //                           onPressed: () => Navigator.of(context).pop(),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   ListView.builder(
  //                     shrinkWrap: true,
  //                     physics: const NeverScrollableScrollPhysics(),
  //                     itemCount: _sortOptions.length,
  //                     itemBuilder: (context, index) {
  //                       return RadioListTile(
  //                         title: Text(
  //                           _sortOptions[index],
  //                           style: TextStyle(
  //                             color: _selectedOption == _sortOptions[index]
  //                                 ? Colors.blue
  //                                 : Colors.black,
  //                           ),
  //                         ),
  //                         value: _sortOptions[index],
  //                         groupValue: _selectedOption,
  //                         onChanged: (value) {
  //                           setState(() {
  //                             _selectedOption = value!;
  //                           });
  //                           Navigator.of(context).pop();
  //                         },
  //                       );
  //                     },
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  void showWishlistMessage(BuildContext context, bool isAdded) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isAdded ? Icons.favorite : Icons.favorite_border,
              color: Colors.white,
            ),
            const SizedBox(width: 8),
            Text(isAdded
                ? 'Item added to wishlist successfully'
                : 'Item removed from wishlist'),
          ],
        ),
        action: isAdded
            ? SnackBarAction(
                label: 'View Wishlist',
                onPressed: () {
                  // Navigate to wishlist
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WishlistScreen()),
                  );
                },
              )
            : null,
        duration: const Duration(seconds: 2),
        behavior:
            SnackBarBehavior.floating, // Makes it float above bottom nav bar
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: isAdded ? Colors.green : Colors.grey[800],
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
