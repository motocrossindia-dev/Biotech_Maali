import '../../../../import.dart';

class DeliveryAddressWidget extends StatelessWidget {
  const DeliveryAddressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CommonTextWidget(title: 'Deliver to:', color: Colors.grey),
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
