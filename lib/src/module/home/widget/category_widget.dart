import 'package:biotech_maali/src/module/home/model/category_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../import.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 125,
      child: Consumer<HomeProvider>(
        builder: (context, provider, child) {
          const baseUrl = BaseUrl.baseUrlForImages;
          List<MainCategoryModel> maincategories = provider.maincategories;
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: maincategories.length,
            itemBuilder: (context, index) {
              final category = maincategories[index];
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: () {
                    
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductListScreen(
                          title: category.name,
                          products: const [],
                        ),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: SizedBox(
                          height: 70,
                          width: 70,
                          child: CachedNetworkImage(
                            imageUrl: '$baseUrl${category.image}',
                            fit: BoxFit.fill,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        category.name,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
