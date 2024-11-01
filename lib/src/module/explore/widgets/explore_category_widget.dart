import 'dart:developer';
import '../../../../import.dart';

class ExploreCategoryWidget extends StatelessWidget {
  const ExploreCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final exploreProvider = context.read<ExploreProvider>();
    final exploreProviderWatch = context.watch<ExploreProvider>();
    final List<Map<String, String>> categories = [
      {'icon': 'assets/svg/category/plants_category.svg', 'title': 'PLANTS'},
      {
        'icon': 'assets/svg/category/plant_care_category.svg',
        'title': 'PLANT CARE'
      },
      {'icon': 'assets/svg/category/pots_category.svg', 'title': 'POTS'},
      {
        'icon': 'assets/svg/category/plant_seeds_category.svg',
        'title': 'PLANT SEEDS'
      },
      {'icon': 'assets/svg/category/gifts_category.svg', 'title': 'GIFTS'},
      {'icon': 'assets/svg/category/offers_category.svg', 'title': 'OFFERS'},
    ];

    return Container(
      color: cCategoryUnselected,
      height: 145,
      child: ListView.separated(
        scrollDirection: Axis.vertical,
        itemCount: categories.length,
        // Separator builder
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        // Item builder
        itemBuilder: (context, index) {
          final category = categories[index];
          return InkWell(
            onTap: () {
              switch (index) {
                case 0:
                  log('Plants');
                  exploreProvider.setSelectedIndex(index);
                  break;
                case 1:
                  log('Plant Care');
                  exploreProvider.setSelectedIndex(index);
                  break;
                case 2:
                  log('Pots');
                  exploreProvider.setSelectedIndex(index);
                  break;
                case 3:
                  log('Plant Seeds');
                  exploreProvider.setSelectedIndex(index);
                  break;
                case 4:
                  log('Gifts');
                  exploreProvider.setSelectedIndex(index);
                  break;
                case 5:
                  log('Offers');
                  exploreProvider.setSelectedIndex(index);
                  break;
                default:
                  log('Unknown category');
              }
            },
            child: Container(
              color: exploreProviderWatch.selectedCategoryIndex == index
                  ? cCategoryMainBackground
                  : cCategoryUnselected,
              // padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Centers horizontally in the Row
                children: [
                  exploreProviderWatch.selectedCategoryIndex == index
                      ? Container(
                          height: 105,
                          width: 8,
                          color: cButtonGreen,
                        )
                      : sizedBoxWidth0,
                  Expanded(
                    // Add Expanded to ensure proper centering
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // Centers vertically
                      crossAxisAlignment:
                          CrossAxisAlignment.center, // Centers horizontally
                      children: [
                        sizedBoxHeight10,
                        Center(
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              border: Border.all(color: cExploreCategory),
                              borderRadius: BorderRadius.circular(10),
                              color:
                                  exploreProviderWatch.selectedCategoryIndex ==
                                          index
                                      ? cScaffoldBackground
                                      : cExploreCategory,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: SvgPicture.asset(
                                  category['icon'] ?? '',
                                  fit: BoxFit.contain,
                                  height: 60,
                                  width: 60,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          category['title'] ?? '',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight:
                                exploreProviderWatch.selectedCategoryIndex ==
                                        index
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
