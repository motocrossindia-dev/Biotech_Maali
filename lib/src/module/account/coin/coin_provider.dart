import 'package:flutter/material.dart';

class CoinTransaction {
  final String title;
  final int amount;
  final bool isEarned;
  final String date;

  CoinTransaction({
    required this.title,
    required this.amount,
    required this.isEarned,
    required this.date,
  });
}

class CoinProvider extends ChangeNotifier {
  // Singleton pattern
  static final CoinProvider _instance = CoinProvider._internal();
  
  factory CoinProvider() {
    return _instance;
  }
  
  CoinProvider._internal() {
    // Initialize with some dummy data for demonstration
    _generateDummyTransactions();
  }

  // Coin balance
  int _coinBalance = 450;
  int get coinBalance => _coinBalance;
  
  // Redemption rates
  final double _redemptionRate = 5.0; // ₹5 per 100 coins
  double get redemptionRate => _redemptionRate;
  
  // Earn rate
  final int _earnRate = 1; // 1 coin per ₹10 spent
  int get earnRate => _earnRate;
  
  // Transaction history
  final List<CoinTransaction> _coinTransactions = [];
  List<CoinTransaction> get coinTransactions => _coinTransactions;
  
  // Filter
  String _selectedFilter = 'all';
  String get selectedFilter => _selectedFilter;
  
  // Controller for redeeming coins
  final TextEditingController redeemController = TextEditingController();
  
  // Getter for filtered transactions
  List<CoinTransaction> get filteredTransactions {
    if (_selectedFilter == 'all') {
      return _coinTransactions;
    } else if (_selectedFilter == 'earned') {
      return _coinTransactions.where((t) => t.isEarned).toList();
    } else {
      return _coinTransactions.where((t) => !t.isEarned).toList();
    }
  }
  
  // Getter for total earned coins
  int get totalEarned {
    return _coinTransactions
        .where((t) => t.isEarned)
        .fold(0, (sum, t) => sum + t.amount);
  }
  
  // Getter for total spent coins
  int get totalSpent {
    return _coinTransactions
        .where((t) => !t.isEarned)
        .fold(0, (sum, t) => sum + t.amount);
  }
  
  // Set filter
  void setFilter(String filter) {
    _selectedFilter = filter;
    notifyListeners();
  }
  
  // Redeem coins
  void redeemCoins(int amount) {
    if (amount <= 0 || amount > _coinBalance) {
      return;
    }
    
    _coinBalance -= amount;
    
    _coinTransactions.insert(
      0,
      CoinTransaction(
        title: 'Redeemed for discount',
        amount: amount,
        isEarned: false,
        date: _formatDate(DateTime.now()),
      ),
    );
    
    notifyListeners();
  }
  
  // Add coins
  void addCoins(int amount, String reason) {
    if (amount <= 0) {
      return;
    }
    
    _coinBalance += amount;
    
    _coinTransactions.insert(
      0,
      CoinTransaction(
        title: reason,
        amount: amount,
        isEarned: true,
        date: _formatDate(DateTime.now()),
      ),
    );
    
    notifyListeners();
  }
  
  // Helper to format date
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute < 10 ? '0${date.minute}' : date.minute}';
  }
  
  // Generate dummy transaction history for demonstration
  void _generateDummyTransactions() {
    final now = DateTime.now();
    
    _coinTransactions.addAll([
      CoinTransaction(
        title: 'Purchase: Plant Nutrient Kit',
        amount: 50,
        isEarned: true,
        date: _formatDate(now.subtract(const Duration(days: 2))),
      ),
      CoinTransaction(
        title: 'Product Review: Organic Fertilizer',
        amount: 20,
        isEarned: true,
        date: _formatDate(now.subtract(const Duration(days: 5))),
      ),
      CoinTransaction(
        title: 'Referred Friend: Rahul S.',
        amount: 100,
        isEarned: true,
        date: _formatDate(now.subtract(const Duration(days: 7))),
      ),
      CoinTransaction(
        title: 'Purchase: Garden Tools Set',
        amount: 80,
        isEarned: true,
        date: _formatDate(now.subtract(const Duration(days: 10))),
      ),
      CoinTransaction(
        title: 'Redeemed for discount',
        amount: 200,
        isEarned: false,
        date: _formatDate(now.subtract(const Duration(days: 12))),
      ),
      CoinTransaction(
        title: 'Welcome Bonus',
        amount: 100,
        isEarned: true,
        date: _formatDate(now.subtract(const Duration(days: 15))),
      ),
      CoinTransaction(
        title: 'Purchase: Soil Testing Kit',
        amount: 30,
        isEarned: true,
        date: _formatDate(now.subtract(const Duration(days: 18))),
      ),
      CoinTransaction(
        title: 'Purchase: Organic Seeds Pack',
        amount: 40,
        isEarned: true,
        date: _formatDate(now.subtract(const Duration(days: 22))),
      ),
      CoinTransaction(
        title: 'Monthly Reward',
        amount: 50,
        isEarned: true,
        date: _formatDate(now.subtract(const Duration(days: 30))),
      ),
    ]);
  }
}