import '../../../../import.dart';

class CaroucelProductWidget extends StatelessWidget {
  const CaroucelProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductDetailsProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [
            // Carousel Slider
            Padding(
              padding: const EdgeInsets.only(top:12.0,right: 20,left: 20),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height *
                      0.5, // Adjust height to fit screen
                  autoPlay: false,
                  viewportFraction: 1.0,
                  onPageChanged: (index, reason) {
                    provider.onCaroucelIndexChange(index);
                  },
                ),
                items: provider.caroucelProductImageList
                    .map(
                      (item) => Container(
                        width: MediaQuery.of(context).size.width, // Full width
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

            // Indicators (dots below the carousel)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: provider.caroucelProductImageList.asMap().entries.map(
                (entry) {
                  return provider.caroucelIndex == entry.key
                      ? Container(
                          width: 27.0,
                          height: 5.0,
                          margin: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            // shape: BoxShape.circle,
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
