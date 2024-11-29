import '../../../../import.dart';

class DeliveryOptionsWidget extends StatefulWidget {
  const DeliveryOptionsWidget({super.key});

  @override
  State<DeliveryOptionsWidget> createState() => _DeliveryOptionsWidgetState();
}

class _DeliveryOptionsWidgetState extends State<DeliveryOptionsWidget> {
  String selectedOption = 'Standard(₹000.00)';

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
        _buildDeliveryOption('Standard(₹000.00)'),
        _buildDeliveryOption('Express Way(₹000.00)'),
      ],
    );
  }

  Widget _buildDeliveryOption(String option) {
    return RadioListTile(
      title: Text(option),
      value: option,
      groupValue: selectedOption,
      onChanged: (String? value) {
        setState(() {
          selectedOption = value!;
        });
      },
      activeColor: cButtonGreen,
      contentPadding: EdgeInsets.zero,
    );
  }
}