// class ProductDetailModel {
//   final String message;
//   final ProductData data;

//   ProductDetailModel({
//     required this.message,
//     required this.data,
//   });

//   factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
//     return ProductDetailModel(
//       message: json['message'],
//       data: ProductData.fromJson(json['data']),
//     );
//   }
// }

// class ProductData {
//   final Product product;
//   final List<ProductSize> productSizes;
//   final List<ProductPlanterSize> productPlanterSizes;
//   final List<ProductPlanter> productPlanters;
//   final List<ProductColor> productColors;

//   ProductData({
//     required this.product,
//     required this.productSizes,
//     required this.productPlanterSizes,
//     required this.productPlanters,
//     required this.productColors,
//   });

//   factory ProductData.fromJson(Map<String, dynamic> json) {
//     return ProductData(
//       product: Product.fromJson(json['product']),
//       productSizes: (json['product_sizes'] as List)
//           .map((e) => ProductSize.fromJson(e))
//           .toList(),
//       productPlanterSizes: (json['product_planter_sizes'] as List)
//           .map((e) => ProductPlanterSize.fromJson(e))
//           .toList(),
//       productPlanters: (json['product_planters'] as List)
//           .map((e) => ProductPlanter.fromJson(e))
//           .toList(),
//       productColors: (json['product_colors'] as List)
//           .map((e) => ProductColor.fromJson(e))
//           .toList(),
//     );
//   }
// }

// class Product {
//   final String price;
//   final int? sizeId;
//   final int? planterSizeId;
//   final int? planterId;
//   final int? colorId;

//   Product({
//     required this.price,
//     this.sizeId,
//     this.planterSizeId,
//     this.planterId,
//     this.colorId,
//   });

//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       price: json['price'] ?? '',
//       sizeId: json['size_id'],
//       planterSizeId: json['planter_size_id'],
//       planterId: json['planter_id'],
//       colorId: json['color_id'],
//     );
//   }
// }

// class ProductSize {
//   final int id;
//   final String name;
//   final String size;

//   ProductSize({
//     required this.id,
//     required this.name,
//     required this.size,
//   });

//   factory ProductSize.fromJson(Map<String, dynamic> json) {
//     return ProductSize(
//       id: json['id'],
//       name: json['name'],
//       size: json['size'],
//     );
//   }
// }

// class ProductPlanterSize {
//   final int id;
//   final String name;
//   final String size;

//   ProductPlanterSize({
//     required this.id,
//     required this.name,
//     required this.size,
//   });

//   factory ProductPlanterSize.fromJson(Map<String, dynamic> json) {
//     return ProductPlanterSize(
//       id: json['id'],
//       name: json['name'],
//       size: json['size'],
//     );
//   }
// }

// class ProductPlanter {
//   final int id;
//   final String name;

//   ProductPlanter({
//     required this.id,
//     required this.name,
//   });

//   factory ProductPlanter.fromJson(Map<String, dynamic> json) {
//     return ProductPlanter(
//       id: json['id'],
//       name: json['name'],
//     );
//   }
// }

// class ProductColor {
//   final int id;
//   final String colorName;
//   final String colorCode;

//   ProductColor({
//     required this.id,
//     required this.colorName,
//     required this.colorCode,
//   });

//   factory ProductColor.fromJson(Map<String, dynamic> json) {
//     return ProductColor(
//       id: json['id'],
//       colorName: json['color_name'],
//       colorCode: json['color_code'],
//     );
//   }
// }
