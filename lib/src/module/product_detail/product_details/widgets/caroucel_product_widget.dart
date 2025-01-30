import '../../../../../import.dart';

class CaroucelProductWidget extends StatelessWidget {
  const CaroucelProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductDetailsProvider>(
      builder: (context, provider, child) {
        // Show loading or empty state if no images
        if (provider.carouselProductImageList.isEmpty) {
          return const SizedBox(
            height: 300,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return Column(
          children: [
            // Carousel Slider
            Padding(
              padding: const EdgeInsets.only(top: 12.0, right: 20, left: 20),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.5,
                  autoPlay: false,
                  viewportFraction: 1.0,
                  onPageChanged: (index, reason) {
                    provider.onCarouselIndexChange(index);
                  },
                ),
                items: provider.carouselProductImageList
                    .map(
                      (item) => Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(item),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),

            // Indicators
            if (provider.carouselProductImageList.length >
                1) // Only show if multiple images
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: provider.carouselProductImageList.asMap().entries.map(
                  (entry) {
                    return provider.carouselIndex == entry.key
                        ? Container(
                            width: 27.0,
                            height: 5.0,
                            margin: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: cButtonGreen,
                            ),
                          )
                        : Container(
                            width: 5.0,
                            height: 5.0,
                            margin: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: cCaroucelButtonGrey,
                            ),
                          );
                  },
                ).toList(),
              ),
          ],
        );
      },
    );
  }
}
