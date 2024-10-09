
import '../../../import.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar:  CustomAppBarWithSearch(),
    );
  }
}