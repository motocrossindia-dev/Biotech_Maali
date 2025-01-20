class ProductDetailModel {
  final String message;
  final ProductData data;

  ProductDetailModel({
    required this.message,
    required this.data,
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailModel(
      message: json['message'] ?? '',
      data: ProductData.fromJson(json['data']),
    );
  }
}

class ProductData {
  final Product product;
  final List<ProductSize> productSizes;
  final List<ProductPlanterSize> productPlanterSizes;
  final List<ProductPlanter> productPlanters;
  final List<ProductColor> productColors;
  final ProductRating? productRating; // Optional
  final List<ProductReview>? productReviews; // Optional

  ProductData({
    required this.product,
    required this.productSizes,
    required this.productPlanterSizes,
    required this.productPlanters,
    required this.productColors,
    this.productRating,
    this.productReviews,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      product: Product.fromJson(json['product']),
      productSizes: (json['product_sizes'] as List)
          .map((e) => ProductSize.fromJson(e))
          .toList(),
      productPlanterSizes: (json['product_planter_sizes'] as List)
          .map((e) => ProductPlanterSize.fromJson(e))
          .toList(),
      productPlanters: (json['product_planters'] as List)
          .map((e) => ProductPlanter.fromJson(e))
          .toList(),
      productColors: (json['product_colors'] as List)
          .map((e) => ProductColor.fromJson(e))
          .toList(),
      productRating: json['product_rating'] != null
          ? ProductRating.fromJson(json['product_rating'])
          : null,
      productReviews: json['product_reviews'] != null
          ? (json['product_reviews'] as List)
              .map((e) => ProductReview.fromJson(e))
              .toList()
          : null,
    );
  }
}

class Product {
  final int id;
  final String price;
  final List<ProductImage> images;
  final String shortDescription;
  final String mainProductName;
  final int? sizeId;
  final int? planterSizeId;
  final int? planterId;
  final int? colorId;

  Product({
    required this.id,
    required this.price,
    required this.images,
    required this.shortDescription,
    required this.mainProductName,
    this.sizeId,
    this.planterSizeId,
    this.planterId,
    this.colorId,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      price: json['price'] ?? '',
      images: (json['images'] as List)
          .map((e) => ProductImage.fromJson(e))
          .toList(),
      shortDescription: json['short_description'] ?? '',
      mainProductName: json['main_product_name'] ?? '',
      sizeId: json['size_id'],
      planterSizeId: json['planter_size_id'],
      planterId: json['planter_id'],
      colorId: json['color_id'],
    );
  }
}

class ProductImage {
  final String image;

  ProductImage({required this.image});

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(image: json['image'] ?? '');
  }
}

class ProductSize {
  final int id;
  final String name;
  final String size;

  ProductSize({
    required this.id,
    required this.name,
    required this.size,
  });

  factory ProductSize.fromJson(Map<String, dynamic> json) {
    return ProductSize(
      id: json['id'],
      name: json['name'],
      size: json['size'],
    );
  }
}

class ProductPlanterSize {
  final int id;
  final String name;
  final String size;

  ProductPlanterSize({
    required this.id,
    required this.name,
    required this.size,
  });

  factory ProductPlanterSize.fromJson(Map<String, dynamic> json) {
    return ProductPlanterSize(
      id: json['id'],
      name: json['name'],
      size: json['size'],
    );
  }
}

class ProductPlanter {
  final int id;
  final String name;

  ProductPlanter({
    required this.id,
    required this.name,
  });

  factory ProductPlanter.fromJson(Map<String, dynamic> json) {
    return ProductPlanter(
      id: json['id'],
      name: json['name'],
    );
  }
}

class ProductColor {
  final int id;
  final String colorName;
  final String colorCode;

  ProductColor({
    required this.id,
    required this.colorName,
    required this.colorCode,
  });

  factory ProductColor.fromJson(Map<String, dynamic> json) {
    return ProductColor(
      id: json['id'],
      colorName: json['color_name'],
      colorCode: json['color_code'],
    );
  }
}

class ProductRating {
  final double avgRating;
  final int numRatings;
  final List<StarRating> starsGiven;

  ProductRating({
    required this.avgRating,
    required this.numRatings,
    required this.starsGiven,
  });

  factory ProductRating.fromJson(Map<String, dynamic> json) {
    return ProductRating(
      avgRating: (json['avg_rating'] as num).toDouble(),
      numRatings: json['num_ratings'],
      starsGiven: (json['stars_given'] as List)
          .map((e) => StarRating.fromJson(e))
          .toList(),
    );
  }
}

class StarRating {
  final double roundedRating;
  final int count;

  StarRating({
    required this.roundedRating,
    required this.count,
  });

  factory StarRating.fromJson(Map<String, dynamic> json) {
    return StarRating(
      roundedRating: (json['rounded_rating'] as num).toDouble(),
      count: json['count'],
    );
  }
}

class ProductReview {
  final int id;
  final int userId;
  final String userName;
  final String productReview;
  final String date;
  final double latestRating;

  ProductReview({
    required this.id,
    required this.userId,
    required this.userName,
    required this.productReview,
    required this.date,
    required this.latestRating,
  });

  factory ProductReview.fromJson(Map<String, dynamic> json) {
    return ProductReview(
      id: json['id'],
      userId: json['user_id'],
      userName: json['user_name'],
      productReview: json['product_review'],
      date: json['date'],
      latestRating: (json['latest_rating'] as num).toDouble(),
    );
  }
}
