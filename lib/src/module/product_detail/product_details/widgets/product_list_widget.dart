import '../../../../../import.dart';

class ProductListWidget extends StatelessWidget {
  final String title;

  const ProductListWidget({required this.title, super.key});

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
            ],
          ),
          sizedBoxHeight40,
          SizedBox(
            height: 360,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) {
                // ignore: prefer_const_constructors
                return Row(
                  children: const [
                    ProductTileWidget(
                      productTitle: 'Peace Lilly Plant',
                      productImage: 'assets/png/products/sample_product.png',
                      tempImage: 'assets/png/products/sample_product.png',
                      discountAmount: "499.00",
                      actualAmount: "599.00",
                      rating: 4.5,
                      home: true,
                      isWishlist: false,
                      isCart: false,
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
  }
}
