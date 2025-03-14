class ProductSearchModel {
  final int id;
  final String name;
  final bool isCart;
  final bool isWishlist;
  final double mrp;
  final double price;
  final String image;
  final ProductRating productRating;

  ProductSearchModel({
    required this.id,
    required this.name,
    required this.isCart,
    required this.isWishlist,
    required this.mrp,
    required this.price,
    required this.image,
    required this.productRating,
  });

  factory ProductSearchModel.fromJson(Map<String, dynamic> json) {
    return ProductSearchModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      isCart: json['is_cart'] ?? false,
      isWishlist: json['is_wishlist'] ?? false,
      mrp: (json['mrp'] as num?)?.toDouble() ?? 0.0,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      image: json['image'] ?? '',
      productRating: ProductRating.fromJson(json['product_rating'] ?? {}),
    );
  }
}

class ProductRating {
  final double avgRating;
  final int numRatings;

  ProductRating({
    required this.avgRating,
    required this.numRatings,
  });

  factory ProductRating.fromJson(Map<String, dynamic> json) {
    return ProductRating(
      avgRating: (json['avg_rating'] as num?)?.toDouble() ?? 0.0,
      numRatings: json['num_ratings'] ?? 0,
    );
  }
}