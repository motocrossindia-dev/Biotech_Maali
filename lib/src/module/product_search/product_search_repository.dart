import 'dart:developer';
import 'package:biotech_maali/import.dart';
import 'package:biotech_maali/src/module/product_search/model/product_search_model.dart';

class ProductSearchRepository {
  final Dio _dio = Dio();

  Future<List<ProductSearchModel>> searchProducts(String query) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("access_token");
    try {
      Response? response;
      if (token != null) {
        response = await _dio.post(
          EndUrl.searchUrl,
          data: {'search': query},
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
          ),
        );
      } else {
        response = await _dio.post(
          EndUrl.searchUrl,
          data: {'search': query},
        );
      }
      response = await _dio.post(EndUrl.searchUrl,
          data: {'search': query},
          options: Options(headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          }));

      log("Response : ${response.statusCode}, data: ${response.data}");

      if (response.data['message'] == 'success') {
        final products = response.data['products'] as List;
        return products
            .map((product) => ProductSearchModel.fromJson(product))
            .toList();
      }
      return [];
    } catch (e) {
      log("Error: ${e.toString()}");
      throw Exception('Failed to search products: $e');
    }
  }
}
