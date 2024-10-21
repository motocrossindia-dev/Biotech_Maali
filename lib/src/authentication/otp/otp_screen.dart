import '../../../import.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              sizedBoxHeight70,
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/png/biotech_logo.png',
                      height: 62,
                      width: 120,
                    ),
                    sizedBoxHeight50,
                    SvgPicture.asset(
                      'assets/svg/otp_screen_pic.svg',
                      height: 240,
                      width: 210,
                    ),
                  ],
                ),
              ),
              sizedBoxHeight50,
               CommonTextWidget(
                title: 'Verification',
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
               CommonTextWidget(
                title: 'Enter verification code',
                fontSize: 18,
                fontWeight: FontWeight.w300,
              ),
              sizedBoxHeight25,
              const PinputWidget(),
              sizedBoxHeight25,
              CommonButtonWidget(
                title: 'NEXT',
                event: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
              ),
              sizedBoxHeight05,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonTextWidget(
                    title: "Didn't receive the verification OTP?",
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: cBorderGrey,
                  ),
                  sizedBoxWidth10,
                  CommonTextWidget(
                    title: 'RESEND OTP',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: cCustomRed,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
