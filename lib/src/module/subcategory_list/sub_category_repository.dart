import 'dart:developer';

import 'package:biotech_maali/import.dart';
import 'package:biotech_maali/src/module/subcategory_list/model/subcategory_model.dart';
import 'package:biotech_maali/src/module/wishlist/model/wishlist_model.dart';

class SubCategoryRepository {


  final Dio _dio = Dio();

   Future<SubcategoryModel> getSubcategories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? token = prefs.getString("access_token");
    try {
      final response = await _dio.get(
        EndUrl.getCategoryWiseSubCategoryUrl,
        options: Options(
          // headers: {'Authorization': 'Bearer $token'},
          validateStatus: (status) => status! < 500,
        ),
      );

      log('Wishlist Response: ${response.data}');

      if (response.statusCode == 200) {
        return SubcategoryModel.fromJson(response.data);
      } else if (response.statusCode == 401) {
        throw 'Unauthorized access. Please login again.';
      } else if (response.statusCode == 403) {
        throw 'Access forbidden. You don\'t have permission.';
      } else {
        throw 'Failed to fetch wishlist. Status code: ${response.statusCode}';
      }
    } on DioError catch (e) {
      log('Wishlist Error: ${e.message}');
      log('Status code: ${e.response?.statusCode}');
      log('Response data: ${e.response?.data}');

      switch (e.response?.statusCode) {
        case 401:
          throw 'Unauthorized access. Please login again.';
        case 403:
          throw 'Access forbidden. You don\'t have permission.';
        case 404:
          throw 'Wishlist not found.';
        case 500:
          throw 'Server error. Please try again later.';
        default:
          throw 'Failed to fetch wishlist: ${e.message}';
      }
    }
  }


}