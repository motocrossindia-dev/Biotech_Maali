import 'dart:developer';
import 'package:biotech_maali/src/module/account/wallet/wallet_history/wallet_history_screen.dart';
import 'package:biotech_maali/src/module/home/model/product_model.dart';
import 'package:biotech_maali/src/module/wishlist/whishlist_provider.dart';

import '../../../import.dart';

class ProductListScreen extends StatefulWidget {
  final String title;
  final List<ProductModel> products;
  const ProductListScreen(
      {required this.title, required this.products, super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  String _selectedOption = 'Default';

  final List<String> _sortOptions = [
    'Default',
    'Relevance',
    'Just Launched',
    'Best Selling',
    'Price High To Low',
    'Price Low To High',
    'Alphabetically A-Z',
    'Alphabetically Z-A',
  ];

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
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 40.0),
            child: Icon(Icons.search, size: 30),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
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
                          ProductModel productDetails = widget.products[index];

                          bool isWishlistId = provider.mainWishlistProductId
                              .contains(productDetails.id);

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
                              productTitle: productDetails.name,
                              productImage: productDetails.image,
                              tempImage:
                                  'assets/png/products/sample_product.png',
                              discountAmount: productDetails.price,
                              actualAmount: productDetails.price,
                              rating: 4.5,
                              home: true,
                              isWishlist: isWishlistId,
                              addToFavouriteEvent: () {
                                final wishlistProvider =
                                    context.read<WishlistProvider>();
                                    wishlistProvider.addOrRemoveWhishlistMainProduct(
                                        productDetails.id, context);

                                        
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
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: 60,
              color: cWhiteColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Material(
                    color: Colors.transparent,
                    child: SizedBox(
                      height: 55,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(
                            8), // Round corners for the ripple effect
                        splashColor: cButtonGreen
                            .withOpacity(0.3), // Color of the ripple effect
                        highlightColor: cButtonGreen.withOpacity(0.1),
                        onTap: () {
                          log('message');
                          // _showFilterDropdown(context);
                          _showSortByOverlay(context);
                        },

                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                  'assets/svg/icons/sort_icon.svg'),
                              sizedBoxWidth10,
                              const CommonTextWidget(
                                title: 'SORT BY',
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: SizedBox(
                      height: 55,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(
                            8), // Round corners for the ripple effect
                        splashColor: cButtonGreen
                            .withOpacity(0.3), // Color of the ripple effect
                        highlightColor: cButtonGreen.withOpacity(0.1),
                        onTap: () {
                          log('message');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const FilterScreen(),
                            ),
                          );
                        },

                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                  'assets/svg/icons/filter_icon.svg'),
                              sizedBoxWidth10,
                              const CommonTextWidget(
                                title: 'FILTER',
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSortByOverlay(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox.shrink(), // Empty space for left side
                          const CommonTextWidget(
                            title: 'Sort By',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _sortOptions.length,
                      itemBuilder: (context, index) {
                        return RadioListTile(
                          title: Text(
                            _sortOptions[index],
                            style: TextStyle(
                              color: _selectedOption == _sortOptions[index]
                                  ? Colors.blue
                                  : Colors.black,
                            ),
                          ),
                          value: _sortOptions[index],
                          groupValue: _selectedOption,
                          onChanged: (value) {
                            setState(() {
                              _selectedOption = value!;
                            });
                            Navigator.of(context).pop();
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
