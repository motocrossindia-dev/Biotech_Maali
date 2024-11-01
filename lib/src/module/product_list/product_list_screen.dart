import 'dart:developer';
import '../../../import.dart';

class ProductListScreen extends StatelessWidget {
  final String title;
  const ProductListScreen({required this.title,super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        shadowColor: Colors.black,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title:  CommonTextWidget(
          title: title,
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
            child: Column(
              children: [
                const CustomBannerWidget(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 11,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15.0,
                      mainAxisSpacing: 15.0,
                      childAspectRatio: 0.54,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductDetailsScreen(),));
                        },
                        child: const ProductTileWidget(
                          productTitle: 'Peace Lilly Plant',
                          productImage: 'assets/png/products/sample_product.png',
                          discountAmount: 499.00,
                          actualAmount: 599.00,
                          rating: 4.5,
                          home: true,
                        ),
                      );
                    },
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
}
