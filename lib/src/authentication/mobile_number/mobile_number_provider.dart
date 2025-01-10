import 'dart:developer';

import '../../../import.dart';

class MobileNumberProvider extends ChangeNotifier {
  final TextEditingController _mobileNumber = TextEditingController();
  TextEditingController get mobileNumber => _mobileNumber;

  final MobileNumberRepository _mobileNumberRepository =
      MobileNumberRepository();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> registerMobile(BuildContext context) async {
    if (_mobileNumber.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter mobile number')),
      );
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final response =
          await _mobileNumberRepository.registerWithMobile(_mobileNumber.text);
      _isLoading = false;
      
      notifyListeners();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const OtpScreen()),
      );
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      log("Error : $e");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration failed: $e')),
      );
    }
  }
}
