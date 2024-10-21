import '../../../import.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBarWithSearch(),
      body: Column(
        children: [
          CategoryWidget(),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  CarouselWidget(),
                  sizedBoxHeight10,
                  // ProductTileWidget(
                  //   productTitle: 'Peace Lilly Plant',
                  //   productImage: 'assets/png/products/sample_product.png',
                  //   discountAmount: 499.00,
                  //   actualAmount: 599.00,
                  //   rating: 4.5,
                  //   home: false,
                  // ),
                  HomeProductsTileWidget()

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
