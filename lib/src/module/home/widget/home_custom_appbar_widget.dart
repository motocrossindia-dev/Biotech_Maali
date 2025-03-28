import 'package:biotech_maali/core/settings_provider/settings_provider.dart';
import 'package:biotech_maali/src/module/location_popup/location_pincode_popup.dart';
import 'package:biotech_maali/src/module/location_popup/location_pincode_provider.dart';
import 'package:biotech_maali/src/module/product_search/product_search_screen.dart';
import 'package:biotech_maali/src/module/wishlist/wishlist_screen.dart';
import 'package:biotech_maali/src/payment_and_order/change_address/change_address_provider.dart';
import 'package:biotech_maali/src/widgets/login_prompt_dialog.dart';

import '../../../../import.dart';

class CustomAppBarWithSearch extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarWithSearch({super.key});

  @override
  // Increase height to accommodate content
  Size get preferredSize => const Size.fromHeight(140);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 4,
      shadowColor: Colors.black,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
      toolbarHeight: 140, // Match with preferredSize
      flexibleSpace: SafeArea(
        // Add SafeArea
        child: Column(
          children: [
            Padding(
              // Adjust top padding
              padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/png/biotech_logo.png',
                    height: 42,
                    width: 80,
                  ),
                  Consumer<HomeProvider>(
                    builder: (context, provider, child) => Row(
                      children: [
                        SvgPicture.asset(
                          'assets/svg/icons/location_icon.svg',
                          height: 22,
                          width: 22,
                        ),
                        Text(
                          'Location ${provider.pinCode}',
                          style: const TextStyle(color: Colors.black),
                        ),
                        TextButton(
                          child: const Text(
                            'CHANGE',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.black,
                            ),
                          ),
                          onPressed: () async {
                            // final changeAddressProvider =
                            //     context.read<ChangeAddressProvider>();

                            // await changeAddressProvider.fetchAllAddress();

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const LocationPincodePopup()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              // Adjust vertical padding
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 42,
                      width: 251,
                      child: TextField(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProductSearchView(),
                            ),
                          );
                        },
                        decoration: InputDecoration(
                          filled:
                              true, // This line is necessary to show the fill color
                          fillColor: cSearchBox, // Your custom color
                          hintStyle: GoogleFonts.poppins(fontSize: 12),
                          hintText: 'Search for "plants"',
                          prefixIcon: const Icon(Icons.search, size: 22),
                          suffixIcon: IconButton(
                            icon: SvgPicture.asset(
                              'assets/svg/icons/microphone.svg',
                              height: 20,
                              width: 20,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ProductSearchView(),
                                ),
                              );
                              // Handle microphone button press
                            },
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 16),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: SvgPicture.asset(
                      'assets/svg/icons/heart_unselected.svg',
                      height: 24,
                      width: 24,
                    ),
                    onPressed: () async {
                      final settingsProvider = context.read<SettingsProvider>();
                      bool status = await settingsProvider
                          .checkAccessTokenValidity(context);
                      if (!status) {
                        _showLoginDialog(context);
                        return;
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WishlistScreen(),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: SvgPicture.asset(
                      'assets/svg/icons/notification_unselected.svg',
                      height: 24,
                      width: 24,
                    ),
                    onPressed: () {
                      // Handle notification button press
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const LoginPromptDialog();
      },
    );
  }
}
