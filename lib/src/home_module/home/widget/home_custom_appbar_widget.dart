import '../../../../import.dart';

class CustomAppBarWithSearch extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarWithSearch({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(130);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 4,
      shadowColor: Colors.black,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
      flexibleSpace: Column(
        children: [
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
                TextButton.icon(
                  onPressed: () {
                    // Handle location change
                  },
                  icon: const Icon(Icons.location_on, color: Colors.black),
                  label: const Text(
                    'Location 590019 CHANGE',
                    style: TextStyle(color: Colors.black),
                  ),
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
                          prefixIcon: const Icon(Icons.search, size: 20),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.mic, size: 18),
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
                  icon: const Icon(Icons.favorite_border),
                  onPressed: () {
                    // Handle favorite button press
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.notifications_none),
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
