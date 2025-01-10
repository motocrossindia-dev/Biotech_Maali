import 'dart:developer';

import 'package:biotech_maali/src/module/account/wallet/wallet_history/wallet_history_screen.dart';
import 'package:biotech_maali/src/module/account/wallet/wallet_provider.dart';

import '../../../../import.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WalletProvider();
    return Consumer<WalletProvider>(
      builder: (context, walletProvider, _) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text('Wallet'),
          ),
          body: SingleChildScrollView(
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

                  // TextEditingController(

                  //   text: walletProvider.selectedAmount > 0
                  //       ? '₹${walletProvider.selectedAmount}'
                  //       : '',
                  // ),

                  onChanged: (value) {
                    log("value: $value");
                    if (value == "") {
                      int amount = int.parse("0");
                      walletProvider.setSelectedAmount(amount);
                      return;
                    }
                    int amount = int.parse(value);
                    walletProvider.setSelectedAmount(amount);
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter amount',
                  ),
                  readOnly: false,
                ),
                const SizedBox(height: 16),

                // Quick Amount Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildAmountButton(context, 1000, walletProvider),
                    _buildAmountButton(context, 500, walletProvider),
                    _buildAmountButton(context, 100, walletProvider),
                  ],
                ),
                const SizedBox(height: 24),

                // Proceed Button
                ElevatedButton(
                  onPressed: walletProvider.selectedAmount > 0
                      ? () => _proceedToPayment(context)
                      : null,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8), // Adjust the radius value as needed
                    ),
                    backgroundColor: cButtonGreen,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text(
                    'PROCEED TO TOP-UP',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 16),

                // Transaction History Button
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WalletHistoryScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.sync, color: Colors.blue[900]),
                          const SizedBox(width: 8),
                          Text(
                            'WALLET TRANSACTION HISTORY',
                            style: TextStyle(color: Colors.blue[900]),
                          ),
                        ],
                      ),
                      Icon(Icons.chevron_right, color: Colors.blue[900]),
                    ],
                  ),
                ),

                // Recent Transactions
                ..._buildRecentTransactions(walletProvider),
              ],
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

  List<Widget> _buildRecentTransactions(WalletProvider provider) {
    return [
      const SizedBox(height: 24),
      ...provider.recentTransactions.map(
        (transaction) => Card(
          child: ListTile(
            title: Text(transaction.title),
            subtitle: const Text('25% Utilization On Cart Value'),
            trailing: Text(
              '₹${transaction.amount}',
              style: TextStyle(
                color: transaction.isCredit ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    ];
  }

  void _proceedToPayment(BuildContext context) {
    // Here you would typically integrate with Razorpay
    // For demo, we'll just show the success screen
    showDialog(
      context: context,
      builder: (context) => const PaymentSuccessDialog(),
    );
  }
}

// Payment Success Dialog
class PaymentSuccessDialog extends StatelessWidget {
  const PaymentSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.blue[900],
              size: 48,
            ),
            const SizedBox(height: 16),
            const Text(
              'Top Up Success',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text('your top up has been done'),
            const SizedBox(height: 8),
            const Text(
              'Total Top Up',
              style: TextStyle(color: Colors.grey),
            ),
            Text(
              '₹${context.read<WalletProvider>().selectedAmount}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
