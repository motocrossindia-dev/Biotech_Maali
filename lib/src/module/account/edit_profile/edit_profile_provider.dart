import 'package:biotech_maali/import.dart';

class EditProfileProvider extends ChangeNotifier {
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController emailAddress = TextEditingController();
  final TextEditingController mobileNumber = TextEditingController();

  String _selectedGender = 'Male';
  String get selectedGender => _selectedGender;

  void selectGender(String gender) {
    _selectedGender = gender;
    notifyListeners();
  }

  
}
