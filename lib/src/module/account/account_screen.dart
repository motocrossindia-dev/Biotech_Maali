import 'package:biotech_maali/src/module/account/account_provider.dart';
import 'package:biotech_maali/src/module/account/gift_card/gift_card_screen.dart';
import 'package:biotech_maali/src/module/account/refer_friend/refer_friend_screen.dart';
import 'package:biotech_maali/src/module/account/track_order/track_order_screen.dart';
import 'package:biotech_maali/src/module/account/wallet/wallet_screen.dart';
import 'package:biotech_maali/src/other_modules/carrers/carrers_screen.dart';
import 'package:biotech_maali/src/other_modules/contact_us/contact_us_screen.dart';
import 'package:biotech_maali/src/other_modules/franchise_enquiry/franchise_enquiry_screen.dart';
import 'package:biotech_maali/src/other_modules/our_store/our_store_screen.dart';
import 'package:biotech_maali/src/other_modules/out_works/our_work_screen.dart';
import 'package:biotech_maali/src/other_modules/services/services_screen.dart';
import 'package:biotech_maali/src/payment_and_order/order_history/order_history_screen.dart';

import '../../../import.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cScaffoldBackground,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 4,
        shadowColor: Colors.black,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        toolbarHeight: 80,
        title: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/png/biotech_logo.png',
                height: 42,
                width: 80,
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      sizedBoxHeight20,
                      Card(
                        // borderOnForeground: true,
                        shape: const Border(
                          bottom: BorderSide(style: BorderStyle.none),
                        ),
                        color: cWhiteColor,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          // ignore: avoid_unnecessary_containers
                          child: Container(
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/svg/icons/account_person.svg',
                                  height: 50,
                                  width: 50,
                                ),
                                sizedBoxWidth15,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const CommonTextWidget(
                                      title: 'Hello',
                                      fontSize: 12,
                                    ),
                                    Consumer<AccountProvider>(
                                      builder:
                                          (context, accountProvider, child) {
                                        return CommonTextWidget(
                                          title: accountProvider.userName,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      sizedBoxHeight20,
                      Card(
                        shape: const Border(
                          bottom: BorderSide(style: BorderStyle.none),
                        ),
                        color: cWhiteColor,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const OrderHistoryScreen(),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/svg/icons/my_orders.svg',
                                          height: 25,
                                          width: 25,
                                        ),
                                        sizedBoxWidth20,
                                        CommonTextWidget(
                                          title: 'MY ORDERS',
                                          color: cAccountText,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.chevron_right,
                                      size: 30,
                                      color: cAccountText,
                                    )
                                  ],
                                ),
                              ),
                              sizedBoxHeight30,
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/svg/icons/my_account_icon.svg',
                                    height: 25,
                                    width: 25,
                                  ),
                                  sizedBoxWidth20,
                                  CommonTextWidget(
                                    title: 'ACCOUNT SETTINGS',
                                    color: cAccountText,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                              sizedBoxHeight20,
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const EditProfileScreen(),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Row(
                                      children: [
                                        sizedBoxWidth25,
                                        sizedBoxWidth20,
                                        CommonTextWidget(
                                          title: 'My Profile',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.chevron_right,
                                      size: 30,
                                      color: cAccountText,
                                    )
                                  ],
                                ),
                              ),
                              sizedBoxHeight10,
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const TrackOrderScreen(),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Row(
                                      children: [
                                        sizedBoxWidth25,
                                        sizedBoxWidth20,
                                        CommonTextWidget(
                                          title: 'Track Order',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.chevron_right,
                                      size: 30,
                                      color: cAccountText,
                                    )
                                  ],
                                ),
                              ),
                              sizedBoxHeight10,
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const AddEditAddressScreen(
                                        isFromAccount: true,
                                        isAddAddress: true,
                                      ),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Row(
                                      children: [
                                        sizedBoxWidth25,
                                        sizedBoxWidth20,
                                        CommonTextWidget(
                                          title: 'Add Address',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.chevron_right,
                                      size: 30,
                                      color: cAccountText,
                                    )
                                  ],
                                ),
                              ),
                              sizedBoxHeight35,
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/svg/icons/my_wallet.svg',
                                    height: 25,
                                    width: 25,
                                  ),
                                  sizedBoxWidth20,
                                  CommonTextWidget(
                                    title: 'PAYMENTS',
                                    color: cAccountText,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                              sizedBoxHeight20,
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const WalletScreen(),
                                    ),
                                  );
                                },
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        sizedBoxWidth25,
                                        sizedBoxWidth20,
                                        CommonTextWidget(
                                          title: 'Wallet',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ],
                                    ),
                                    CommonTextWidget(
                                      title: '₹0',
                                      color: Colors.green,
                                      fontSize: 16,
                                    ),
                                  ],
                                ),
                              ),
                              sizedBoxHeight35,
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/svg/icons/my_account_icon.svg',
                                    height: 25,
                                    width: 25,
                                  ),
                                  sizedBoxWidth20,
                                  CommonTextWidget(
                                    title: 'MY STUFF',
                                    color: cAccountText,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                              sizedBoxHeight20,
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ReferFriendScreen(),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Row(
                                      children: [
                                        sizedBoxWidth25,
                                        sizedBoxWidth20,
                                        CommonTextWidget(
                                          title: 'My Refferals',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.chevron_right,
                                      size: 30,
                                      color: cAccountText,
                                    )
                                  ],
                                ),
                              ),
                              sizedBoxHeight10,
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const GiftCardScreen(),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Row(
                                      children: [
                                        sizedBoxWidth25,
                                        sizedBoxWidth20,
                                        CommonTextWidget(
                                          title: 'My Gift Card',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.chevron_right,
                                      size: 30,
                                      color: cAccountText,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      sizedBoxHeight20,
                    ],
                  ),
                ),
                CustomButtonWidget(
                  onPressedCallBack: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  FranchiseScreen(),
                      ),
                    );
                  },
                  title: 'Franchise Enquiry',
                ),
                CustomButtonWidget(
                  onPressedCallBack: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OurWorkScreen(),
                      ),
                    );
                  },
                  title: 'Our Work',
                ),
                CustomButtonWidget(
                  onPressedCallBack: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ServicesScreen(),
                      ),
                    );
                  },
                  title: 'Services',
                ),
                CustomButtonWidget(
                  onPressedCallBack: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CarrersScreen(),
                      ),
                    );
                  },
                  title: 'Carriers',
                ),
                CustomButtonWidget(
                  onPressedCallBack: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OurStoresScreen(),
                      ),
                    );
                  },
                  title: 'Our Stores',
                ),
                CustomButtonWidget(
                  onPressedCallBack: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ContactScreen(),
                      ),
                    );
                  },
                  title: 'Contact Us',
                ),
                CustomButtonWidget(
                  onPressedCallBack: () {},
                  title: 'Terms Of Services',
                ),
                CustomButtonWidget(
                  onPressedCallBack: () {},
                  title: 'Privacy Policy',
                ),
                CustomButtonWidget(
                  onPressedCallBack: () {},
                  title: 'Shipping Policy',
                ),
                CustomButtonWidget(
                  onPressedCallBack: () {},
                  title: 'Return Policy',
                ),
                CustomButtonWidget(
                  onPressedCallBack: () {},
                  title: 'FAQ’s',
                ),
                sizedBoxHeight70
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: MaterialButton(
                  color: cScaffoldBackground,
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.remove('access_token');
                    await prefs.remove('refresh_token');
                    final navProvider = context.read<BottomNavProvider>();
                    navProvider.updateIndex(0);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MobileNumberScreen(),
                      ),
                    );
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(5), // Set the border radius here
                    side: const BorderSide(
                      color: Colors.red, // Set the border color here
                      width: 2, // Set the border width
                    ),
                  ),
                  child: CommonTextWidget(
                    fontWeight: FontWeight.w500,
                    title: 'LOGOUT',
                    color: cButtonRed,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
