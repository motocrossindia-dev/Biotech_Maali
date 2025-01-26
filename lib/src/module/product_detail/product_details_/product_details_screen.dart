import 'dart:developer';

import 'package:biotech_maali/core/settings_provider/settings_provider.dart';
import 'package:biotech_maali/src/module/cart/cart_provider.dart';
import 'package:biotech_maali/src/module/product_detail/product_details_/model/product_details_model.dart';
import 'package:biotech_maali/src/module/product_detail/product_details_/widgets/planter_size_widget.dart';
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
    provider.fetchProductDetails(widget.productId);
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
          ProductDetailModel? product = provider.productDetails;

          if (product == null) {
            return const Text('Data is not available');
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
                                title: product.data.product.mainProductName,
                                fontSize: 24,
                                fontWeight: FontWeight.w400,
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
                                      title: '₹${productDetail.product.price}',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: cProductRate,
                                    ),
                                    sizedBoxWidth5,
                                    CommonTextWidget(
                                      title: '₹${productDetail.product.price}',
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
                                          title: '25% OFF',
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CommonTextWidget(
                                  title: 'Select Plant Size'),
                              sizedBoxHeight05,
                              SizedBox(
                                height:
                                    50, // Adjust height based on your ProductSizeWidget
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: productDetail.productSizes.length,
                                  itemBuilder: (context, index) {
                                    ProductSize productSize =
                                        productDetail.productSizes[index];

                                    return Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: ProductSizeWidget(
                                        id: productSize.id,
                                        name: productSize.size,
                                        event: () {
                                          provider.updateSize(productSize.id,
                                              productDetail.product.id);
                                        },
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                          sizedBoxHeight20,
                          Column(
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
                                  itemCount:
                                      productDetail.productPlanterSizes.length,
                                  itemBuilder: (context, index) {
                                    ProductPlanterSize productPlanterSizes =
                                        productDetail
                                            .productPlanterSizes[index];

                                    return Padding(
                                      padding: const EdgeInsets.only(right: 10),
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
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CommonTextWidget(title: 'Select Planter'),
                              sizedBoxHeight05,
                              SizedBox(
                                height:
                                    50, // Adjust height based on your ProductSizeWidget
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      productDetail.productPlanters.length,
                                  itemBuilder: (context, index) {
                                    ProductPlanter productPlanter =
                                        productDetail.productPlanters[index];

                                    return Padding(
                                      padding: const EdgeInsets.only(right: 10),
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
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    sizedBoxHeight20,
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                itemCount: productDetail.productColors.length,
                                itemBuilder: (context, index) {
                                  ProductColor productColor =
                                      productDetail.productColors[index];
                                  Color color = Color(int.parse(
                                          productColor.colorCode.substring(1),
                                          radix: 16) |
                                      0xFF000000);
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: ColorContainerWidget(
                                      onTap: () {
                                        provider.updateColor(productColor.id,
                                            productDetail.product.id);
                                      },
                                      color: color,
                                      isSelected: provider.selectedColorId ==
                                              productColor.id
                                          ? true
                                          : false,
                                    ),
                                  );
                                },
                              ),
                            ),
                            sizedBoxHeight20,
                            Row(
                              children: [
                                const CommonTextWidget(title: 'Qty: '),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: AddQuantityWidget(
                                    quantity: provider.quantity,
                                    addition: () {
                                      provider.increaseQuantity(1);
                                    },
                                    substaction: () {
                                      provider.decreaseQuantity(1);
                                    },
                                  ),
                                )
                              ],
                            ),
                            sizedBoxHeight20,
                            const ProductListWidget(title: 'Add On'),
                            sizedBoxHeight40,
                            const ProductDescription(),
                            sizedBoxHeight20,
                            const ProductListWidget(
                                title: 'Customers Also Bought'),
                            sizedBoxHeight20,
                            const ProductListWidget(title: 'Recently Viewed'),
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
                        child: CustomizableBorderColoredButton(
                            title: 'BUY NOW',
                            event: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const OrderSummaryScreen(),
                                  ));
                            }),
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
                            }),
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
