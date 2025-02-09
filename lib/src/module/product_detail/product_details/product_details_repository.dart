import 'dart:developer';
import 'package:biotech_maali/src/module/product_detail/product_details/model/order_response_model.dart';
import 'package:biotech_maali/src/module/product_detail/product_details/model/product_details_model.dart';

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
        sizeId = null;
        planterSizeId = null;
        planterId = null;
        colorId = null;
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

  Future<OrderResponseModel> buySingleProduct(
      int productId, int quantity) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("access_token");

      if (token == null) throw Exception('Authentication token is missing');

      final response = await _dio.post(
        EndUrl.addSingleProductUrl,
        data: {
          'order_source': 'product',
          'prod_id': productId,
          'quantity': quantity,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        log('Order response: ${response.data}');
        return OrderResponseModel.fromJson(response.data);
      } else if (response.statusCode == 400) {
        throw Exception(response.data['message']);
      }

      throw Exception('Failed to place order');
    } catch (e) {
      if (e.toString().contains('User profile is not updated')) {
        log("Error : ${e.toString()}");
        throw ProfileNotUpdatedException();
      } else if (e.toString().contains('User address is not updated')) {
        log("Error : ${e.toString()}");
        throw AddressNotUpdatedException();
      }
      log("Error : ${e.toString()}");
      throw Exception('Error placing order: ${e.toString()}');
    }
  }
}

class ProfileNotUpdatedException implements Exception {
  String message = 'User profile is not updated.';
}

class AddressNotUpdatedException implements Exception {
  String message = 'User address is not updated.';
}
