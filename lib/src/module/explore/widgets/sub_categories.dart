import '../../../../import.dart';

class SubCategories extends StatelessWidget {
  const SubCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExploreProvider>(
      builder: (context, provider, child) {
         // Get the categories map from provider
        Map<String, Map<String, dynamic>> categories = provider.categories;
        // Get the keys (category names) in a list
        List<String> categoryKeys = categories.keys.toList();
        // Get the selected category based on the selected index
        String selectedCategoryKey = categoryKeys[provider.selectedCategoryIndex];
        Map<String, dynamic>? selectedCategory = categories[selectedCategoryKey];
        List<dynamic> items = selectedCategory?["items"];

        return
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of items per row
                childAspectRatio: 0.75, // Adjust this for item height
                crossAxisSpacing: 10, // Horizontal spacing between items
                mainAxisSpacing: 10, // Vertical spacing between items
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final gridItem = items[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: InkWell(
                    onTap: () {
                      // When tapped, handle dynamic API request or navigation
                      // String apiUrl = gridItem['api'];
                      // print('API URL for ${gridItem['name']}: $apiUrl');
                      // You can navigate to another screen or fetch the API dynamically here.
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductListScreen(title: 'Plants',),));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 6, left: 6, right: 6),
                            child: Container(
                              decoration: BoxDecoration(
                                color: cExploreCategory, // Placeholder color
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(8),
                                  bottom: Radius.circular(8),
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    gridItem['image'],
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                gridItem['name'],
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,

                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
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
          ),
        );
      },
    );
  }
}
