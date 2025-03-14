import 'package:biotech_maali/import.dart';
import 'package:biotech_maali/src/module/product_compo_list/model/product_compo_model.dart';

class ProductCompoRepository {
  final Dio _dio = Dio();

  Future<ProductCompoResponse> getComboOffers() async {
    try {
      final response = await _dio.get(EndUrl.comboOffersUrl);

      if (response.statusCode == 200) {
        return ProductCompoResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load combo offers');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
