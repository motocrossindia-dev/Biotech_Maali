import '../../../../import.dart';

class DeliveryOptionsWidget extends StatefulWidget {
  const DeliveryOptionsWidget({super.key});

  @override
  State<DeliveryOptionsWidget> createState() => _DeliveryOptionsWidgetState();
}

class _DeliveryOptionsWidgetState extends State<DeliveryOptionsWidget> {


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Choose Delivery Option',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        _buildDeliveryOption('Standard'),
        _buildDeliveryOption('Express'),
      ],
    );
  }

  Widget _buildDeliveryOption(String option) {
    return Consumer<OrderSummaryProvider>(
      builder: (context, provider, child) {
        return RadioListTile(
          title: Text(option),
          value: option,
          groupValue: provider.selectedDeliveryOption,
          onChanged: (String? value) {
            provider.setDeliveryOption(value!);
          },
          activeColor: cButtonGreen,
          contentPadding: EdgeInsets.zero,
        );
      },
    );
  }
}
