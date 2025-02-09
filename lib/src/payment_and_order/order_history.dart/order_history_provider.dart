import 'package:biotech_maali/src/payment_and_order/order_history.dart/model.dart/order_history_model.dart';
import 'package:biotech_maali/src/payment_and_order/order_history.dart/order_history_repository.dart';

import '../../../import.dart';

class OrderHistoryProvider extends ChangeNotifier {
  final OrderHistoryRepository _repository = OrderHistoryRepository();
  bool _isLoading = false;
  String? _error;
  OrderHistoryResponse? _orderHistory;

  bool get isLoading => _isLoading;
  String? get error => _error;
  OrderHistoryResponse? get orderHistory => _orderHistory;

  Future<void> fetchOrderHistory() async {
    try {
      _isLoading = true;
      _error = null;

      _orderHistory = await _repository.getOrderHistory();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }
}
