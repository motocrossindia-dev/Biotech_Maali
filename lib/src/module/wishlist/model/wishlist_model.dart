// wishlist_model.dart

class WishlistModel {
  final int id;
  final int userId;
  final int productId;
  final String name;
  final String image;
  final String price;
  final String stockStatus;

  WishlistModel({
    required this.id,
    required this.userId,
    required this.productId,
    required this.name,
    required this.image,
    required this.price,
    required this.stockStatus,
  });

  factory WishlistModel.fromJson(Map<String, dynamic> json) {
    return WishlistModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      productId: json['product_id'] ?? 0,
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      price: json['price'].toString(),
      stockStatus: json['stock_status'] ?? '',
    );
  }
}

class WishlistResponse {
  final String message;
  final List<WishlistModel> wishlists;

  WishlistResponse({
    required this.message,
    required this.wishlists,
  });

  factory WishlistResponse.fromJson(Map<String, dynamic> json) {
    // Get the data object first
    final data = json['data'] as Map<String, dynamic>;
    
    // Now get the wishlists array from the data object
    final wishlistsJson = data['wishlists'] as List;
    
    return WishlistResponse(
      message: json['message'] ?? '',
      wishlists: wishlistsJson
          .map((wishlist) => WishlistModel.fromJson(wishlist))
          .toList(),
    );
  }
}