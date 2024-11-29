import 'package:biotech_maali/src/payment_and_order/change_address/widgets/address_tile_widget.dart';

import '../../../import.dart';

class ChangeAddressScreen extends StatefulWidget {
  const ChangeAddressScreen({super.key});

  @override
  State<ChangeAddressScreen> createState() => _ChangeAddressScreenState();
}

class _ChangeAddressScreenState extends State<ChangeAddressScreen> {
  int? selectedAddressIndex;
  // Add this list to store your addresses
  final List<Address> addresses = []; // Replace with your address data

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        shadowColor: Colors.black,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: const CommonTextWidget(
          title: 'Change Address',
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          OrderTrackerTimeline(
                              currentStatus: OrderStatus.address),
                          sizedBoxHeight10,
                        ],
                      ),
                    ),
                  ),
                  sizedBoxHeight20,
                  Card(
                    color: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.add,
                            size: 30,
                            weight: 100,
                            color: cButtonGreen,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const AddEditAddressScreen(
                                    isAddAddress: true,
                                  ),
                                ),
                              );
                            },
                            child: CommonTextWidget(
                              title: "Add New Address",
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: cButtonGreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  sizedBoxHeight20,
                  // Replace the single address card with ListView.builder
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Radio<int>(
                                value: index,
                                groupValue: selectedAddressIndex,
                                activeColor: cButtonGreen,
                                onChanged: (value) {
                                  setState(() {
                                    selectedAddressIndex = value;
                                  });
                                },
                              ),
                              const Expanded(
                                child: AddressTileWidget(),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  sizedBoxHeight70,
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: 60,
              color: cWhiteColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 160,
                    height: 48,
                    child: CustomizableBorderColoredButton(
                        title: 'CANCEL', event: () {}),
                  ),
                  SizedBox(
                    width: 160,
                    height: 48,
                    child: CustomizableButton(
                      title: 'DELIVER HERE',
                      event: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => const ProductRatingScreen(),
                        //     ));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
