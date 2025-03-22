import 'dart:developer';

import 'package:biotech_maali/import.dart';
import 'package:biotech_maali/src/payment_and_order/coupon/model/coupon_model.dart';
import 'package:biotech_maali/src/payment_and_order/order_summary/model/order_response_model.dart';

class CouponRepository {
  final Dio _dio = Dio();
  String baseUrl = "";

  Future<List<Coupon>> getCoupons(String orderId) async {
    log("order id in repository: $orderId");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("access_token");

    log("toeknr : $token");
    try {
      final response = await _dio.get(
        "${EndUrl.getCouponsUrl}?order_id=$orderId",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

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

  Future<OrderData?> applyCoupon(
      {required String couponId, required String orderId}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("access_token");
    try {
      final response = await _dio.post(
        EndUrl.applyCouponUrl,
        data: {
          'selected_coupon_id': couponId,
          'order_id': orderId,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      if (response.statusCode == 200) {
        log("response  : ${response.data}");

        return OrderData.fromJson(response.data);
        // return true;
      } else {
        log("Else Block : ${response.data.toString()}");
        // final Map<String, dynamic> data = response.data;

        throw Exception(response.data['error'] ?? 'Failed to apply coupon');
      }
    } on DioException catch (e) {
      throw Exception('Failed to apply coupon: ${e.message}');
    } catch (e) {
      throw Exception('Failed to apply coupon: $e');
    }
  }
}
