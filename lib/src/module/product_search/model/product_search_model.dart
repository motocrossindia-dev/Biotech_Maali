class ProductSearchModel {
  final int id;
  final String name;
  final double defaultSalePrice;
  final double price;
  final String image;
  final ProductRating productRating;

  ProductSearchModel({
    required this.id,
    required this.name,
    required this.defaultSalePrice,
    required this.price,
    required this.image,
    required this.productRating,
  });

  factory ProductSearchModel.fromJson(Map<String, dynamic> json) {
    return ProductSearchModel(
      id: json['id'],
      name: json['name'],
      defaultSalePrice: json['default_sale_price'].toDouble(),
      price: json['price'].toDouble(),
      image: json['image'],
      productRating: ProductRating.fromJson(json['product_rating']),
    );
  }
}

class ProductRating {
  final double avgRating;
  final int numRatings;
  final List<dynamic> starsGiven;

  ProductRating({
    required this.avgRating,
    required this.numRatings,
    required this.starsGiven,
  });

  factory ProductRating.fromJson(Map<String, dynamic> json) {
    return ProductRating(
      avgRating: json['avg_rating'].toDouble(),
      numRatings: json['num_ratings'],
      starsGiven: json['stars_given'],
    );
  }
}
