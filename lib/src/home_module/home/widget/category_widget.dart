// import '../../../../import.dart';

// class CategoryWidget extends StatelessWidget {
//   const CategoryWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.transparent,
//       height: 130, // Specify a fixed height
//       child: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         physics: const BouncingScrollPhysics(),
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Row(
//             children: [
//               //Plants ***********************************************************//
//               sizedBoxWidth10,
//               InkWell(
//                 onTap: () {},
//                 child: Column(
//                   children: [
//                     SvgPicture.asset(
//                       'assets/svg/category/plants_category.svg',
//                       height: 81,
//                       width: 81,
//                     ),
//                     sizedBoxHeight10,
//                     Text(
//                       'PLANTS',
//                       style: GoogleFonts.poppins(
//                           fontSize: 12, fontWeight: FontWeight.w500),
//                       textAlign: TextAlign.center,
//                     )
//                   ],
//                 ),
//               ),

//               //Plant Care ***********************************************************//
//               sizedBoxWidth20,
//               InkWell(
//                 onTap: () {},
//                 child: Column(
//                   children: [
//                     Container(
//                       height: 80.8,
//                       width: 80.8,
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: cCategoryCircleBorder,
//                           width: 1.6,
//                         ),
//                         shape: BoxShape.circle,
//                         color: cAppBackround,
//                       ),
//                       child: SvgPicture.asset(
//                         'assets/svg/category/plant_care_category.svg',
//                         height: 81,
//                         width: 81,
//                       ),
//                     ),
//                     sizedBoxHeight10,
//                     Text(
//                       'PLANT CARE',
//                       style: GoogleFonts.poppins(
//                           fontSize: 12, fontWeight: FontWeight.w500),
//                       textAlign: TextAlign.center,
//                     )
//                   ],
//                 ),
//               ),

//               //Pots ***********************************************************//
//               sizedBoxWidth20,
//               InkWell(
//                 onTap: () {},
//                 child: Column(
//                   children: [
//                     Container(
//                       height: 80.8,
//                       width: 80.8,
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: cCategoryCircleBorder,
//                           width: 1.6,
//                         ),
//                         shape: BoxShape.circle,
//                         color: cAppBackround,
//                       ),
//                       child: Center(
//                         child: SvgPicture.asset(
//                           'assets/svg/category/pots_category.svg',
//                           fit: BoxFit.contain,
//                           height: 62.14,
//                           width: 64.8,
//                         ),
//                       ),
//                     ),
//                     sizedBoxHeight10,
//                     Text(
//                       'POTS',
//                       style: GoogleFonts.poppins(
//                           fontSize: 12, fontWeight: FontWeight.w500),
//                       textAlign: TextAlign.center,
//                     )
//                   ],
//                 ),
//               ),

//               //Plant Seeds ***********************************************************//
//               sizedBoxWidth20,
//               InkWell(
//                 onTap: () {},
//                 child: Column(
//                   children: [
//                     Container(
//                       height: 80.8,
//                       width: 80.8,
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: cCategoryCircleBorder,
//                           width: 1.6,
//                         ),
//                         shape: BoxShape.circle,
//                         color: cAppBackround,
//                       ),
//                       child: Center(
//                         child: SvgPicture.asset(
//                           'assets/svg/category/plant_seeds_category.svg',
//                           fit: BoxFit.contain,
//                           height: 75,
//                           width: 75,
//                         ),
//                       ),
//                     ),
//                     sizedBoxHeight10,
//                     Text(
//                       'PLANT SEEDS',
//                       style: GoogleFonts.poppins(
//                           fontSize: 12, fontWeight: FontWeight.w500),
//                       textAlign: TextAlign.center,
//                     )
//                   ],
//                 ),
//               ),

//               //Gifts ***********************************************************//
//               sizedBoxWidth20,
//               InkWell(
//                 onTap: () {},
//                 child: Column(
//                   children: [
//                     Container(
//                       height: 80.8,
//                       width: 80.8,
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: cCategoryCircleBorder,
//                           width: 1.6,
//                         ),
//                         shape: BoxShape.circle,
//                         color: cAppBackround,
//                       ),
//                       child: Center(
//                         child: SvgPicture.asset(
//                           'assets/svg/category/gifts_category.svg',
//                           fit: BoxFit.contain,
//                           height: 37.14,
//                           width: 37.8,
//                         ),
//                       ),
//                     ),
//                     sizedBoxHeight10,
//                     Text(
//                       'GIFTS',
//                       style: GoogleFonts.poppins(
//                           fontSize: 12, fontWeight: FontWeight.w500),
//                       textAlign: TextAlign.center,
//                     )
//                   ],
//                 ),
//               ),

//               //Offers ***********************************************************//
//               sizedBoxWidth20,
//               InkWell(
//                 onTap: () {},
//                 child: Column(
//                   children: [
//                     Container(
//                       height: 80.8,
//                       width: 80.8,
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: cCategoryCircleBorder,
//                           width: 1.6,
//                         ),
//                         shape: BoxShape.circle,
//                         color: cAppBackround,
//                       ),
//                       child: Center(
//                         child: SvgPicture.asset(
//                           'assets/svg/category/offers_category.svg',
//                           fit: BoxFit.contain,
//                           height: 68,
//                           width: 68,
//                         ),
//                       ),
//                     ),
//                     sizedBoxHeight10,
//                     Text(
//                       'OFFERS',
//                       style: GoogleFonts.poppins(
//                           fontSize: 12, fontWeight: FontWeight.w500),
//                       textAlign: TextAlign.center,
//                     )
//                   ],
//                 ),
//               ),
//               sizedBoxWidth20,
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

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
                        builder: (context) => const ExploreScreen(),
                      ),
                    );
                    break;
                  case 1:
                    log('Plant Care');
                    break;
                  case 2:
                    log('Pots');
                    break;
                  case 3:
                    log('Plant Seeds');
                    break;
                  case 4:
                    log('Gifts');
                    break;
                  case 5:
                    log('Offers');
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
