import 'dart:developer';

import 'package:biotech_maali/import.dart';
import 'package:biotech_maali/src/module/product_list/product_list/model/product_list_model.dart';

class ProductListRepository {
  Dio dio = Dio();

  Future<ProductListModel> getCotegoryProductList(String id) async {
    log("id : $id");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');

    try {
      Response? response;
      if (token != null) {
        response = await dio.get(
          "${EndUrl.categoryProductUrl}$id",
          options: Options(
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "Application/json"
            },
          ),
        );
      } else {
        response = await dio.get("${EndUrl.categoryProductUrl}$id");
      }

      if (response.statusCode == 200) {
        log("data in repository category products : ${response.data.toString()}");
        dynamic responseData = response.data;

        ProductListModel productListModel =
            ProductListModel.fromJson(responseData);

        return productListModel;
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        log('Dio error: ${e.message}');
        throw Exception('Network error fetching products: ${e.message}');
      }
      log('General error: $e');
      throw Exception('Error fetching products: $e');
    }
  }

  Future<ProductListModel> getSubCotegoryProductList(String id) async {
    log("id : $id");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    try {
      Response? response;
      if (token != null) {
        response = await dio.get(
          "${EndUrl.subCategoryProductUrl}$id",
          options: Options(
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "Application/json"
            },
          ),
        );
      } else {
        response = await dio.get("${EndUrl.subCategoryProductUrl}$id");
      }

      if (response.statusCode == 200) {
        log("data in repository category products : ${response.data.toString()}");
        dynamic responseData = response.data;

        ProductListModel productListModel =
            ProductListModel.fromJson(responseData);

        return productListModel;
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        log('Dio error: ${e.message}');
        throw Exception('Network error fetching products: ${e.message}');
      }
      log('General error: $e');
      throw Exception('Error fetching products: $e');
    }
  }
}
