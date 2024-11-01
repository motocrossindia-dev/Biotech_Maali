import '../../../../import.dart';

class CustomAppBarWithSearch extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarWithSearch({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(130);

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 4,
      shadowColor: Colors.black,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
      flexibleSpace: Column(
        children: [
          // Container(
          //   height: 40,
          //   decoration: BoxDecoration(
          //       gradient: LinearGradient(colors: [gcHomeBox, gcHomeBox2])),
          //   child: Padding(
          //     padding: const EdgeInsets.only(left:  22.0, right:  22),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Text('data',style: TextStyle(color: cWhiteColor),),
          //         Container(height: 23,width: 82,
          //           decoration: BoxDecoration(color: cButtonGreen,borderRadius: BorderRadius.circular(5)),
          //           child: Container(),
          //         )
          //       ],
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/png/biotech_logo.png',
                  height: 42,
                  width: 80,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svg/icons/location_icon.svg',
                      height: 22,
                      width: 22,
                    ),
                    const Text(
                      'Location 590019',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextButton(
                      child: const Text(
                        'CHANGE',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.black,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                      height: 42,
                      width: 251,
                      child: TextField(
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
                      )),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: SvgPicture.asset(
                    'assets/svg/icons/heart_unselected.svg',
                    height: 24,
                    width: 24,
                  ),
                  onPressed: () {
                    // Handle favorite button press
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
    );
  }
}
