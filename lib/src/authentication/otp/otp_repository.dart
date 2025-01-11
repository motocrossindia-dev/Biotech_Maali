import 'dart:developer';
import '../../../import.dart';

class OtpRepository {
  final Dio _dio = Dio();

  Future<bool> validateOtp(String mobile, String otp) async {
    try {
      final response = await _dio.post(
        '${BaseUrl.baseUrl}account/validateOtp/',
        data: {
          'mobile': mobile,
          'otp': otp,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Save tokens to SharedPreferences
        log("user data and token: ${response.data.toString()}");
        final prefs = await SharedPreferences.getInstance();
        final tokens = response.data['data']['token'];
        await prefs.setString('access_token', tokens['access']);
        await prefs.setString('refresh_token', tokens['refresh']);

        // Save user data
        final userData = response.data['data']['user'];
        await prefs.setString('user_id', userData['id'].toString());
        await prefs.setString('user_name', userData['first_name']);
        await prefs.setString('user_mobile', userData['mobile']);

        return true;
      }
      return false;
    } on DioException catch (e) {
      log('OTP Validation Error: ${e.message}');
      return false;
    }
  }
}
