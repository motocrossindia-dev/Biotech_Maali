import '../../../../import.dart';

class CarouselWidget extends StatelessWidget {
  const CarouselWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [
            // Carousel Slider
            CarouselSlider(
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height *
                    0.38, // Adjust height to fit screen
                autoPlay: true,
                viewportFraction: 1.0,
                onPageChanged: (index, reason) {
                  provider.onCaroucelIndexChange(index);
                },
              ),
              items: provider.caroucelImageList
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

            // Indicators (dots below the carousel)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: provider.caroucelImageList.asMap().entries.map(
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
            sizedBoxHeight10,
            Text(
              'Vibrant and Thriving Plants Online',
              style: GoogleFonts.poppins(fontSize: 14),
            ),
            Text(
              'Celebrate Friendship with 15% Off ',
              style: GoogleFonts.poppins(fontSize: 14),
            ),
            sizedBoxHeight10,

            SizedBox(
              width: 180,
              height: 40,
              child: CommonButtonWidget(
                title: 'Shop Now',
                event: () {},
              ),
            ),
          ],
        );
      },
    );
  }
}
