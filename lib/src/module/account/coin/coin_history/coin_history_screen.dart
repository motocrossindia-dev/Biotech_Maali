import 'package:biotech_maali/src/module/account/coin/coin_provider.dart';
import '../../../../../import.dart';

class CoinHistoryScreen extends StatelessWidget {
  const CoinHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Coin History'),
      ),
      body: Consumer<CoinProvider>(
        builder: (context, provider, _) {
          if (provider.coinTransactions.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.history,
                    size: 64,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No transaction history yet',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }
          
          return Column(
            children: [
              // Summary Card
              Padding(
                padding: const EdgeInsets.all(16),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildSummaryItem(
                          icon: Icons.arrow_downward,
                          color: Colors.green,
                          title: 'Earned',
                          value: '${provider.totalEarned}',
                        ),
                        const SizedBox(
                          height: 40,
                          child: VerticalDivider(thickness: 1),
                        ),
                        _buildSummaryItem(
                          icon: Icons.arrow_upward,
                          color: Colors.red,
                          title: 'Spent',
                          value: '${provider.totalSpent}',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              
              // Filter Row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    const Text('Filter: '),
                    const SizedBox(width: 8),
                    ChoiceChip(
                      label: const Text('All'),
                      selected: provider.selectedFilter == 'all',
                      onSelected: (selected) {
                        if (selected) provider.setFilter('all');
                      },
                    ),
                    const SizedBox(width: 8),
                    ChoiceChip(
                      label: const Text('Earned'),
                      selected: provider.selectedFilter == 'earned',
                      onSelected: (selected) {
                        if (selected) provider.setFilter('earned');
                      },
                    ),
                    const SizedBox(width: 8),
                    ChoiceChip(
                      label: const Text('Spent'),
                      selected: provider.selectedFilter == 'spent',
                      onSelected: (selected) {
                        if (selected) provider.setFilter('spent');
                      },
                    ),
                  ],
                ),
              ),
              
              // Transaction List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: provider.filteredTransactions.length,
                  itemBuilder: (context, index) {
                    final transaction = provider.filteredTransactions[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: transaction.isEarned
                              ? Colors.green.withOpacity(0.2)
                              : Colors.red.withOpacity(0.2),
                          child: Icon(
                            transaction.isEarned
                                ? Icons.arrow_downward
                                : Icons.arrow_upward,
                            color: transaction.isEarned ? Colors.green : Colors.red,
                          ),
                        ),
                        title: Text(transaction.title),
                        subtitle: Text(
                          transaction.date,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.monetization_on,
                              color: Colors.amber[700],
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${transaction.isEarned ? '+' : '-'}${transaction.amount}',
                              style: TextStyle(
                                color: transaction.isEarned ? Colors.green : Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
  
  Widget _buildSummaryItem({
    required IconData icon,
    required Color color,
    required String title,
    required String value,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 16),
            const SizedBox(width: 4),
            Text(
              title,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(Icons.monetization_on, color: Colors.amber[700], size: 16),
            const SizedBox(width: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}