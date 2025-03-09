import 'package:biotech_maali/src/module/account/refer_friend/refer_friend_screen.dart';

import '../../../../import.dart';

class ReferFriendWidget extends StatelessWidget {
  const ReferFriendWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 280,
          width: double.infinity,
          child: Image.asset(
            'assets/png/images/home_screen_img_1.jpg',
            fit: BoxFit.fill,
          ),
        ),
        Container(
          height: 184,
          width: double.infinity,
          color: cReferFriendsHome,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Center(
                child: CommonTextWidget(
                  title: 'Join our Plant Parent Rewards Club',
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Center(
                child: CommonTextWidget(
                  title:
                      'Every plant purchase is a gift that keeps on giving. Earn coins and redeem them for exclusive discounts.',
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 38,
                    width: 147,
                    child: BorderColoredButton(
                      title: 'Learn More',
                      event: () {},
                      height: 38,
                    ),
                  ),
                  SizedBox(
                    height: 38,
                    width: 150,
                    child: CommonButtonWidget(
                      title: 'Refer A Friend',
                      event: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ReferFriendScreen(),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
