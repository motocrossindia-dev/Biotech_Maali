class WalletTransactionModel {
  final String title;
  final double amount;
  final bool isCredit;
  final DateTime date;

  WalletTransactionModel({
    required this.title,
    required this.amount,
    required this.isCredit,
    required this.date,
  });
}