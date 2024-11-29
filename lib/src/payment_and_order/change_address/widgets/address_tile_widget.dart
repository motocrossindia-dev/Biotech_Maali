import 'package:biotech_maali/src/payment_and_order/widget/edit_button_widget.dart';

import '../../../../import.dart';

class AddressTileWidget extends StatelessWidget {
  const AddressTileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CommonTextWidget(title: 'Deliver to:', color: Colors.grey),
            EditButtonWidget(
              title: 'Edit',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                         const AddEditAddressScreen(isAddAddress: false),
                  ),
                );
              },
            )
          ],
        ),
        Row(
          children: [
            const CommonTextWidget(
              title: 'Mallikjan Baroodwale',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            sizedBoxWidth5,
            Container(
              decoration: BoxDecoration(
                  color: cLightGreyHomeWork,
                  borderRadius: BorderRadius.circular(2)),
              child: const Padding(
                padding: EdgeInsets.all(2.0),
                child: CommonTextWidget(
                  title: 'Home',
                  fontSize: 12,
                ),
              ),
            )
          ],
        ),
        const CommonTextWidget(
            title: 'Mahaboon ngar 4th cross Yallapur oni\nHubli'),
        sizedBoxHeight05,
        const CommonTextWidget(title: '8884981840'),
      ],
    );
  }
}
