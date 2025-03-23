import 'dart:developer';

import 'package:biotech_maali/src/authentication/otp/otp_repository.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  Future<void> validateOtp(String mobile, BuildContext context) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_otp == null || _otp!.length != 4) {
      log("Otp : $_otp");
      _errorMessage = 'Please enter a valid OTP';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      await _repository.validateOtp(mobile, _otp!, context);
      _isLoading = false;

      notifyListeners();
    } catch (e) {
      _isLoading = false;
      Fluttertoast.showToast(
          msg: e.toString(),
          backgroundColor: cDarkerRed,
          textColor: Colors.white);
      log("message:$e");
      // _errorMessage = "${e}";
      notifyListeners();
    }
  }
}
