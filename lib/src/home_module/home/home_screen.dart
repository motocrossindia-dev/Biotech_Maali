import 'package:biotech_maali/src/home_module/home/widget/youtube_videoplayer_widget.dart';

import '../../../import.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 252, 251, 251),
      appBar: CustomAppBarWithSearch(),
      body: Column(
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
                  // VideoplayerWidget()
                  // YoutubeVideoplayerWidget()

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
