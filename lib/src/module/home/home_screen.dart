// import 'package:biotech_maali/src/module/home/widget/promotional_banner.dart';

// import '../../../import.dart';
// import 'dart:math' as math;

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   // Controller for lazy loading
//   final ScrollController _scrollController = ScrollController();
//   bool _isLoadingMore = false;

//   // Lazy loaded widgets
//   final List<Widget> _lazyWidgets = [];
//   final List<Widget> _allWidgets = [];

//   @override
//   void initState() {
//     super.initState();
//     _initializeWidgets();
//     _setupScrollController();
//   }

//   void _initializeWidgets() {
//     // Initialize all widgets that will be lazy loaded
//     _allWidgets.addAll([
//       const HomeProductsTileWidget(title: 'Featured'),
//       const HomeProductsTileWidget(title: 'Latest'),
//       const HomeProductsTileWidget(title: 'Bestseller'),
//       const ReferFriendWidget(),
//       const HomeProductsTileWidget(title: 'Seasonal Collection'),
//       const CompoOfferWidget(),
//       const YoutubeVideoplayerWidget(),
//       const ExploreOurWorkWidget(),
//     ]);

//     // Initially load first few widgets
//     _loadMoreWidgets();
//   }

//   void _setupScrollController() {
//     _scrollController.addListener(
//       () {
//         if (_scrollController.position.pixels >=
//             _scrollController.position.maxScrollExtent - 500) {
//           _loadMoreWidgets();
//         }
//       },
//     );
//   }

//   void _loadMoreWidgets() {
//     if (!_isLoadingMore && _lazyWidgets.length < _allWidgets.length) {
//       setState(
//         () {
//           _isLoadingMore = true;
//           final int nextIndex = _lazyWidgets.length;
//           final int itemsToLoad = math.min(2, _allWidgets.length - nextIndex);

//           _lazyWidgets
//               .addAll(_allWidgets.getRange(nextIndex, nextIndex + itemsToLoad));
//           _isLoadingMore = false;
//         },
//       );
//     }
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: cScaffoldBackground,
//       appBar: const CustomAppBarWithSearch(),
//       body: RefreshIndicator(
//         onRefresh: () async {

//         },
//         child: CustomScrollView(
//           controller: _scrollController,
//           slivers: [
//             // Always visible widgets
//             SliverToBoxAdapter(
//               child: Column(
//                 children: [
//                   const SizedBox(height: 10),
//                   const CategoryWidget(),
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.41,
//                     child: const CarouselWidget(),
//                   ),
//                   const PromotionalBanner(),
//                 ],
//               ),
//             ),

//             // Lazy loaded widgets
//             SliverList(
//               delegate: SliverChildBuilderDelegate(
//                 (context, index) {
//                   if (index < _lazyWidgets.length) {
//                     return Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 10),
//                       child: _lazyWidgets[index],
//                     );
//                   }

//                   // Show loading indicator if more items are being loaded
//                   if (_isLoadingMore) {
//                     return const Center(
//                       child: Padding(
//                         padding: EdgeInsets.all(16.0),
//                         child: CircularProgressIndicator(),
//                       ),
//                     );
//                   }

//                   return null;
//                 },
//                 childCount: _lazyWidgets.length + (_isLoadingMore ? 1 : 0),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:biotech_maali/src/module/home/home_shimmer.dart';
import 'package:biotech_maali/src/module/home/widget/promotional_banner.dart';
import 'package:shimmer/shimmer.dart';
import '../../../import.dart';
import 'dart:math' as math;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;
  final List<Widget> _lazyWidgets = [];
  final List<Widget> _allWidgets = [];

  @override
  void initState() {
    super.initState();
    _initializeWidgets();
    _setupScrollController();
    // Fetch data when screen initializes
    context.read<HomeProvider>().fetchHomeProducts();
    context.read<HomeProvider>().fetchMainCategories();
    context.read<HomeProvider>().fetchBanners();
  }

  void _initializeWidgets() {
    // Initialize all widgets that will be lazy loaded
    _allWidgets.addAll([
      const HomeProductsTileWidget(title: 'Featured'),
      const HomeProductsTileWidget(title: 'Latest'),
      const HomeProductsTileWidget(title: 'Bestseller'),
      const ReferFriendWidget(),
      const HomeProductsTileWidget(title: 'Seasonal Collection'),
      const CompoOfferWidget(),
      const YoutubeVideoplayerWidget(),
      const ExploreOurWorkWidget(),
    ]);

    // Initially load first few widgets
    _loadMoreWidgets();
  }

  void _setupScrollController() {
    _scrollController.addListener(
      () {
        if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 500) {
          _loadMoreWidgets();
        }
      },
    );
  }

  void _loadMoreWidgets() {
    if (!_isLoadingMore && _lazyWidgets.length < _allWidgets.length) {
      setState(
        () {
          _isLoadingMore = true;
          final int nextIndex = _lazyWidgets.length;
          final int itemsToLoad = math.min(2, _allWidgets.length - nextIndex);

          _lazyWidgets
              .addAll(_allWidgets.getRange(nextIndex, nextIndex + itemsToLoad));
          _isLoadingMore = false;
        },
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cScaffoldBackground,
      appBar: const CustomAppBarWithSearch(),
      body: Consumer<HomeProvider>(
        builder: (context, provider, child) {
          // Show shimmer while loading
          if (provider.isLoading || provider.isBannersLoading) {
            return const HomeShimmer();
          }

          if (provider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(provider.error!),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      provider.refreshAll();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              await provider.refreshAll();
            },
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                // Always visible widgets
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      const CategoryWidget(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.41,
                        child: const CarouselWidget(),
                      ),
                      const PromotionalBanner(),
                    ],
                  ),
                ),

                // Lazy loaded widgets
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index < _lazyWidgets.length) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: _lazyWidgets[index],
                        );
                      }

                      if (_isLoadingMore) {
                        // Show shimmer for lazy loading items
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: const ProductCardShimmer(),
                          ),
                        );
                      }

                      return null;
                    },
                    childCount: _lazyWidgets.length + (_isLoadingMore ? 1 : 0),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
