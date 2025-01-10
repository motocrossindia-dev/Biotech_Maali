import 'package:biotech_maali/src/module/account/wallet/wallet_model.dart';
import 'package:flutter/material.dart';

class WalletProvider extends ChangeNotifier {
  WalletProvider() {
    initializeData();
  }
  double _balance = 0.0;
  int _selectedAmount = 0;
  List<WalletTransactionModel> _transactions = [];

  final TextEditingController _amountController = TextEditingController();
  TextEditingController get amountController => _amountController;
  double get balance => _balance;
  int get selectedAmount => _selectedAmount;
  List<WalletTransactionModel> get transactions => _transactions;
  List<WalletTransactionModel> get recentTransactions =>
      _transactions.take(3).toList();

  void setSelectedAmount(int amount) {
    _amountController.text = amount.toString();
    _selectedAmount = amount;
    notifyListeners();
  }

  void addBalance(double amount) {
    _balance += amount;
    _transactions.insert(
        0,
        WalletTransactionModel(
          title: 'Topup',
          amount: amount,
          isCredit: true,
          date: DateTime.now(),
        ));
    notifyListeners();
  }

  // Initialize with some dummy data
  void initializeData() {
    _transactions = [
      WalletTransactionModel(
          title: 'Promotional Reward Added on Registration',
          amount: 500,
          isCredit: true,
          date: DateTime.now()),
      WalletTransactionModel(
          title: 'Hanif(Referral)',
          amount: 500,
          isCredit: true,
          date: DateTime.now()),
      WalletTransactionModel(
          title: 'Lily Plant',
          amount: 500,
          isCredit: false,
          date: DateTime.now()),
      WalletTransactionModel(
          title: 'Hanif(Referral)',
          amount: 500,
          isCredit: true,
          date: DateTime.now()),
      WalletTransactionModel(
          title: 'Promotional Reward Added on Registration',
          amount: 500,
          isCredit: true,
          date: DateTime.now()),
      WalletTransactionModel(
          title: 'Lily Plant',
          amount: 500,
          isCredit: false,
          date: DateTime.now())
    ];
    notifyListeners();
  }
}
