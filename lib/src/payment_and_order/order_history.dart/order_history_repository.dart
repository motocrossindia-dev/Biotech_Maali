import 'package:biotech_maali/src/payment_and_order/order_history.dart/model.dart/order_history_model.dart';

import '../../../import.dart';

class OrderHistoryRepository {
  final Dio dio = Dio();

  Future<OrderHistoryResponse> getOrderHistory() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('access_token');

      final response = await dio.get(
        '${EndUrl.baseUrl}order/orderHistory/',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return OrderHistoryResponse.fromJson(response.data);
      }
      throw Exception('Failed to load order history');
    } catch (e) {
      throw Exception('Error getting order history: $e');
    }
  }
}