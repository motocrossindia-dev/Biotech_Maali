import '../../import.dart';

class MobileNumberScreen extends StatelessWidget {
  const MobileNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = context.read<MobileNumberProvider>();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                Image.asset(
                  'assets/png/biotech_logo.png',
                  height: 62,
                  width: 120,
                ),
                const SizedBox(
                  height: 50,
                ),
                SvgPicture.asset(
                  'assets/svg/Login Screen Image.svg',
                  height: 240,
                  width: 210,
                ),
              ],
            ),
          ),
          // Text('Varification',
          //     style: GoogleFonts.poppins(
          //         fontSize: 24, fontWeight: FontWeight.w500)),
          CommonTextFormWidget(
            controller: loginProvider.mobileNumber,
            title: 'Enter Your Mobile Number',
          ),

          const CommonButtonWidget(title: 'title')
        ],
      ),
    );
  }
}
