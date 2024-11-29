import 'package:biotech_maali/src/module/filters/widgets/plant_location_filter_widget.dart';

import '../../../import.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  // String selectedCategory = "Type of Plants";
  // Map<String, int> itemCounts = {
  //   "Air Plant": 15,
  //   "Flowering Plants": 15,
  //   "Focal Plants": 5,
  //   "Ground Covers": 43,
  //   "Hedge Plants": 23,
  //   "Screen Plants": 3,
  //   "Shrub Plants": 42,
  // };

  @override
  Widget build(BuildContext context) {
    final filtersProviderWatch = context.watch<FiltersProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Filters (16960 Products)",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left side filter categories
          Consumer<FiltersProvider>(
            builder: (context, provider, child) {
              return Container(
                width:
                    MediaQuery.of(context).size.width * 0.35, // Reduced width
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: ListView(
                  children: [
                    FilterCategoryItem(
                      title: "Type of Plants",
                      isSelected: provider.selectedCategory == "Type of Plants",
                      onTap: () {
                        provider.setSelectedCategory('Type of Plants');
                      },
                    ),
                    FilterCategoryItem(
                      title: "Price",
                      isSelected: provider.selectedCategory == "Price",
                      onTap: () {
                        provider.setSelectedCategory('Price');
                      },
                    ),
                    FilterCategoryItem(
                      title: "Ideal Plants\nLocation", // Added line break
                      isSelected:
                          provider.selectedCategory == "Ideal Plants Location",
                      onTap: () {
                        provider.setSelectedCategory('Ideal Plants Location');
                      },
                    ),
                    FilterCategoryItem(
                      title: "Indoor/Outdoor",
                      isSelected: provider.selectedCategory == "Indoor/Outdoor",
                      onTap: () {
                        provider.setSelectedCategory('Indoor/Outdoor');
                      },
                    ),
                    FilterCategoryItem(
                      title: "Pot Size",
                      isSelected: provider.selectedCategory == "Pot Size",
                      onTap: () {
                        provider.setSelectedCategory('Pot Size');
                      },
                    ),
                    FilterCategoryItem(
                      title: "Color",
                      isSelected: provider.selectedCategory == "Color",
                      onTap: () {
                        provider.setSelectedCategory('Color');
                      },
                    ),
                    FilterCategoryItem(
                      title: "Size",
                      isSelected: provider.selectedCategory == "Size",
                      onTap: () {
                        provider.setSelectedCategory('Size');
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          // Vertical Divider
          Container(
            width: 1,
            color: Colors.grey[300],
          ),
          // Right side filter content
          Expanded(
            child: Container(
              color: Colors.white,
              child: filtersProviderWatch.selectedCategory == "Type of Plants"
                  ? const TypeOfPlantsWidget()
                  : filtersProviderWatch.selectedCategory == "Price"
                      ? const PriceWidget()
                      : filtersProviderWatch.selectedCategory ==
                              "Ideal Plants Location"
                          ? const PlantLocationFilter()
                          : filtersProviderWatch.selectedCategory ==
                                  "Indoor/Outdoor"
                              ? const IndoorOutdoorWidget()
                              : filtersProviderWatch.selectedCategory ==
                                  "Pot Size"?
                                  const PotSizeWidget()
                              : const Center(
                                  child:
                                      Text("Select a filter to view options")),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey[300]!, width: 1),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  context.read<FiltersProvider>().resetAllFilters();
                  
                  // Clear filter action
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: cButtonGreen),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: Text(
                  "CLEAR",
                  style: TextStyle(
                    color: cButtonGreen,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Apply filter action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: cButtonGreen,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: const Text(
                  "APPLY",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
