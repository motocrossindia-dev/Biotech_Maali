import '../../../import.dart';
import 'dart:math' as math;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Controller for lazy loading
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;

  // Lazy loaded widgets
  final List<Widget> _lazyWidgets = [];
  final List<Widget> _allWidgets = [];

  @override
  void initState() {
    super.initState();
    _initializeWidgets();
    _setupScrollController();
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
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 500) {
        _loadMoreWidgets();
      }
    });
  }

  void _loadMoreWidgets() {
    if (!_isLoadingMore && _lazyWidgets.length < _allWidgets.length) {
      setState(() {
        _isLoadingMore = true;
        final int nextIndex = _lazyWidgets.length;
        final int itemsToLoad = math.min(2, _allWidgets.length - nextIndex);

        _lazyWidgets
            .addAll(_allWidgets.getRange(nextIndex, nextIndex + itemsToLoad));
        _isLoadingMore = false;
      });
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
      body: RefreshIndicator(
        onRefresh: () async {
          // Implement refresh logic if needed
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
                  // Wrap CarouselWidget in CachedNetworkImage
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.45,
                    child: const CarouselWidget(),
                  ),
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

                  // Show loading indicator if more items are being loaded
                  if (_isLoadingMore) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(),
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
      ),
    );
  }
}
