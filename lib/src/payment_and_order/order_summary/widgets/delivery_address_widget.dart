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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CommonTextWidget(
                    title: 'Deliver to:', color: Colors.grey),
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
                )
              ],
            ),
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
                      borderRadius: BorderRadius.circular(2)),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: CommonTextWidget(
                      title: selectedAddress.addressType,
                      fontSize: 12,
                    ),
                  ),
                )
              ],
            ),
            CommonTextWidget(
                title:
                    '${selectedAddress.address} ${selectedAddress.city} ${selectedAddress.state} '),
            sizedBoxHeight05,
            CommonTextWidget(title: '${selectedAddress.pincode}'),
          ],
        );
      },
    );
  }
}
