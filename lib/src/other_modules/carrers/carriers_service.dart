import 'package:dio/dio.dart';
import 'carrier_model.dart';

class CarriersService {
  final Dio _dio = Dio();
  final String baseUrl = 'https://www.backend.biotechmaali.com';

  Future<List<CarrierModel>> getCarriers() async {
    try {
      final response = await _dio.get('$baseUrl/carrier/publicCarrier/');
      if (response.data['message'] == 'success') {
        final carriers = (response.data['data']['carrier'] as List)
            .map((json) => CarrierModel.fromJson(json))
            .toList();
        return carriers;
      }
      throw Exception('Failed to load carriers');
    } catch (e) {
      throw Exception('Failed to load carriers: $e');
    }
  }
}
