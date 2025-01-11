import 'dart:developer';

import 'package:biotech_maali/core/core.dart';
import 'package:biotech_maali/src/module/product_detail/product_details_/model/product_details_model.dart';
import 'package:dio/dio.dart';

class ProductDetailsRepository {
  final Dio _dio = Dio();
  final String _baseUrl = 'http://www.dev.back.biotechmaali.com:8000';

  Future<ProductDetailModel> fetchProductDetails(int productId) async {
    try {
      final response =
          await _dio.get('${EndUrl.getProductDetailsUrl}$productId');
      if (response.statusCode == 200) {
        log("product details : ${response.data.toString()}");
        return ProductDetailModel.fromJson(response.data);
      } else {
        log('Failed to get product details: ${response.statusMessage.toString()}');
        throw Exception('Failed to load product details');
      }
    } catch (e) {
      log("Error: ${e.toString()}");
      throw Exception('Error fetching product details: $e');
    }
  }

  Future<ProductDetailModel> filterProduct({
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
      log("${queryParams.toString()}");

      final response = await _dio.get(
        '$_baseUrl/product/filterProduct/',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        return ProductDetailModel.fromJson(response.data);
      } else {
        throw Exception('Failed to filter product');
      }
    } catch (e) {
      log("Error : ${e.toString()}");
      throw Exception('Error filtering product: $e');
    }
  }
}
