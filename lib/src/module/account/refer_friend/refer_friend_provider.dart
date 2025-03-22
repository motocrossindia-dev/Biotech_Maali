import 'package:biotech_maali/import.dart';

class ReferFriendProvider extends ChangeNotifier {
  final TextEditingController _referralCode = TextEditingController();
  TextEditingController get referralCode => _referralCode;
}
