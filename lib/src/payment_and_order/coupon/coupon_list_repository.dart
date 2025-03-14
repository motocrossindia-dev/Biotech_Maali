import 'dart:developer';

import 'package:biotech_maali/core/core.dart';
import 'package:biotech_maali/src/payment_and_order/coupon/model/coupon_model.dart';
import 'package:dio/dio.dart';

class CouponRepository {
  final Dio _dio = Dio();
  String baseUrl = "";

  Future<List<Coupon>> getCoupons() async {
    try {
      final response = await _dio.get(EndUrl.getCouponsUrl);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        final couponResponse = CouponResponse.fromJson(data);
        log("coupon response ========== : ${response.data}");
        return couponResponse.coupons;
      } else {
        throw Exception('Failed to load coupons: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to load coupons: ${e.message}');
    } catch (e) {
      throw Exception('Failed to load coupons: $e');
    }
  }

  Future<bool> applyCoupon(
      {required String code, required double cartValue}) async {
    try {
      final response = await _dio.post(
        '$baseUrl/coupon/apply/',
        data: {
          'code': code,
          'cart_value': cartValue,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        final Map<String, dynamic> data = response.data;
        throw Exception(data['message'] ?? 'Failed to apply coupon');
      }
    } on DioException catch (e) {
      throw Exception('Failed to apply coupon: ${e.message}');
    } catch (e) {
      throw Exception('Failed to apply coupon: $e');
    }
  }
}
