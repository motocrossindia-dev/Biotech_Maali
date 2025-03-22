class ProductListModel {
  final String message;
  final List<Product> products;

  ProductListModel({
    required this.message,
    required this.products,
  });

  factory ProductListModel.fromJson(Map<String, dynamic> json) {
    return ProductListModel(
      message: json['message'] ?? '',
      products: (json['products'] as List)
          .map((productJson) => Product.fromJson(productJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'products': products.map((product) => product.toJson()).toList(),
    };
  }
}

class Product {
  final int id;
  final String name;
  final double mrp;
  final double sellingPrice;
  final String image;
  final ProductRating productRating;

  Product({
    required this.id,
    required this.name,
    required this.mrp,
    required this.sellingPrice,
    required this.image,
    required this.productRating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      mrp: (json['mrp'] ?? 0.0).toDouble(),
      sellingPrice: (json['selling_price'] ?? 0.0).toDouble(),
      image: json['image'] ?? '',
      productRating: ProductRating.fromJson(json['product_rating'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'mrp': mrp,
      'selling_price': sellingPrice,
      'image': image,
      'product_rating': productRating.toJson(),
    };
  }
}

class ProductRating {
  final double avgRating;
  final int numRatings; // Changed from double to int

  ProductRating({
    required this.avgRating,
    required this.numRatings,
  });

  factory ProductRating.fromJson(Map<String, dynamic> json) {
    return ProductRating(
      avgRating:
          (json['avg_rating'] ?? 0).toDouble(), // Ensure conversion to double
      numRatings: json['num_ratings'] ?? 0, // No conversion needed for int
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'avg_rating': avgRating,
      'num_ratings': numRatings,
    };
  }
}
