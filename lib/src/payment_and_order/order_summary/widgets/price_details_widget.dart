import '../../../../import.dart';

class PriceDetailsWidget extends StatelessWidget {
  const PriceDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Price Details',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _buildPriceRow('Price (3 items)', '₹7899.00'),
        _buildPriceRow('Discount', '-₹266.00', isGreen: true),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildPriceRow('Delivery Charges', '', ),
             const Row(children: [
              CommonTextWidget(title: '₹80',lineThrough: TextDecoration.lineThrough,),
              sizedBoxWidth5,
              CommonTextWidget(title: 'Free',color: Colors.green,)
             ],)
          ],
        ),
       
        _buildPriceRow('secured Packaging Fee', '₹198'),
        const Divider(thickness: 1),
        _buildPriceRow('Total Amount', '₹7899.00', isBold: true),
        const SizedBox(height: 8),
        const Text(
          'You will save ₹9,811 on this order',
          style: TextStyle(color: Colors.green),
        ),
      ],
    );
  }

  Widget _buildPriceRow(String label, String amount,
      {bool isGreen = false, bool isStrike = false, bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            amount,
            style: TextStyle(
              color: isGreen ? Colors.green : null,
              decoration: isStrike ? TextDecoration.lineThrough : null,
              fontWeight: isBold ? FontWeight.bold : null,
            ),
          ),
        ],
      ),
    );
  }
}