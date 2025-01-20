import 'package:biotech_maali/import.dart';
import 'package:biotech_maali/src/module/product_detail/product_details_/model/product_details_model.dart';

class RatingsAndReviews extends StatelessWidget {
  final ProductData productData;

  const RatingsAndReviews({required this.productData, super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RatingAndReviewProvider(productData: productData),
      child: const RatingsAndReviewsContent(),
    );
  }
}

class RatingsAndReviewsContent extends StatelessWidget {
  const RatingsAndReviewsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        shadowColor: Colors.black,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: const CommonTextWidget(
          title: 'Ratings & Reviews',
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 40.0),
            child: Icon(Icons.search, size: 30),
          ),
        ],
      ),
      body: Consumer<RatingAndReviewProvider>(
        builder: (context, provider, child) {
          if (provider.productData?.productRating == null) {
            return const Center(child: Text('No ratings available'));
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Rating Summary
              Row(
                children: [
                  Text(
                    provider.averageRating.toStringAsFixed(1),
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      children: provider.ratingDistribution.entries
                          .map((entry) => _buildRatingBar(
                                entry.key,
                                entry.value,
                                provider.totalRatings,
                              ))
                          .toList()
                          .reversed
                          .toList(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              Center(
                child: Text(
                  '${provider.totalRatings} Ratings & ${provider.reviews.length} Reviews',
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(height: 16),

              // Write Review Button
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProductRatingScreen(),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: cButtonGreen,
                  side: BorderSide(color: cButtonGreen),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: const Text('Write a review'),
              ),
              const SizedBox(height: 16),

              // Most Recent Toggle
              if (provider.reviews.isNotEmpty) ...[
                OutlinedButton(
                  onPressed: () => provider.setShowReviews(),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: cButtonGreen,
                    side: BorderSide(color: cButtonGreen),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Most Recent'),
                        sizedBoxWidth5,
                        Icon(
                          provider.showReviews
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          size: 25,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Reviews List
                if (provider.showReviews)
                  ...provider.reviews.map((review) => _buildReviewCard(review)),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _buildRatingBar(int rating, int count, int total) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text('$rating'),
          const SizedBox(width: 4),
          const Icon(Icons.star, size: 16, color: Colors.amber),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: total > 0 ? count / total : 0,
                backgroundColor: Colors.grey[200],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                minHeight: 8,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(ProductReview review) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey[200],
                child: Text(review.userName[0]),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          review.userName,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          review.date,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Row(
                          children: List.generate(
                            5,
                            (index) => Icon(
                              Icons.star,
                              size: 16,
                              color: index < review.latestRating
                                  ? Colors.amber
                                  : Colors.grey[300],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(review.productReview),
          const Divider(height: 32),
        ],
      ),
    );
  }
}
