import 'dart:developer';

import 'package:biotech_maali/src/module/home/model/banner_model.dart';
import 'package:biotech_maali/src/module/home/model/category_model.dart';
import 'package:biotech_maali/src/module/home/model/product_model.dart';
import '../../../import.dart';

class HomeRepository {
  final dio = Dio();
  final String productUrl = EndUrl.homeProductsUrl;
  final String bannerUrl = EndUrl.promotionBannerUrl;
  final String mainCategoriesUrl = EndUrl.getMainCategoriesUrl;

  Future<List<ProductModel>> getHomeProducts() async {
    try {
      final response = await dio.get(productUrl);

      if (response.statusCode == 200 && response.data != null) {
        final Map<String, dynamic> responseData = response.data;

        if (responseData['data'] == null ||
            responseData['data']['products'] == null) {
          throw Exception('Invalid response format: missing data or products');
        }

        final List<dynamic> productsData = responseData['data']['products'];
        log("Home Product Data ============== ${productsData.toString()}");
        return productsData
            .map((product) =>
                ProductModel.fromJson(product as Map<String, dynamic>))
            .toList();
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

  Future<List<BannerModel>> getBanners() async {
    try {
      final response = await dio.get(bannerUrl);

      log('Banner Response: ${response.data}');
      if (response.statusCode == 200 && response.data != null) {
        log('Banner URL: $bannerUrl');
        log('Product URL: $productUrl');
        final Map<String, dynamic> responseData = response.data;

        // Check if the response has the expected structure
        if (responseData['data'] == null ||
            responseData['data']['banners'] == null) {
          throw Exception('Invalid response format: missing data or banners');
        }

        final List<dynamic> bannersData = responseData['data']['banners'];

        return bannersData
            .map((banner) =>
                BannerModel.fromJson(banner as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load banners: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        throw Exception('Network error fetching banners: ${e.message}');
      }
      throw Exception('Error fetching banners: $e');
    }
  }

  Future<CategoryModel> getMainCategories() async {
    try {
      final response = await dio.get(mainCategoriesUrl);
      log('Category Response: ${response.data}'); // Add this for debugging

      if (response.statusCode == 200 && response.data != null) {
        // Parse the entire response as CategoryModel
        return CategoryModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw Exception('Failed to load categories: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        log('Dio error: ${e.message}');
        throw Exception('Network error fetching categories: ${e.message}');
      }
      log('General error: $e');
      throw Exception('Error fetching categories: $e');
    }
  }

  Future<List<dynamic>> getWhishlistId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("access_token");
    log("access token : ${token.toString()}");

    try {
      final response = await dio.get(
        EndUrl.getWhishListIdUrl,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
          validateStatus: (status) => status! < 500,
        ),
      );
      log('Category Response: ${response.data}'); // Add this for debugging

      if (response.statusCode == 200 && response.data != null) {
        // Parse the entire response as CategoryModel
        List<dynamic> productIdis = await response.data["main_product_ids"];
        log("product id: ${productIdis.toString()}");
        return productIdis;
      } else {
        throw Exception('Failed to load categories: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        log('Dio error: ${e.message}');
        throw Exception('Network error fetching categories: ${e.message}');
      }
      log('General error: $e');
      throw Exception('Error fetching categories: $e');
    }
  }

  Future<CategoryModel> addOrRemoveWishListMainProduct(int productId) async {
    try {
      final response = await dio.post(
        EndUrl.addOrRemoveWilistProduct,
        data: {"main_prod_id": productId},
      );
      log('Category Response: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        // Parse the entire response as CategoryModel
        return CategoryModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw Exception('Failed to load categories: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        log('Dio error: ${e.message}');
        throw Exception('Network error fetching categories: ${e.message}');
      }
      log('General error: $e');
      throw Exception('Error fetching categories: $e');
    }
  }
}
