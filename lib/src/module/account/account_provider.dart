import 'package:biotech_maali/import.dart';

class AccountProvider extends ChangeNotifier {
  AccountProvider() {
    getUserName();
  }

  String _userName = '';
  String get userName => _userName;

  Future<void> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userName = prefs.getString('userName') ?? "No Name";
    notifyListeners();
  }
}
