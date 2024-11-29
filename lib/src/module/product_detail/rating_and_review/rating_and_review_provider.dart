import 'package:biotech_maali/import.dart';

class RatingAndReviewProvider extends ChangeNotifier {
  RatingAndReviewProvider(){
    calculateAverageRating();
  }
   bool showReviews = false;

  final List<Map<String, dynamic>> reviews = [
    {
      'name': 'Karan',
      'date': '27/07/2024',
      'rating': 3,
      'isVerified': true,
      'title': "It's good",
      'content':
          'Received it in a well packed box. The plant was healthy and lovely to watch. But what I feel negative is that, the quality of plant holding pot could have been better.',
    },
    // Duplicate reviews for demo
    {
      'name': 'Karan',
      'date': '27/07/2024',
      'rating': 3,
      'isVerified': true,
      'title': "It's good",
      'content':
          'Received it in a well packed box. The plant was healthy and lovely to watch. But what I feel negative is that, the quality of plant holding pot could have been better.',
    },
    {
      'name': 'Karan',
      'date': '27/07/2024',
      'rating': 3,
      'isVerified': true,
      'title': "It's good",
      'content':
          'Received it in a well packed box. The plant was healthy and lovely to watch. But what I feel negative is that, the quality of plant holding pot could have been better.',
    },
    {
      'name': 'Karan',
      'date': '27/07/2024',
      'rating': 3,
      'isVerified': true,
      'title': "It's good",
      'content':
          'Received it in a well packed box. The plant was healthy and lovely to watch. But what I feel negative is that, the quality of plant holding pot could have been better.',
    },
    {
      'name': 'Karan',
      'date': '27/07/2024',
      'rating': 3,
      'isVerified': true,
      'title': "It's good",
      'content':
          'Received it in a well packed box. The plant was healthy and lovely to watch. But what I feel negative is that, the quality of plant holding pot could have been better.',
    },
  ];

  final Map<int, int> ratingDistribution = {
    5: 40,
    4: 15,
    3: 8,
    2: 2,
    1: 1,
  };

  double averageRating =0.0;

  setShowRieviews() {
    showReviews = !showReviews;
    notifyListeners();
  }

    calculateAverageRating() {
    int totalRatings = 0;
    int weightedSum = 0;
    ratingDistribution.forEach((rating, count) {
      totalRatings += count;
      weightedSum += rating * count;
    });

    averageRating = weightedSum / totalRatings;
     
  }
}