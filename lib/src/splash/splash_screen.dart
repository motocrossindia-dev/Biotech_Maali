import 'package:biotech_maali/src/splash/error/error_screen.dart';
import 'package:biotech_maali/src/splash/splash_provider.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../import.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<String> _getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return 'Version - ${packageInfo.version}';
  }

  @override
  Widget build(BuildContext context) {
    SplashProvider(context: context);
    return Consumer<SplashProvider>(
      builder: (context, splashProvider, child) {
        splashProvider.navigateToHomeScreen(context);
        if (splashProvider.isLoading) {
          return Scaffold(
            body: SafeArea(
              child: Stack(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/png/biotech_logo.png',
                      height: 101,
                      width: 194,
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 32,
                    child: Center(
                      child: FutureBuilder<String>(
                        future: _getAppVersion(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return CommonTextWidget(
                              title: snapshot.data!,
                              color: Colors.grey,
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // Handle navigation after state is updated
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (splashProvider.navigationTarget == "home") {
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => const BottomNavWidget(),
            //   ),
            // );
          } else if (splashProvider.navigationTarget == "login") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const MobileNumberScreen(),
              ),
            );
          } else if (splashProvider.navigationTarget == "error") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const ErrorScreen(),
              ),
            );
          }
        });

        // Placeholder widget while navigationTarget is being determined
        return Scaffold(
          body: Column(
            children: [
              Center(
                child: Image.asset(
                  'assets/png/biotech_logo.png',
                  height: 101,
                  width: 194,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
