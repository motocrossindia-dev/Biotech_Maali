import 'dart:developer';
import '../../../import.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = context.read<LoginProvider>();
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
                      'assets/svg/login_image.svg',
                      height: 240,
                      width: 210,
                    ),
                  ],
                ),
              ),
              sizedBoxHeight50,
              CommonTextFormWidget(
                controller: loginProvider.name,
                title: 'Enter Your Name',
                hint: ' Mallikjan',
                inputType: TextInputType.number,
              ),
              sizedBoxHeight25,
              CommonTextFormWidget(
                controller: loginProvider.referralCode,
                title: 'Enter The Referral Code(optional)',
                hint: ' RF3423875',
                inputType: TextInputType.number,
              ),
              sizedBoxHeight25,
              Padding(
                padding: const EdgeInsets.only(left:30.0,right: 30),
                child: CommonButtonWidget(
                  title: 'LOGIN',
                  event: () {
                    log('message');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BottomNavWidget(),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
