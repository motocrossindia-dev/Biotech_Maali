import '../../../../../import.dart';

class ProductDetailsRatingWidget extends StatelessWidget {
  final double rating;
  const ProductDetailsRatingWidget({required this.rating, super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        // Display rating stars using RatingBarIndicator
        RatingBarIndicator(
          rating: rating, // Set the current rating value here
          itemBuilder: (context, index) => SvgPicture.asset(
            'assets/svg/icons/star_rating.svg',
            color: cButtonGreen,
          ),
          itemCount: 5, // Total number of stars
          itemSize: 18.0, // Size of each star
          direction: Axis.horizontal,
        ),
      ],
    );
  }
}