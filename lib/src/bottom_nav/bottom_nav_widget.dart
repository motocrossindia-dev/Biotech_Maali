import '../../import.dart';

class BottomNavWidget extends StatelessWidget {
  const BottomNavWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Consumer<BottomNavProvider>(
        builder: (context, bottomNavProvider, child) {
          switch (bottomNavProvider.currentIndex) {
            case 0:
              return const HomeScreen();
            case 1:
              return const ExploreScreen();
            case 2:
              return const ScanScreen();
            case 3:
              return const CartScreen();
            case 4:
              return const AccountScreen();
            default:
              return const HomeScreen();
          }
        },
      ),
      bottomNavigationBar: Consumer<BottomNavProvider>(
        builder: (context, bottomNavProvider, child) {
          return BottomNavigationBar(
            currentIndex: bottomNavProvider.currentIndex,
            onTap: (index) => bottomNavProvider.updateIndex(index),
            type: BottomNavigationBarType.fixed,
            selectedItemColor: cBottomNav,
            unselectedItemColor: cBottomNav,
            selectedLabelStyle:
                GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.bold),
            unselectedLabelStyle: GoogleFonts.poppins(fontSize: 10),
            backgroundColor: cAppBackround,
            items: [
              BottomNavigationBarItem(
                icon: bottomNavProvider.currentIndex == 0
                    ? Column(
                        children: [
                          SvgPicture.asset(
                            "assets/svg/bottom_nav_bar/navbar_selected_line.svg",
                            colorFilter:
                                ColorFilter.mode(cBottomNav, BlendMode.srcIn),
                            height: 4,
                            width: 31,
                          ),
                          sizedBoxHeight08,
                          SvgPicture.asset(
                            "assets/svg/bottom_nav_bar/icon_home_selected.svg",
                            colorFilter:
                                ColorFilter.mode(cBottomNav, BlendMode.srcIn),
                            height: 24,
                            width: 24,
                          ),
                        ],
                      )
                    : SvgPicture.asset(
                        "assets/svg/bottom_nav_bar/icon_home_unselected.svg",
                        colorFilter:
                            ColorFilter.mode(cBottomNav, BlendMode.srcIn),
                        height: 24,
                        width: 24,
                      ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: bottomNavProvider.currentIndex == 1
                    ? Column(
                        children: [
                          SvgPicture.asset(
                            "assets/svg/bottom_nav_bar/navbar_selected_line.svg",
                            colorFilter:
                                ColorFilter.mode(cBottomNav, BlendMode.srcIn),
                            height: 4,
                            width: 31,
                          ),
                          sizedBoxHeight08,
                          SvgPicture.asset(
                            "assets/svg/bottom_nav_bar/icon_category_selected.svg",
                            colorFilter:
                                ColorFilter.mode(cBottomNav, BlendMode.srcIn),
                            height: 24,
                            width: 24,
                          ),
                        ],
                      )
                    : SvgPicture.asset(
                        "assets/svg/bottom_nav_bar/icon_category_unselected.svg",
                        colorFilter:
                            ColorFilter.mode(cBottomNav, BlendMode.srcIn),
                        height: 24,
                        width: 24,
                      ),
                label: 'Explore',
              ),
              BottomNavigationBarItem(
                icon: bottomNavProvider.currentIndex == 2
                    ? Column(
                        children: [
                          SvgPicture.asset(
                            "assets/svg/bottom_nav_bar/navbar_selected_line.svg",
                            colorFilter:
                                ColorFilter.mode(cBottomNav, BlendMode.srcIn),
                            height: 4,
                            width: 31,
                          ),
                          sizedBoxHeight08,
                          SvgPicture.asset(
                            "assets/svg/bottom_nav_bar/icon_scan.svg",
                            colorFilter:
                                ColorFilter.mode(cBottomNav, BlendMode.srcIn),
                            height: 24,
                            width: 24,
                          ),
                        ],
                      )
                    : SvgPicture.asset(
                        "assets/svg/bottom_nav_bar/icon_scan.svg",
                        colorFilter:
                            ColorFilter.mode(cBottomNav, BlendMode.srcIn),
                        height: 24,
                        width: 24,
                      ),
                label: 'Scan',
              ),
              BottomNavigationBarItem(
                icon: bottomNavProvider.currentIndex == 3
                    ? Column(
                        children: [
                          SvgPicture.asset(
                            "assets/svg/bottom_nav_bar/navbar_selected_line.svg",
                            colorFilter:
                                ColorFilter.mode(cBottomNav, BlendMode.srcIn),
                            height: 4,
                            width: 31,
                          ),
                          sizedBoxHeight08,
                          SvgPicture.asset(
                            "assets/svg/bottom_nav_bar/icon_cart_selected.svg",
                            colorFilter:
                                ColorFilter.mode(cBottomNav, BlendMode.srcIn),
                            height: 24,
                            width: 24,
                          ),
                        ],
                      )
                    : SvgPicture.asset(
                        "assets/svg/bottom_nav_bar/icon_cart_unselected.svg",
                        colorFilter:
                            ColorFilter.mode(cBottomNav, BlendMode.srcIn),
                        height: 24,
                        width: 24,
                      ),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: bottomNavProvider.currentIndex == 4
                    ? Column(
                        children: [
                          SvgPicture.asset(
                            "assets/svg/bottom_nav_bar/navbar_selected_line.svg",
                            colorFilter:
                                ColorFilter.mode(cBottomNav, BlendMode.srcIn),
                            height: 4,
                            width: 31,
                          ),
                          sizedBoxHeight08,
                          SvgPicture.asset(
                            "assets/svg/bottom_nav_bar/icon_user_selected.svg",
                            colorFilter:
                                ColorFilter.mode(cBottomNav, BlendMode.srcIn),
                            height: 24,
                            width: 24,
                          ),
                        ],
                      )
                    : SvgPicture.asset(
                        "assets/svg/bottom_nav_bar/icon_user_unselected.svg",
                        colorFilter:
                            ColorFilter.mode(cBottomNav, BlendMode.srcIn),
                        height: 24,
                        width: 24,
                      ),
                label: 'Account',
              ),
            ],
          );
        },
      ),
    );
  }
}
