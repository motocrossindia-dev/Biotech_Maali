import 'package:biotech_maali/src/splash/error/error_screen.dart';
import 'package:biotech_maali/src/splash/splash_provider.dart';
import '../../import.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SplashProvider(context: context);
    return Consumer<SplashProvider>(
      builder: (context, splashProvider, child) {
        splashProvider.navigateToHomeScreen(context);
        if (splashProvider.isLoading) {
          // Show Splash Screen with loading spinner
          return Scaffold(
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/png/biotech_logo.png',
                      height: 101,
                      width: 194,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        }

        // Handle navigation after state is updated
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (splashProvider.navigationTarget == "home") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const BottomNavWidget(),
              ),
            );
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
          body: Center(
            child: Image.asset(
              'assets/png/biotech_logo.png',
              height: 101,
              width: 194,
            ),
          ),
        );
      },
    );
  }
}
