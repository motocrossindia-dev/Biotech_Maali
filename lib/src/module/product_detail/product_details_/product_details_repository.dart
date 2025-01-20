import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:biotech_maali/src/module/product_detail/product_details_/model/product_details_model.dart';
import 'package:biotech_maali/core/core.dart';

class ProductDetailsRepository {
  final Dio _dio = Dio();
  final String _baseUrl = 'http://www.dev.back.biotechmaali.com:8000';

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
        '$_baseUrl/product/filterProduct/$productId',
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
}
