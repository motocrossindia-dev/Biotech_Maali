import 'dart:developer';

import 'package:biotech_maali/src/module/home/model/banner_model.dart';
import 'package:biotech_maali/src/module/home/model/product_model.dart';
import '../../../import.dart';

class HomeRepository {
  final dio = Dio();
  final String productUrl = EndUrl.homeProductsUrl;
  final String bannerUrl = EndUrl.promotionBannerUrl;

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
}
