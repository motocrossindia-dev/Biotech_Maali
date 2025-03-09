import 'package:biotech_maali/import.dart';
import 'model/product_search_model.dart';

class ProductSearchRepository {
  final Dio _dio = Dio();

  Future<List<ProductSearchModel>> searchProducts(String query) async {
    try {
      final response = await _dio.post(
        EndUrl.searchUrl,
        data: {'search': query},
      );

      if (response.data['message'] == 'success') {
        final products = response.data['products'] as List;
        return products
            .map((product) => ProductSearchModel.fromJson(product))
            .toList();
      }
      return [];
    } catch (e) {
      throw Exception('Failed to search products: $e');
    }
  }
}
