import 'package:biotech_maali/src/module/account/wallet/wallet_provider.dart';

import '../../../../../import.dart';

class WalletHistoryScreen extends StatelessWidget {
  const WalletHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Wallet History'),
      ),
      body: Consumer<WalletProvider>(
        builder: (context, provider, _) {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.transactions.length,
            itemBuilder: (context, index) {
              final transaction = provider.transactions[index];
              return Card(
                child: ListTile(
                  title: Text(transaction.title),
                  trailing: Text(
                    '₹${transaction.amount}',
                    style: TextStyle(
                      color: transaction.isCredit ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
