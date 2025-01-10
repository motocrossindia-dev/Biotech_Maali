class ProductModel {
  final int id;
  final String name;
  final bool isFeatured;
  final bool isBestSeller;
  final bool isSeasonalCollection;
  final bool isTrending;
  final String? image;  // Changed from List<ProductImage> to String?
  final String price;

  ProductModel({
    required this.id,
    required this.name,
    required this.isFeatured,
    required this.isBestSeller,
    required this.isSeasonalCollection,
    required this.isTrending,
    this.image,  // Made nullable
    required this.price,
  });

  String? getFullImageUrl() {
    if (image == null) return null;
    const baseUrl = 'http://www.dev.back.biotechmaali.com:8000'; // Replace with your actual base URL
    return '$baseUrl$image';
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      isFeatured: json['is_featured'] ?? false,
      isBestSeller: json['is_best_seller'] ?? false,
      isSeasonalCollection: json['is_seasonal_collection'] ?? false,
      isTrending: json['is_trending'] ?? false,
      image: json['image'],  // Already nullable in the API
      price: json['price']?.toString() ?? '0',
    );
  }
}

// You can remove the ProductImage class as it's no longer needed