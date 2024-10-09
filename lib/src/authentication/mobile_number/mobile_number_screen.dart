import 'dart:developer';

import '../../../import.dart';

class MobileNumberScreen extends StatelessWidget {
  const MobileNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = context.read<MobileNumberProvider>();
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  children: [
                    sizedBoxHeight70,
                    Image.asset(
                      'assets/png/biotech_logo.png',
                      height: 62,
                      width: 120,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    SvgPicture.asset(
                      'assets/svg/mobile_screen_pic.svg',
                      height: 240,
                      width: 210,
                    ),
                  ],
                ),
              ),
              sizedBoxHeight50,
              sizedBoxHeight70,
              CommonTextFormWidget(
                controller: loginProvider.mobileNumber,
                title: 'Enter Your Mobile Number',
                hint: '   +91 8884981840',
                inputType: TextInputType.number,
              ),
          
              sizedBoxHeight25,
              CommonButtonWidget(
                title: 'GET OTP',
                event: () {
                  log('message');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OtpScreen(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
