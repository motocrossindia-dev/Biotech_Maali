import 'package:biotech_maali/src/payment_and_order/change_address/model/address_model.dart';

import '../../../../import.dart';

class DeliveryAddressWidget extends StatelessWidget {
  const DeliveryAddressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderSummaryProvider>(
      builder: (context, provider, child) {
        AddressModel selectedAddress = provider.selectedAddress;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row with radio, "Deliver to:" text, and Change button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Left side with radio and "Deliver to:" text
                Row(
                  children: [
                    Radio<bool>(
                      value: true,
                      groupValue: provider.isAddressSelected,
                      onChanged: (value) {
                        provider.setAddressSelection(value ?? false);
                      },
                    ),
                    const CommonTextWidget(
                      title: 'Deliver to:',
                      color: Colors.grey,
                    ),
                  ],
                ),
                // Right side with Change button
                ChangeButton(
                  title: 'Change',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChangeAddressScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
            // Address details with proper padding for alignment with radio
            Padding(
              padding: const EdgeInsets.only(
                  left: 48.0), // Indent to align with "Deliver to:" text
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CommonTextWidget(
                        title:
                            '${selectedAddress.firstName} ${selectedAddress.lastName}',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      sizedBoxWidth5,
                      Container(
                        decoration: BoxDecoration(
                          color: cLightGreyHomeWork,
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: CommonTextWidget(
                            title: selectedAddress.addressType,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  sizedBoxHeight05,
                  CommonTextWidget(
                    title:
                        '${selectedAddress.address} ${selectedAddress.city} ${selectedAddress.state}',
                  ),
                  sizedBoxHeight05,
                  CommonTextWidget(title: selectedAddress.pincode.toString()),
                  // Added phone number to match the image
                  sizedBoxHeight05,
                  // CommonTextWidget(title: selectedAddress.mobileNumber),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
