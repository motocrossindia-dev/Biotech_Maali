class CartItemModel {
  final int id;
  final int userId;
  final int productId;
  final int quantity;
  final String name;
  final String image;
  final String price;
  final String shortDescription;
  final String stockStatus;

  CartItemModel({
    required this.id,
    required this.userId,
    required this.productId,
    required this.quantity,
    required this.name,
    required this.image,
    required this.price,
    required this.shortDescription,
    required this.stockStatus,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'],
      userId: json['user_id'],
      productId: json['product_id'],
      quantity: json['quantity'],
      name: json['name'],
      image: json['image'],
      price: json['price'],
      shortDescription: json['short_description'],
      stockStatus: json['stock_status'],
    );
  }


  CartItemModel copyWith({
    int? id,
    String? name,
    String? price,
    int? quantity,
    String? image,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
      shortDescription: shortDescription ?? this.shortDescription,
      stockStatus: stockStatus ?? this.stockStatus,
    );
  }
}
