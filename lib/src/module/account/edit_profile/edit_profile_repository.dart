import 'dart:developer';
import 'package:biotech_maali/core/core.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileRepository {
  final Dio dio = Dio();

  Future<Map<String, String>> _getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    return {
      if (token != null) 'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }

  Future<Map<String, dynamic>> fetchProfile() async {
    try {
      final headers = await _getHeaders();
      final response = await dio.get(
        EndUrl.getOrUpdateProfileUrl,
        options: Options(headers: headers),
      );

      log("Fetch Profile Status Code: ${response.statusCode}");
      log("Fetch Profile Response Data: ${response.data}");

      if (response.statusCode == 200) {
        return response.data['data']['profile'] ?? {};
      } else {
        log('Fetch Profile Error: Unexpected status code');
        return {};
      }
    } on DioException catch (e) {
      log('Dio Error in fetchProfile: ${e.response?.statusCode}');
      log('Error Details: ${e.response?.data}');
      return {};
    } catch (e) {
      log('Unexpected Error in fetchProfile: $e');
      return {};
    }
  }

  Future<bool> updateProfile({
    required String firstName,
    required String lastName,
    required String email,
    required String mobile,
    required String gender,
    String? dateOfBirth,
  }) async {
    try {
      final headers = await _getHeaders();
      final payload = {
        "profile": {
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          'mobile': mobile,
          'gender': gender,
          if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
        }
      };

      log("data from mobile: ${payload.toString()}");

      final response = await dio.patch(
        EndUrl.getOrUpdateProfileUrl,
        data: payload,
        options: Options(headers: headers),
      );

      log("Update Profile Status Code: ${response.statusCode}");
      log("Update Profile Response Data: ${response.data}");

      if (response.statusCode == 200) {
        return true;
      } else {
        log('Update Profile Error: Unexpected status code');
        return false;
      }
    } on DioException catch (e) {
      log('Dio Error in updateProfile: ${e.response?.statusCode}');
      log('Error Details: ${e.response?.data}');
      return false;
    } catch (e) {
      log('Unexpected Error in updateProfile: $e');
      return false;
    }
  }
}
