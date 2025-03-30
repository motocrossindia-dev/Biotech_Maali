import 'package:biotech_maali/src/module/account/wallet/wallet_history/wallet_history_screen.dart';
import 'package:biotech_maali/src/module/account/wallet/wallet_provider.dart';
import 'package:intl/intl.dart';

import '../../../../import.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WalletProvider>(
      builder: (context, walletProvider, _) {
        if (walletProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (walletProvider.error != null) {
          return Center(child: Text('Error: ${walletProvider.error}'));
        }

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text('Wallet'),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              await walletProvider.fetchWalletDetails();
              await walletProvider.fetchTransactions();
            },
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Balance Card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          const Text(
                            'Total Wallet Balance',
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '₹${walletProvider.balance.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  const Text('Top Up Wallet', style: TextStyle(fontSize: 18)),
                  const SizedBox(height: 16),

                  // Amount Input Field
                  TextFormField(
                    controller: walletProvider.amountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter amount',
                      prefixText: '₹',
                    ),
                    onChanged: (value) {
                      if (value.isEmpty) {
                        walletProvider.setSelectedAmount(0);
                        return;
                      }
                      walletProvider.setSelectedAmount(int.parse(value));
                    },
                  ),
                  const SizedBox(height: 16),

                  // Quick Amount Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildAmountButton(context, 100, walletProvider),
                      _buildAmountButton(context, 500, walletProvider),
                      _buildAmountButton(context, 1000, walletProvider),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Recent Transactions
                  if (walletProvider.transactions.isNotEmpty) ...[
                    const Text(
                      'Recent Transactions',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    ...walletProvider.transactions.take(3).map((transaction) {
                      return Card(
                        child: ListTile(
                          title: Text(transaction.description),
                          subtitle: Text(
                            DateFormat('dd MMM yyyy').format(transaction.createdAt),
                          ),
                          trailing: Text(
                            '₹${transaction.amount}',
                            style: TextStyle(
                              color: transaction.isCredit ? Colors.green : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ],

                  const SizedBox(height: 16),

                  // View All Transactions Button
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WalletHistoryScreen(),
                        ),
                      );
                    },
                    child: const Text('VIEW ALL TRANSACTIONS'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAmountButton(
      BuildContext context, int amount, WalletProvider provider) {
    bool isSelected = provider.selectedAmount == amount;
    return OutlinedButton(
      onPressed: () => provider.setSelectedAmount(amount),
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: isSelected ? Colors.green : Colors.grey,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Text('₹$amount'),
    );
  }
}