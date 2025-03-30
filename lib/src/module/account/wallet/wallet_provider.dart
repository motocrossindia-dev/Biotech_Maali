import 'package:biotech_maali/src/module/account/wallet/wallet_model.dart';
import 'package:biotech_maali/src/module/account/wallet/wallet_repository.dart';
import 'package:flutter/material.dart';

class WalletProvider extends ChangeNotifier {
  final WalletRepository _repository = WalletRepository();

  WalletProvider() {
    fetchWalletDetails();
    fetchTransactions();
  }

  double _balance = 0.0;
  int _selectedAmount = 0;
  bool _isLoading = false;
  List<Transaction> _transactions = [];
  String? _error;

  final TextEditingController _amountController = TextEditingController();

  TextEditingController get amountController => _amountController;
  double get balance => _balance;
  int get selectedAmount => _selectedAmount;
  List<Transaction> get transactions => _transactions;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchWalletDetails() async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await _repository.getWalletDetails();
      _balance = double.parse(response.data.balance);

      _isLoading = false;
      _error = null;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> fetchTransactions() async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await _repository.getTransactions();
      _transactions = response.data.transactions;

      _isLoading = false;
      _error = null;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  void setSelectedAmount(int amount) {
    _amountController.text = amount.toString();
    _selectedAmount = amount;
    notifyListeners();
  }

  void addBalance(double amount) {
    _balance += amount;
    notifyListeners();
    fetchWalletDetails(); // Refresh wallet details after adding balance
    fetchTransactions(); // Refresh transactions
  }
}
