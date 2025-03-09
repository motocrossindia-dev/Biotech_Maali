import 'dart:convert';

class ProductSearchModel {
  final String message;
  final List<Product> products;

  ProductSearchModel({required this.message, required this.products});

  factory ProductSearchModel.fromJson(String source) {
    final Map<String, dynamic> json = jsonDecode(source);
    return ProductSearchModel(
      message: json['message'],
      products: (json['products'] as List).map((item) => Product.fromJson(item)).toList(),
    );
  }
}

class Product {
  final int id;
  final String name;
  final double defaultSalePrice;
  final double price;
  final String image;
  final ProductRating productRating;

  Product({
    required this.id,
    required this.name,
    required this.defaultSalePrice,
    required this.price,
    required this.image,
    required this.productRating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
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
      starsGiven: List<dynamic>.from(json['stars_given']),
    );
  }
}