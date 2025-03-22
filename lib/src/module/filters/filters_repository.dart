import 'dart:developer';
import 'package:biotech_maali/import.dart';
import 'package:biotech_maali/src/module/product_list/product_list/model/product_list_model.dart';
import 'model/filter_response_model.dart';

class FiltersRepository {
  final Dio _dio = Dio();
  final String baseUrl = 'http://www.dev.back.biotechmaali.com:8000';

  Future<FilterResponseModel> getFilters(String type) async {
    log("type : $type");
    try {
      final response = await _dio.get(
        '$baseUrl/filters/filters/',
        queryParameters: {'type': type},
      );
      log("Response data : ${response.data.toString()}");
      return FilterResponseModel.fromJson(response.data);
    } catch (e) {
      log("Error fetching filters: $e");
      throw Exception('Failed to load filters');
    }
  }

  Future<List<Product>> applyFilters(
      String type, Map<String, dynamic> filters) async {
    try {
      final queryParams = {
        'type': type.toLowerCase(),
        ...filters,
      };

      log("Filter query params: $queryParams");

      final response = await _dio.get(
        '$baseUrl/filters/productsFilter/',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        log("Filter applied response: ${response.data}");
        List<Product> filteredProducts = (response.data["results"] as List)
            .map((item) => Product.fromJson(item))
            .toList();
        return filteredProducts;
      } else {
        throw Exception('Failed to apply filters');
      }
    } catch (e) {
      log("Error applying filters: $e");
      throw Exception('Error applying filters: $e');
    }
  }
}
