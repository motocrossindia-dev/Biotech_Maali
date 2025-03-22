import 'dart:developer';
import 'package:biotech_maali/core/settings_provider/settings_provider.dart';
import 'package:biotech_maali/src/module/cart/cart_provider.dart';
import 'package:biotech_maali/src/module/product_detail/product_details/model/product_details_model.dart';
import 'package:biotech_maali/src/module/product_detail/product_details/product_details_shimmer.dart';
import 'package:biotech_maali/src/module/product_detail/product_details/widgets/planter_size_widget.dart';
import 'package:biotech_maali/src/module/product_detail/product_details/widgets/pot_litre_widget.dart';
import 'package:biotech_maali/src/module/product_detail/product_details/widgets/product_list_addon_widget.dart';
import 'package:biotech_maali/src/module/product_detail/product_details/widgets/product_list_recently_viewed_widget.dart';
import 'package:biotech_maali/src/module/product_detail/product_details/widgets/seed_weight_widget.dart';
import '../../../../import.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productId;
  const ProductDetailsScreen({required this.productId, super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    final provider = context.read<ProductDetailsProvider>();
    // provider.fetchProductDetails(widget.productId);
    provider.updateQuantity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productDetailsProvider = context.watch<ProductDetailsProvider>();
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        shadowColor: Colors.black,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: CommonTextWidget(
          title: productDetailsProvider
                  .productDetails?.data.product.mainProductName ??
              "No Product Details",
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
      body: Consumer<ProductDetailsProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const ProductDetailsShimmer();
          }

          ProductDetailModel? product = provider.productDetails;
          if (product == null) {
            return const Center(
              child: Text('Data is not available'),
            );
          }
          log("Product Id in UI: ${widget.productId}");
          ProductData productDetail = product.data;
          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CaroucelProductWidget(),
                    sizedBoxHeight10,
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CommonTextWidget(
                                title: product.data.product.mainProductName
                                            .length >
                                        28
                                    ? '${product.data.product.mainProductName.substring(0, 28)}...'
                                    : product.data.product.mainProductName,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: provider.isLoadingWishList
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
                                    : IconButton(
                                        icon: SvgPicture.asset(
                                          'assets/svg/icons/heart_unselected.svg',
                                          color: provider.isWishlist
                                              ? Colors.red
                                              : Colors.black,
                                          height: 24,
                                          width: 24,
                                        ),
                                        onPressed: () {
                                          provider
                                              .addOrRemoveWhishlistCompinationProduct(
                                                  productDetail.product.id,
                                                  context);
                                        },
                                      ),
                              ),
                            ],
                          ),
                          sizedBoxHeight10,
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RatingsAndReviews(
                                    productData: productDetail,
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CommonTextWidget(
                                      title:
                                          '₹${productDetail.product.sellingPrice}',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: cProductRate,
                                    ),
                                    sizedBoxWidth5,
                                    CommonTextWidget(
                                      title: '₹${productDetail.product.mrp}',
                                      fontSize: 10,
                                      fontWeight: FontWeight.w300,
                                      color: cProductRateCrossed,
                                      lineThrough: TextDecoration.lineThrough,
                                    ),
                                    sizedBoxWidth10,
                                    Container(
                                      width: 69,
                                      height: 22,
                                      decoration: BoxDecoration(
                                        color: cOffer,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: const Center(
                                        child: CommonTextWidget(
                                          title: '% OFF',
                                          // ${(100 - (productDetail.product.price / productDetail.product.mrp * 100)).toInt()}
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                sizedBoxHeight10,
                                ProductDetailsRatingWidget(
                                  productRating: productDetail.productRating,
                                ),
                              ],
                            ),
                          ),
                          sizedBoxHeight10,
                          productDetail.productSizes.isNotEmpty
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CommonTextWidget(
                                        title: productDetail.productType ==
                                                "plant"
                                            ? "Select Plant Size"
                                            : productDetail.productType ==
                                                    "tool"
                                                ? 'Select Tool Size'
                                                : productDetail.productType ==
                                                        "seed"
                                                    ? "Select Seed Size"
                                                    : productDetail
                                                                .productType ==
                                                            "pot"
                                                        ? "Select Pot Size"
                                                        : ""),
                                    sizedBoxHeight05,
                                    SizedBox(
                                      height:
                                          50, // Adjust height based on your ProductSizeWidget
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            productDetail.productSizes.length,
                                        itemBuilder: (context, index) {
                                          ProductSize productSize =
                                              productDetail.productSizes[index];

                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: ProductSizeWidget(
                                              id: productSize.id,
                                              name: productSize.size,
                                              event: () {
                                                provider.updateSize(
                                                    productSize.id,
                                                    productDetail.product.id);
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    sizedBoxHeight10,
                                  ],
                                )
                              : const SizedBox(
                                  height: 0,
                                ),
                          productDetail.productPlanterSizes.isNotEmpty
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const CommonTextWidget(
                                        title: 'Select Planter Size'),
                                    sizedBoxHeight05,
                                    SizedBox(
                                      height:
                                          50, // Adjust height based on your ProductSizeWidget
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: productDetail
                                            .productPlanterSizes.length,
                                        itemBuilder: (context, index) {
                                          ProductPlanterSize
                                              productPlanterSizes =
                                              productDetail
                                                  .productPlanterSizes[index];

                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: PlanterSizeWidget(
                                              id: productPlanterSizes.id,
                                              name: productPlanterSizes.size,
                                              event: () {
                                                provider.updatePlanterSize(
                                                    productPlanterSizes.id,
                                                    productDetail.product.id);
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    sizedBoxHeight10,
                                  ],
                                )
                              : const SizedBox(
                                  height: 0,
                                ),
                          productDetail.productPlanters.isNotEmpty
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const CommonTextWidget(
                                        title: 'Select Planter'),
                                    sizedBoxHeight05,
                                    SizedBox(
                                      height:
                                          50, // Adjust height based on your ProductSizeWidget
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: productDetail
                                            .productPlanters.length,
                                        itemBuilder: (context, index) {
                                          ProductPlanter productPlanter =
                                              productDetail
                                                  .productPlanters[index];

                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: PlanterWidget(
                                              id: productPlanter.id,
                                              name: productPlanter.name,
                                              event: () {
                                                provider.updatePlanter(
                                                    productPlanter.id,
                                                    productDetail.product.id);
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    sizedBoxHeight10,
                                  ],
                                )
                              : const SizedBox(
                                  height: 0,
                                ),
                          productDetail.productLitres.isNotEmpty
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const CommonTextWidget(
                                        title: 'Select Litre'),
                                    sizedBoxHeight05,
                                    SizedBox(
                                      height:
                                          50, // Adjust height based on your ProductSizeWidget
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            productDetail.productLitres.length,
                                        itemBuilder: (context, index) {
                                          ProductLitre productLitre =
                                              productDetail
                                                  .productLitres[index];

                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: PotLitreWidget(
                                              id: productLitre.id,
                                              name:
                                                  productLitre.name.toString(),
                                              event: () {
                                                provider.updateLitre(
                                                  productLitre.id,
                                                  productDetail.product.id,
                                                );
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    sizedBoxHeight20,
                                  ],
                                )
                              : const SizedBox(
                                  height: 0,
                                ),
                          productDetail.productWeights.isNotEmpty
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const CommonTextWidget(
                                        title: 'Select Product Waight'),
                                    sizedBoxHeight05,
                                    SizedBox(
                                      height:
                                          50, // Adjust height based on your ProductSizeWidget
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            productDetail.productWeights.length,
                                        itemBuilder: (context, index) {
                                          ProductWeight productWeight =
                                              productDetail
                                                  .productWeights[index];

                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: SeedWeightWidget(
                                              id: productWeight.id,
                                              name: productWeight.sizeGrams
                                                  .toString(),
                                              event: () {
                                                provider.updateWeight(
                                                    productWeight.id,
                                                    productDetail.product.id);
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    sizedBoxHeight20,
                                  ],
                                )
                              : const SizedBox(
                                  height: 0,
                                ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            productDetail.productColors.isNotEmpty
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const CommonTextWidget(
                                        title: 'Color:',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      sizedBoxHeight05,
                                      SizedBox(
                                        height:
                                            50, // Adjust height based on your ProductSizeWidget
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: productDetail
                                              .productColors.length,
                                          itemBuilder: (context, index) {
                                            ProductColor productColor =
                                                productDetail
                                                    .productColors[index];
                                            Color color = Color(int.parse(
                                                    productColor.colorCode
                                                        .substring(1),
                                                    radix: 16) |
                                                0xFF000000);
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10),
                                              child: ColorContainerWidget(
                                                onTap: () {
                                                  if (productDetail
                                                          .productType ==
                                                      "pot") {
                                                    provider.updateColorForPot(
                                                        productColor.id,
                                                        productDetail
                                                            .product.id);
                                                    return;
                                                  }
                                                  provider.updateColor(
                                                      productColor.id,
                                                      productDetail.product.id);
                                                },
                                                color: color,
                                                isSelected:
                                                    provider.selectedColorId ==
                                                            productColor.id
                                                        ? true
                                                        : false,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox(height: 0),
                            sizedBoxHeight10,
                            Row(
                              children: [
                                const CommonTextWidget(title: 'Qty: '),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: AddQuantityWidget(
                                    quantity: provider.quantity,
                                    addition: () {
                                      provider.increaseQuantity(
                                          1, productDetail.product.id);
                                    },
                                    substaction: () {
                                      provider.decreaseQuantity(
                                          1, productDetail.product.id);
                                    },
                                  ),
                                )
                              ],
                            ),
                            sizedBoxHeight20,
                            provider.productAddOn.isNotEmpty
                                ? const ProductListAddonWidget(title: 'Add On')
                                : sizedBoxHeight40,
                            ProductDescription(provider: provider),
                            // sizedBoxHeight20,
                            // const ProductListWidget(
                            //     title: 'Customers Also Bought'),
                            sizedBoxHeight20,
                            const ProductListRecentlyViewedWidget(
                                title: 'Recently Viewed'),
                            sizedBoxHeight70,
                          ],
                        ),
                      ),
                    ),
                  ],
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
                      SizedBox(
                        width: 160,
                        height: 48,
                        child: provider.isLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: cButtonGreen,
                                  color: cButtonRed,
                                ),
                              )
                            : CustomizableBorderColoredButton(
                                title: 'BUY NOW',
                                event: () {
                                  provider.placeOrder(
                                      productDetail.product.id, context);
                                },
                              ),
                      ),
                      SizedBox(
                        width: 160,
                        height: 48,
                        child: CustomizableButton(
                          title: 'ADD TO CART',
                          event: () async {
                            bool? isAuthenticated = await context
                                .read<SettingsProvider>()
                                .checkAccessTokenValidity(context);
                            if (isAuthenticated) {
                              final productDetailProvider =
                                  context.read<ProductDetailsProvider>();
                              context.read<CartProvider>().addToCart(
                                  product.data.product.id,
                                  productDetailProvider.quantity,
                                  context);
                            } else {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const MobileNumberScreen(),
                                ),
                                (route) => false,
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
