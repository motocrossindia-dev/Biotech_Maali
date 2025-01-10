import '../../../import.dart';

class MobileNumberRepository {
  final Dio _dio = Dio();

  Future<dynamic> registerWithMobile(String mobileNumber) async {
    String registerUrl = '${BaseUrl.baseUrl}${EndUrl.registerWithMobileUrl}';
    try {
      final response = await _dio.post(
        registerUrl,
        data: {'mobile': mobileNumber},
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );

      if (response.statusCode == 200) {
        // return 200;
      } else if (response.statusCode == 201) {
        // return 201;
      }
      return response.data;
    } on DioException catch (e) {
      // Handle specific Dio errors
      if (e.response != null) {
        throw Exception('Failed to register: ${e.response?.statusCode}');
      } else {
        throw Exception('Network error: $e');
      }
    }
  }
}
