import 'dart:developer';

import 'package:biotech_maali/src/authentication/otp/otp_repository.dart';

import '../../../import.dart';

class OtpProvider extends ChangeNotifier {
  final OtpRepository _repository = OtpRepository();
  bool _isLoading = false;
  String _errorMessage = '';
  String? _otp;

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  String? get otp => _otp;

  void setOtp(String value) {
    _otp = value;
    notifyListeners();
  }

  Future<bool> validateOtp(String mobile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_otp == null || _otp!.length != 4) {
      log("Otp : $_otp");
      _errorMessage = 'Please enter a valid OTP';
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final result = await _repository.validateOtp(mobile, _otp!);
      _isLoading = false;
      if (!result) {
        _errorMessage = 'Invalid OTP. Please try again.';
      } else if (result) {
        prefs.setBool("isAuthenticated", true);
      }
      notifyListeners();
      return result;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to validate OTP. Please try again.';
      notifyListeners();
      return false;
    }
  }
}
