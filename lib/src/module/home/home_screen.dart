import '../../../import.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: cScaffoldBackground,
      appBar: const CustomAppBarWithSearch(),
      body: const Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  sizedBoxHeight10,
                  CategoryWidget(),
                  CarouselWidget(),
                  sizedBoxHeight20,
                  HomeProductsTileWidget(
                    title: 'Featured',
                  ),
                  sizedBoxHeight20,
                  HomeProductsTileWidget(
                    title: 'Latest',
                  ),
                  sizedBoxHeight20,
                  HomeProductsTileWidget(
                    title: 'Bestseller',
                  ),
                  sizedBoxHeight20,
                  ReferFriendWidget(),
                  sizedBoxHeight20,
                  HomeProductsTileWidget(title: 'Seasonal Collection'),
                  sizedBoxHeight20,
                  CompoOfferWidget(),
                  sizedBoxHeight20,
                  // VideoplayerWidget(),
                  YoutubeVideoplayerWidget(),
                  sizedBoxHeight20,
                  ExploreOurWorkWidget(),
                  sizedBoxHeight50,
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
