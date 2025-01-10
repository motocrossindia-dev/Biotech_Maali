import 'package:biotech_maali/import.dart';

class LoginProvider extends ChangeNotifier {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _referralCode = TextEditingController();
  final TextEditingController _emailId = TextEditingController();

  TextEditingController get name => _name;
  TextEditingController get referralCode => _referralCode;
  TextEditingController get emailId => _emailId;
}
