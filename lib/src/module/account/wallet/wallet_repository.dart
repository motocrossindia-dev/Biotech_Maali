import 'package:biotech_maali/core/core.dart';
import 'package:biotech_maali/import.dart';
import 'package:biotech_maali/src/module/account/wallet/wallet_model.dart';
import 'package:dio/dio.dart';

class WalletRepository {
  final Dio dio = Dio();
  // final String baseUrl =
  //     'http://www.dev.back.biotechmaali.com:8000/'; // Replace with your actual base URL

  Future<WalletDetailsResponse> getWalletDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("access_token");
    try {
      final response = await dio.get(
        EndUrl.getWalletUrl,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );
      return WalletDetailsResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to fetch wallet details: ${e.message}');
    } catch (e) {
      throw Exception('Failed to fetch wallet details: $e');
    }
  }

  Future<TransactionsResponse> getTransactions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("access_token");
    try {
      final response = await dio.get(
        EndUrl.getWalletTransactionUrl,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );
      return TransactionsResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to fetch transactions: ${e.message}');
    } catch (e) {
      throw Exception('Failed to fetch transactions: $e');
    }
  }
}
