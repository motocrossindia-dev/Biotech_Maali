import 'dart:developer';

import 'package:biotech_maali/src/module/account/coin/coin_history/coin_history_screen.dart';
import 'package:biotech_maali/src/module/account/coin/coin_provider.dart';

import '../../../../import.dart';

class CoinScreen extends StatelessWidget {
  const CoinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CoinProvider();
    return Consumer<CoinProvider>(
      builder: (context, coinProvider, _) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            title: const CommonTextWidget(
              title: 'Coins',
              fontSize: 16,
            ),
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
                          'Total Coin Balance',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.monetization_on,
                              color: Colors.amber[700],
                              size: 28,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${coinProvider.coinBalance}',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber[700],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                const Text('Earn More Coins', style: TextStyle(fontSize: 18)),
                const SizedBox(height: 16),

                // Ways to Earn Coins
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Complete Actions to Earn Coins:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildEarnOption(
                          context,
                          icon: Icons.shopping_cart,
                          title: 'Complete a purchase',
                          coins: '50',
                        ),
                        const Divider(),
                        _buildEarnOption(
                          context,
                          icon: Icons.rate_review,
                          title: 'Write a product review',
                          coins: '20',
                        ),
                        const Divider(),
                        _buildEarnOption(
                          context,
                          icon: Icons.share,
                          title: 'Refer a friend',
                          coins: '100',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Redeem Button
                ElevatedButton(
                  onPressed: coinProvider.coinBalance > 0
                      ? () => _showRedeemDialog(context, coinProvider)
                      : null,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: cButtonGreen,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text(
                    'REDEEM COINS',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 16),

                // Coin History Button
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CoinHistoryScreen(),
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
                          Icon(Icons.history, color: Colors.blue[900]),
                          const SizedBox(width: 8),
                          Text(
                            'COIN TRANSACTION HISTORY',
                            style: TextStyle(color: Colors.blue[900]),
                          ),
                        ],
                      ),
                      Icon(Icons.chevron_right, color: Colors.blue[900]),
                    ],
                  ),
                ),
                sizedBoxHeight20,

                // Coin Information Cards
                _buildCoinInfoCard(
                  title: "Shop & Earn Coins",
                  subTitle: "Earn 1 Coin for every ₹10 spent",
                  totalAmount: "${coinProvider.earnRate} Coins/₹10",
                ),
                _buildCoinInfoCard(
                  title: "Coin Redemption Value",
                  subTitle: "100 Coins = ₹5 discount",
                  totalAmount: "₹${coinProvider.redemptionRate}/100 Coins",
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEarnOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String coins,
  }) {
    return Row(
      children: [
        Icon(icon, color: Colors.amber[700]),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        Row(
          children: [
            Icon(Icons.monetization_on, color: Colors.amber[700], size: 16),
            const SizedBox(width: 4),
            Text(
              coins,
              style: TextStyle(
                color: Colors.amber[700],
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCoinInfoCard({
    required String title,
    required String subTitle,
    required String totalAmount,
  }) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(subTitle),
        trailing: Text(
          totalAmount,
          style: TextStyle(
            fontSize: 15,
            color: Colors.amber[700],
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _showRedeemDialog(BuildContext context, CoinProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Redeem Coins'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('How many coins would you like to redeem?'),
            const SizedBox(height: 16),
            TextFormField(
              controller: provider.redeemController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter coin amount',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${provider.redemptionRate} ₹ discount per 100 coins',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
          TextButton(
            onPressed: () {
              // Here you would implement the redemption logic
              Navigator.pop(context);
              _showRedemptionSuccess(context, provider);
            },
            child: const Text('REDEEM'),
          ),
        ],
      ),
    );
  }

  void _showRedemptionSuccess(BuildContext context, CoinProvider provider) {
    int redeemAmount = int.tryParse(provider.redeemController.text) ?? 0;
    if (redeemAmount <= 0 || redeemAmount > provider.coinBalance) {
      return;
    }

    double discountValue = (redeemAmount / 100) * provider.redemptionRate;

    showDialog(
      context: context,
      builder: (context) => Dialog(
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
                'Redemption Successful',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text('Your coins have been redeemed for a discount'),
              const SizedBox(height: 8),
              const Text(
                'Redeemed Coins',
                style: TextStyle(color: Colors.grey),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.monetization_on, color: Colors.amber[700]),
                  const SizedBox(width: 4),
                  Text(
                    '$redeemAmount',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Discount Value',
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                '₹${discountValue.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
