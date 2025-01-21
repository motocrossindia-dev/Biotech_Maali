import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:biotech_maali/src/module/product_detail/product_details_/model/product_details_model.dart';
import 'package:biotech_maali/core/core.dart';

import '../../../../import.dart';

class ProductDetailsRepository {
  final Dio _dio = Dio();
  // final String _baseUrl = 'http://www.dev.back.biotechmaali.com:8000';

  Future<ProductDetailModel> fetchProductDetails(int productId) async {
    try {
      final response =
          await _dio.get('${EndUrl.getProductDetailsUrl}$productId');

      if (response.statusCode == 200) {
        log("Product details response: ${response.data}");
        return ProductDetailModel.fromJson(response.data);
      } else {
        log('Failed to get product details: ${response.statusMessage}');
        throw Exception('Failed to load product details');
      }
    } catch (e) {
      log("Error fetching product details: $e");
      throw Exception('Error fetching product details: $e');
    }
  }

  Future<ProductDetailModel> filterProduct({
    required int productId,
    int? sizeId,
    int? planterSizeId,
    int? planterId,
    int? colorId,
  }) async {
    try {
      final queryParams = {
        if (sizeId != null) 'size_id': sizeId.toString(),
        if (planterSizeId != null) 'planter_size_id': planterSizeId.toString(),
        if (planterId != null) 'planter_id': planterId.toString(),
        if (colorId != null) 'color_id': colorId.toString(),
      };

      log("Filter params: $queryParams");
      log("Product id: $productId");

      final response = await _dio.get(
        '${EndUrl.filterProductUrl}$productId',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        log("Filter response: ${response.data}");
        return ProductDetailModel.fromJson(response.data);
      } else {
        throw Exception('Failed to filter product');
      }
    } catch (e) {
      log("Error filtering product: $e");
      throw Exception('Error filtering product: $e');
    }
  }

  Future<bool> addOrRemoveWhishlistCompinationProduct(int productId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("access_token");

    log("product id in remove wishist: $productId  Token: $token");
    try {
      final response = await _dio.post(
        EndUrl.addOrRemoveWishListUrl,
        data: {"prod_id": productId},
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
          validateStatus: (status) => status! < 500,
        ),
      );

      log('Remove from Wishlist Response: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 204) {
        dynamic status = response.data["data"]["in_wishlist"];
        log("Status : $status");
        return status;
      } else if (response.statusCode == 401) {
        throw 'Unauthorized access. Please login again.';
      } else if (response.statusCode == 403) {
        throw 'Access forbidden. You don\'t have permission.';
      } else {
        throw 'Failed to remove from wishlist. Status code: ${response.statusCode}';
      }
    } on DioError catch (e) {
      log('Remove from Wishlist Error: ${e.message}');
      log('Status code: ${e.response?.statusCode}');
      throw 'Failed to remove from wishlist: ${e.message}';
    }
  }
}
