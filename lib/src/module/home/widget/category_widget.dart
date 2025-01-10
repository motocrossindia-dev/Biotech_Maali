

import 'dart:developer';
import '../../../../import.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
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

    return SizedBox(
      height: 145,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () {
                switch (index) {
                  case 0:
                    log('Plants');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  const ProductListScreen(title: 'Plants',products: [],),
                      ),
                    );
                    break;
                  case 1:
                    log('Plant Care');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  const ProductListScreen(title: 'Plant Care',products: [],),
                      ),
                    );

                    break;
                  case 2:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  const ProductListScreen(title: 'Pots',products: [],),
                      ),
                    );
                    log('Pots');
                    break;
                  case 3:
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  const ProductListScreen(title: 'Plant Seeds',products: [],),
                      ),
                    );
                    log('Plant Seeds');
                    break;
                  case 4:
                    log('Gifts');
                     Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  const ProductListScreen(title: 'Gifts',products: [],),
                      ),
                    );
                    break;
                  case 5:
                    log('Offers');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  const ProductListScreen(title: 'Offers',products: [],),
                      ),
                    );
                    break;
                  default:
                    log('Unknown category');
                }
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: cCategoryCircleBorder,
                        width: 1.6,
                      ),
                      shape: BoxShape.circle,
                      color: cAppBackround,
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        category['icon'] ?? '',
                        fit: BoxFit.contain,
                        height: 60,
                        width: 60,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    category['title'] ?? '',
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
      ),
    );
  }
}
