class HomeProductModel {
  final int id;
  final String name;
  final bool isFeatured;
  final bool isBestSeller;
  final bool isSeasonalCollection;
  final bool isTrending;
  final bool isCart;
   bool isWishlist;
  final String? image;
  final double price;

  HomeProductModel({
    required this.id,
    required this.name,
    required this.isFeatured,
    required this.isBestSeller,
    required this.isSeasonalCollection,
    required this.isTrending,
    required this.isCart,
    required this.isWishlist,
    this.image,
    required this.price,
  });

  String? getFullImageUrl() {
    if (image == null) return null;
    const baseUrl = 'http://www.dev.back.biotechmaali.com:8000';
    return '$baseUrl$image';
  }

  factory HomeProductModel.fromJson(Map<String, dynamic> json) {
    return HomeProductModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      isFeatured: json['is_featured'] ?? false,
      isBestSeller: json['is_best_seller'] ?? false,
      isSeasonalCollection: json['is_seasonal_collection'] ?? false,
      isTrending: json['is_trending'] ?? false,
      isCart: json['is_cart'] ?? false,
      isWishlist: json['is_wishlist'] ?? false,
      image: json['image'],
      price: (json['price'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'is_featured': isFeatured,
        'is_best_seller': isBestSeller,
        'is_seasonal_collection': isSeasonalCollection,
        'is_trending': isTrending,
        'is_cart': isCart,
        'is_wishlist': isWishlist,
        'image': image,
        'price': price,
      };
}
